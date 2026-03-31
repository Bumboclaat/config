local disable_big_files = function(_, buf)
  local max_filesize = 50 * 1024 -- 50 KB
  local filename = vim.api.nvim_buf_get_name(buf)
  if filename == "" then
    return false
  end

  local ok, stats = pcall(vim.uv.fs_stat, filename)
  return ok and stats and stats.size > max_filesize
end

local is_big_file = function(buf)
  return disable_big_files(nil, buf or vim.api.nvim_get_current_buf())
end

local incremental_parent = function()
  if is_big_file() then
    return
  end

  local has_parser = vim.treesitter.get_parser(0, nil, { error = false }) ~= nil
  if has_parser then
    local mode = vim.api.nvim_get_mode().mode
    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
      vim.cmd.normal({ "v", bang = true })
    end
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    pcall(vim.lsp.buf.selection_range, vim.v.count1)
  end
end

local incremental_child = function()
  if is_big_file() then
    return
  end

  local has_parser = vim.treesitter.get_parser(0, nil, { error = false }) ~= nil
  if has_parser then
    local mode = vim.api.nvim_get_mode().mode
    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
      vim.cmd.normal({ "v", bang = true })
    end
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    pcall(vim.lsp.buf.selection_range, -vim.v.count1)
  end
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    local treesitter = require("nvim-treesitter")
    local ensure_installed = {
      "c",
      "cpp",
      "c_sharp",
      "go",
      "lua",
      "python",
      "rust",
      "typescript",
      "javascript",
      "terraform",
      "markdown",
      "dockerfile",
      "yaml",
      "dart",
      "comment",
      "html",
      "sql",
      "helm",
      "bash",
      "templ",
      "json",
      "prisma",
      "zig",
      "hurl",
      "vue",
    }

    treesitter.setup({})

    local use_builtin_parser = function(lang)
      for _, path in ipairs(vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", true)) do
        if path:find("/lib/nvim/parser/", 1, true) then
          pcall(vim.treesitter.language.add, lang, { path = path })
          break
        end
      end
    end

    for _, lang in ipairs({ "c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc" }) do
      use_builtin_parser(lang)
    end

    local installed_parsers = {}
    for _, parser in ipairs(treesitter.get_installed("parsers")) do
      installed_parsers[parser] = true
    end

    local missing_parsers = {}
    for _, lang in ipairs(ensure_installed) do
      if not installed_parsers[lang] then
        table.insert(missing_parsers, lang)
      end
    end

    if #missing_parsers > 0 and vim.fn.executable("tree-sitter") == 1 then
      treesitter.install(missing_parsers)
    end

    vim.treesitter.language.register("gotmpl", { "gohtmltmpl", "gotexttmpl", "gotmpl" })

    local ts_group = vim.api.nvim_create_augroup("marcy_treesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = ts_group,
      callback = function(event)
        if is_big_file(event.buf) then
          return
        end

        pcall(vim.treesitter.start, event.buf)
        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select_textobject = function(query)
      if is_big_file() then
        return
      end
      require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
    end

    local move_textobject = function(method, query)
      if is_big_file() then
        return
      end
      require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
    end

    local swap_textobject = function(method, query)
      if is_big_file() then
        return
      end
      require("nvim-treesitter-textobjects.swap")[method](query)
    end

    for _, mode in ipairs({ "x", "o" }) do
      vim.keymap.set(mode, "aa", function()
        select_textobject("@parameter.outer")
      end)
      vim.keymap.set(mode, "ia", function()
        select_textobject("@parameter.inner")
      end)
      vim.keymap.set(mode, "af", function()
        select_textobject("@function.outer")
      end)
      vim.keymap.set(mode, "if", function()
        select_textobject("@function.inner")
      end)
      vim.keymap.set(mode, "ac", function()
        select_textobject("@class.outer")
      end)
      vim.keymap.set(mode, "ic", function()
        select_textobject("@class.inner")
      end)
    end

    for _, mode in ipairs({ "n", "x", "o" }) do
      vim.keymap.set(mode, "]m", function()
        move_textobject("goto_next_start", "@function.outer")
      end)
      vim.keymap.set(mode, "]]", function()
        move_textobject("goto_next_start", "@class.outer")
      end)
      vim.keymap.set(mode, "]M", function()
        move_textobject("goto_next_end", "@function.outer")
      end)
      vim.keymap.set(mode, "][", function()
        move_textobject("goto_next_end", "@class.outer")
      end)
      vim.keymap.set(mode, "[m", function()
        move_textobject("goto_previous_start", "@function.outer")
      end)
      vim.keymap.set(mode, "[[", function()
        move_textobject("goto_previous_start", "@class.outer")
      end)
      vim.keymap.set(mode, "[M", function()
        move_textobject("goto_previous_end", "@function.outer")
      end)
      vim.keymap.set(mode, "[]", function()
        move_textobject("goto_previous_end", "@class.outer")
      end)
    end

    vim.keymap.set("n", "<leader>a", function()
      swap_textobject("swap_next", "@parameter.inner")
    end)
    vim.keymap.set("n", "<leader>A", function()
      swap_textobject("swap_previous", "@parameter.inner")
    end)

    vim.keymap.set({ "n", "x" }, "<c-space>", incremental_parent)
    vim.keymap.set({ "n", "x" }, "<c-s>", incremental_parent)
    vim.keymap.set({ "n", "x" }, "<c-backspace>", incremental_child)
  end,
}
