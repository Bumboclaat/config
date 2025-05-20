return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            quickfile = { enabled = true },
            gitbrowse = {
                ---@class snacks.gitbrowse.Config
                ---@field url_patterns? table<string, table<string, string|fun(fields:snacks.gitbrowse.Fields):string>>
                {
                    notify = true, -- show notification on open
                    -- Handler to open the url in a browser
                    ---@param url string
                    open = function(url)
                        if vim.fn.has("nvim-0.10") == 0 then
                            require("lazy.util").open(url, { system = true })
                            return
                        end
                        vim.ui.open(url)
                    end,
                    ---@type "repo" | "branch" | "file" | "commit"
                    what = "file", -- what to open. not all remotes support all types
                    branch = nil, ---@type string?
                    line_start = nil, ---@type number?
                    line_end = nil, ---@type number?
                    -- patterns to transform remotes to an actual URL
                    remote_patterns = {
                        { "^(https?://.*)%.git$",                 "%1" },
                        { "^git@(.+):(.+)%.git$",                 "https://%1/%2" },
                        { "^git@(.+):(.+)$",                      "https://%1/%2" },
                        { "^git@(.+)/(.+)$",                      "https://%1/%2" },
                        { "^ssh://git@(.*)$",                     "https://%1" },
                        { "^ssh://([^:/]+)(:%d+)/(.*)$",          "https://%1/%3" },
                        { "^ssh://([^/]+)/(.*)$",                 "https://%1/%2" },
                        { "ssh%.dev%.azure%.com/(.*)/(.*)/(.*)$", "dev.azure.com/%1/%2/_git/%3" },
                        { "^https://%w*@(.*)",                    "https://%1" },
                        { "^git@(.*)",                            "https://%1" },
                        { ":%d+",                                 "" },
                        { "%.git$",                               "" },
                    },
                    url_patterns = {
                        ["github%.com"] = {
                            branch = "/tree/{branch}",
                            file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
                            commit = "/commit/{commit}",
                        },
                        ["gitlab%.com"] = {
                            branch = "/-/tree/{branch}",
                            file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
                            commit = "/-/commit/{commit}",
                        },
                        ["bitbucket%.org"] = {
                            branch = "/src/{branch}",
                            file = "/src/{branch}/{file}#lines-{line_start}-L{line_end}",
                            commit = "/commits/{commit}",
                        },
                    },
                },
            },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    wo = { wrap = true }, -- Wrap notifications
                },
            },
            input = {
                enabled = false,
                -- your input configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
        },
        keys = {
            {
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>S",
                function()
                    Snacks.scratch.select()
                end,
                desc = "Select Scratch Buffer",
            },
            {
                "<leader>n",
                function()
                    Snacks.notifier.show_history()
                end,
                desc = "Notification History",
            },
            {
                "<leader>bd",
                function()
                    Snacks.bufdelete()
                end,
                desc = "Delete Buffer",
            },
            {
                "<leader>ba",
                function()
                    Snacks.bufdelete.all()
                end,
                desc = "Delete Buffer",
            },
            {
                "<leader>bo",
                function()
                    Snacks.bufdelete.other()
                end,
                desc = "Delete Buffer",
            },
            {
                "<leader>cR",
                function()
                    Snacks.rename.rename_file()
                end,
                desc = "Rename File",
            },
            {
                "<leader>gB",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "Git Browse",
            },
            {
                "<leader>gf",
                function()
                    Snacks.lazygit.log_file()
                end,
                desc = "Lazygit Current File History",
            },
            {
                "<leader>gg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Lazygit",
            },
            {
                "<leader>gl",
                function()
                    Snacks.lazygit.log()
                end,
                desc = "Lazygit Log (cwd)",
            },
            {
                "<leader>un",
                function()
                    Snacks.notifier.hide()
                end,
                desc = "Dismiss All Notifications",
            },
            {
                "]]",
                function()
                    Snacks.words.jump(vim.v.count1)
                end,
                desc = "Next Reference",
                mode = { "n", "t" },
            },
            {
                "[[",
                function()
                    Snacks.words.jump(-vim.v.count1)
                end,
                desc = "Prev Reference",
                mode = { "n", "t" },
            },
            {
                "<leader>N",
                desc = "Neovim News",
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = "yes",
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    })
                end,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle
                        .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                        :map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle
                        .option("background", { off = "light", on = "dark", name = "Dark Background" })
                        :map("<leader>ub")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                end,
            })
        end,
    },
}
