return {
    'David-Kunz/gen.nvim',
    enabled = false,
    event = 'VeryLazy',
    config = function()
        require('gen').model = 'codellama'
    end
}
