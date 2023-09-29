return {
    'ThePrimeagen/harpoon',
    event = 'VeryLazy',
    config = function()
        require('which-key').register({
            ['<leader>h'] = {
                name = 'Harpoon',
                t = {
                    function() require('harpoon.ui').toggle_quick_menu() end,
                    'Quick Menu',
                },
                a = {
                    function() require('harpoon.mark').add_file() end,
                    'Add file',
                },
            },
            -- Navigation
            ['<C-1>'] = {
                function() require('harpoon.ui').nav_file(1) end,
                'Go to File 1',
            },
            ['<C-2>'] = {
                function() require('harpoon.ui').nav_file(2) end,
                'Go to File 2',
            },
            ['<C-3>'] = {
                function() require('harpoon.ui').nav_file(3) end,
                'Go to File 3',
            },
            ['<C-4>'] = {
                function() require('harpoon.ui').nav_file(4) end,
                'Go to File 4',
            },
        })
    end,
}
