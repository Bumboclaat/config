return {
    'David-Kunz/gen.nvim',
    event = 'VeryLazy',
    config = function()
        require('gen').model = 'codellama'
    end
}
