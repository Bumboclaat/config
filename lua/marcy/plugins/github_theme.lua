return {
    -- Install without configuration
    { 'projekt0n/github-nvim-theme' },
    -- Or with configuration
    {
        'projekt0n/github-nvim-theme',
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                -- ...
            })

            vim.cmd('colorscheme github_dark')
        end,
    }
}
