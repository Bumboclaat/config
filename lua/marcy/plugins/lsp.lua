return {

  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  config = function()
    local lsp_config = require("lspconfig")

    -- LSP settings.
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
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

    -- Setup mason so it can manage external tooling
    require("mason").setup()

    -- Enable the following language servers
    -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
    local servers = {
      "clangd",
      "rust_analyzer",
      "pyright",
      "ts_ls",
      "lua_ls",
      "gopls",
      "tflint",
      "terraformls",
      "jdtls",
      "html",
      "zls",
      "htmx",
      "golangci_lint_ls",
      "templ",
      "bashls",
      "yamlls",
      "helm_ls",
    }

    -- Ensure the servers above are installed
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    for _, lsp in ipairs(servers) do
      lsp_config[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end

    -- anable TS inlay hints
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

    lsp_config.ts_ls.setup({
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

    -- disable semantic tokens
    lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
      on_attach = function(client)
        client.server_capabilities.semanticTokensProvider = nil
      end,
    })

    -- setup eslint server
    lsp_config.eslint.setup({
      settings = {
        packageManager = "npm",
      },
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
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
    })

    lsp_config.dartls.setup({})
    -- setup svelte server
    lsp_config.svelte.setup({})

    -- setup terraform lsp
    lsp_config.terraformls.setup({})
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*.tf", "*.tfvars" },
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    lsp_config.zls.setup({})

    lsp_config.jdtls.setup({
      cmd = {
        "jdtls",
        "--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand("$MASON/share/jdtls/lombok.jar")),
      },
    })

    lsp_config.gopls.setup({})

    lsp_config.templ.setup({})

    lsp_config.htmx.setup({})

    lsp_config.bashls.setup({
      {
        bashIde = {
          globPattern = "*@(.sh|.inc|.bash|.command)",
        },
      },
    })

    lsp_config.yamlls.setup({
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["../path/relative/to/file.yml"] = "/.github/workflows/*",
            ["/path/from/root/of/project"] = "/.github/workflows/*",
          },
        },
      },
    })

    local mason_registry = require("mason-registry")
    local yaml_ls_path = mason_registry.get_package("yaml-language-server"):get_install_path()

    lsp_config.helm_ls.setup({
      settings = {
        ["helm-ls"] = {
          yamlls = {
            path = yaml_ls_path,
          },
        },
      },
    })
  end,
}
