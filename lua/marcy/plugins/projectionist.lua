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
                ["src/main/java/*.java"] = {
                    alternate = "src/test/java/{}Test.java"
                },
                ["src/test/java/*.java"] = {
                    alternate = "src/main/java/{}.java"
                },
            }
        }
    end,
}
