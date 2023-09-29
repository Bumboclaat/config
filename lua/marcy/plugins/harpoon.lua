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
            ['<M-h>'] = {
                function() require('harpoon.ui').nav_file(1) end,
                'Go to File 1',
            },
            ['<M-j>'] = {
                function() require('harpoon.ui').nav_file(2) end,
                'Go to File 2',
            },
            ['<M-k>'] = {
                function() require('harpoon.ui').nav_file(3) end,
                'Go to File 3',
            },
            ['<M-l>'] = {
                function() require('harpoon.ui').nav_file(4) end,
                'Go to File 4',
            },
        })
    end,
}
