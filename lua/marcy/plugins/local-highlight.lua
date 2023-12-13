return {
    'tzachar/local-highlight.nvim',
    event = 'VeryLazy',
    config = function()
        require('local-highlight').setup()
        vim.api.nvim_create_autocmd('BufRead', {
            pattern = { '*.*' },
            callback = function(data)
                require('local-highlight').attach(data.buf)
            end
        })
    end
}
