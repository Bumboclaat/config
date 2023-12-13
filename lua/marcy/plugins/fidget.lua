return {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    config = function()
        local fidget = require('fidget')
        fidget.setup({
            progress = {
                display = {
                    overrides = {
                        rust_analyzer = {
                            icon = fidget.progress.display.for_icon(fidget.spinner.animate("arrow", 2.5), "🦀"),
                        },
                    }
                }
            }
        })
    end,
}
