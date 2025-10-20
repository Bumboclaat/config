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
      "gopls",
      "html",
      "jdtls",
      "lua_ls",
      "pyright",
      "rust_analyzer",
      "tailwindcss",
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
      if server == "ts_ls" then
        goto continue
      end

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
        server_config.root_dir = lsp_config.util.root_pattern(
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
          "package.json"
        )
        server_config.settings = {
          packageManager = "npm",
        }
        server_config.filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
        }
        -- Only create autocmd if ESLint is available
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
          pattern = { "*.ts", "*.js", "*.tsx", "*.jsx", "*.vue" },
          callback = function()
            local clients = vim.lsp.get_clients({ name = "eslint" })
            if #clients > 0 then
              vim.cmd("EslintFixAll")
            end
          end,
        })
      elseif server == "gopls" then
        server_config.settings = {
          gopls = {
            buildFlags = { "-tags=unit,test,db" },
            gofumpt = true,
            ["local"] = "wildfireservice",
            -- staticcheck = true,
          }
        }
      elseif server == "vue_ls" then
        server_config.init_options = {
          typescript = {
            tsdk = vim.fn.stdpath('data') .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"
          }
        }
      end

      lsp_config[server].setup(vim.tbl_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
      }, server_config))
      ::continue::
    end

    -- TypeScript inlay hints configuration
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

    -- Configure TypeScript server with proper settings
    lsp_config.ts_ls.setup({
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        if client.name == "ts_ls" then
          -- Add workspace diagnostics if available
          local ok, workspace_diagnostics = pcall(require, "workspace-diagnostics")
          if ok then
            workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
          end
        end
      end,
      capabilities = capabilities,
      root_dir = lsp_config.util.root_pattern("package.json", "tsconfig.json", ".git"),
      settings = {
        typescript = { inlayHints = ts_inlay_hint_options },
        javascript = { inlayHints = ts_inlay_hint_options },
      },
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
            languages = { "vue" }
          }
        }
      },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
    })

    lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
      on_attach = function(client)
        client.server_capabilities.semanticTokensProvider = nil
      end,
    })

    -- TODO check if this really works
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        -- buf_request_sync defaults to a 1000ms timeout. Depending on your
        -- machine and codebase, you may want longer. Add an additional
        -- argument after params if you find that you have to write the file
        -- twice for changes to be saved.
        -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
          for _, r in pairs(res.result or {}) do
            if r.edit then
              local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
              vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
          end
        end
        vim.lsp.buf.format({ async = false })
      end
    })

    vim.lsp.config("dartls", {})

    -- setup terraform lsp
    vim.lsp.config("terraformls", {})
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*.tf", "*.tfvars" },
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    vim.lsp.config("zls", {
      cmd = { "zls" },
      filetypes = { "zig", "zir" },
      root_dir = require("lspconfig").util.root_pattern("build.zig", ".git") or vim.loop.cwd,
      single_file_support = true,
      settings = {
        zls = {
          -- Whether to enable build-on-save diagnostics
          --
          -- Further information about build-on save:
          -- https://zigtools.org/zls/guides/build-on-save/
          enable_build_on_save = true,

          -- Neovim already provides basic syntax highlighting
          semantic_tokens = "partial",
        }
      }
    })

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
