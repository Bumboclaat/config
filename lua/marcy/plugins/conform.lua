return {
    "stevearc/conform.nvim",
    -- enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua", stop_after_first = true },
                svelte = { "oxfmt", "prettierd", stop_after_first = true },
                javascript = { "oxfmt", "prettierd", stop_after_first = true },
                typescript = { "oxfmt", "prettierd", stop_after_first = true },
                vue = { "oxfmt", "prettierd", stop_after_first = true },
                javascriptreact = { "oxfmt", "prettierd", stop_after_first = true },
                typescriptreact = { "oxfmt", "prettierd", stop_after_first = true },
                json = { "jq", stop_after_first = true },
                graphql = { "oxfmt", "prettierd", stop_after_first = true },
                markdown = { "oxfmt", "prettierd", stop_after_first = true },
                erb = { "htmlbeautifier", stop_after_first = true },
                html = { "oxfmt", "prettierd", stop_after_first = true },
                bash = { "beautysh", stop_after_first = true },
                proto = { "buf", stop_after_first = true },
                sql = { "pg_format", stop_after_first = true },
                python = { "ruff_format", stop_after_first = true },
                rust = { "rust-analyzer", stop_after_first = true },
                yaml = { "oxfmt", "prettierd", stop_after_first = true },
                toml = { "taplo", stop_after_first = true },
                css = { "oxfmt", stop_after_first = true },
                scss = { "oxfmt", stop_after_first = true },
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
                    args = { "--max-len=160", "--base-formatter=gofumpt", "--no-reformat-tags" },
                },
                pg_format = {
                    args = {
                        "--keyword-case",
                        "2",
                        "--function-case",
                        "2",
                        "--type-case",
                        "1",
                        "--spaces",
                        "4",
                        "--wrap-limit",
                        "120",
                        "--comma-end",
                        "--keep-newLine",
                        "--no-extra-line",
                        "--no-rcfile",
                    },
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
