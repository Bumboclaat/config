return {
    "stevearc/conform.nvim",
    -- enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua", stop_after_first = true },
                svelte = { "prettierd", "prettier", stop_after_first = true },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                vue = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                json = { "jq", stop_after_first = true },
                graphql = { "prettierd", "prettier", stop_after_first = true },
                markdown = { "prettierd", "prettier", stop_after_first = true },
                erb = { "htmlbeautifier", stop_after_first = true },
                html = { "prettierd", "prettier", stop_after_first = true },
                bash = { "beautysh", stop_after_first = true },
                proto = { "buf", stop_after_first = true },
                rust = { "rust-analyzer", stop_after_first = true },
                yaml = { "prettierd", "prettier", stop_after_first = true },
                toml = { "taplo", stop_after_first = true },
                css = { "stylelint", stop_after_first = true },
                scss = { "stylelint", stop_after_first = true },
                terraform = { "terraform_fmt" },
                go = { "golines" },
            },
            formatters = {
                stylelint = {
                    args = { "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
                },
                ["vue-tsc"] = {
                    command = "vue-tsc",
                    args = { "--noEmit", "--pretty", "$FILENAME" },
                    stdin = false,
                },
                golines = {
                    args = { "--max-len=140", "--base-formatter=gofumpt" },
                },
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
