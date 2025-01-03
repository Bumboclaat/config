return {
    "stevearc/conform.nvim",
    -- enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                svelte = { "prettierd", "prettier" },
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                json = { "jq" },
                graphql = { "prettierd", "prettier" },
                java = { "google-java-format" },
                kotlin = { "ktlint" },
                ruby = { "standardrb" },
                markdown = { { "prettierd", "prettier" } },
                erb = { "htmlbeautifier" },
                html = { "prettierd", "prettier" },
                bash = { "beautysh" },
                proto = { "buf" },
                rust = { "rust-analyzer" },
                yaml = { "yamlfix" },
                toml = { "taplo" },
                css = { "prettierd", "prettier" },
                scss = { "prettierd", "prettier" },
                terraform = { "terraform_fmt", "terraform_fmt" },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>ff", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
