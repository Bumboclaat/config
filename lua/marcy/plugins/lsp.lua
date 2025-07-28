return {

  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim" },
    { "mason-org/mason-lspconfig.nvim" },
    { "saghen/blink.cmp" },
  },

  config = function()
    local lsp_config = require("lspconfig")

    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
      nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      nmap("<leader>f", vim.lsp.buf.format, "[F]ormat")
      nmap("<leader>nc", "<Cmd>:Telescope neoclip<CR>")
      nmap("<leader>fb", "<Cmd>:Telescope file_browser path=%:p:h select_buffer=true<CR>")

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        if vim.lsp.buf.format then
          vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
          vim.lsp.buf.formatting()
        end
      end, { desc = "Format current buffer with LSP" })
    end

    require("mason").setup()

    local servers = {
      "bashls",
      "clangd",
      "eslint",
      "golangci_lint_ls",
      "gopls",
      "html",
      "jdtls",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "templ",
      "terraformls",
      "tflint",
      "ts_ls",
      "yamlls",
      "zls"
    }

    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_enable = false,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

    for _, server in ipairs(servers) do
      local server_config = {}

      if server == "lua_ls" then
        server_config.settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim", "require" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        }
      elseif server == "bashls" then
        server_config.settings = {
          bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
          },
        }
      elseif server == "eslint" then
        server_config.settings = {
          settings = {
            packageManager = "npm",
          },
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "svelte",
            "html",
          },
        }
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
          pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
          command = "EslintFixAll",
        })
      end

      lsp_config[server].setup(vim.tbl_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
      }, server_config))
    end

    -- setup ts_ls
    local ts_inlay_hint_options = {
      enabled = true,
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    }

    vim.lsp.config("ts_ls", {
      server = {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
        end,
      },
      root_dir = lsp_config.util.root_pattern("package.json"),
      settings = {
        typescript = { inlayHints = ts_inlay_hint_options },
        javascript = { inlayHints = ts_inlay_hint_options },
      },
    })

    lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
      on_attach = function(client)
        client.server_capabilities.semanticTokensProvider = nil
      end,
    })

    vim.lsp.config("dartls", {})
    -- setup svelte server
    vim.lsp.config("svelte", {})

    -- setup terraform lsp
    vim.lsp.config("terraformls", {})
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*.tf", "*.tfvars" },
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    vim.lsp.config("zls", {})

    vim.lsp.config("jdtls", {
      cmd = {
        "jdtls",
        "--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand("$MASON/share/jdtls/lombok.jar")),
      },
    })

    vim.lsp.config("templ", {})

    vim.lsp.config("bashls", {
      bashIde = {
        globPattern = "*@(.sh|.inc|.bash|.command)",
      },
    })
  end,
}
