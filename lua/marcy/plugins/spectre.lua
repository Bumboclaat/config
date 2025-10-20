return {
    enabled = false,
    'nvim-pack/nvim-spectre',
    config = function()
        require('spectre').setup({
            highlight = {
                ui = "DiagnosticWarn",
                search = "DiagnosticError",
                replace = "String"
            },
            mapping = {
                ['send_to_qf'] = {
                    map = "<C-q>",
                    cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                    desc = "send all items to quickfix"
                },
            }
        })
    end
}

