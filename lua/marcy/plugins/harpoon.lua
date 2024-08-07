return {
    'ThePrimeagen/harpoon',
    event = 'VeryLazy',
    config = function()
        require('which-key').add({
            { "<M-h>",      function() require('harpoon.ui').nav_file(1) end,         desc = "Go to File 1" },
            { "<M-j>",      function() require('harpoon.ui').nav_file(2) end,         desc = "Go to File 2" },
            { "<M-k>",      function() require('harpoon.ui').nav_file(3) end,         desc = "Go to File 3" },
            { "<M-l>",      function() require('harpoon.ui').nav_file(4) end,         desc = "Go to File 4" },
            { "<leader>h",  group = "Harpoon" },
            { "<leader>ht", function() require('harpoon.ui').toggle_quick_menu() end, desc = "Add file" },
            { "<leader>ha", function() require('harpoon.mark').add_file() end,        desc = "Quick Menu" },
        })
    end,
}
