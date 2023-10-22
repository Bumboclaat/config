return {
    "tpope/vim-projectionist",
    config = function()
        vim.g.projectionist_heuristics = {
            ["*"] = {
                ["src/*.ts"] = {
                    alternate = "src/{}.spec.ts",
                },
                ["src/*.spec.ts"] = {
                    alternate = "src/{}.ts",
                },
            },
        }
    end,
}

