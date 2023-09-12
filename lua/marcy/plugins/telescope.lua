return {

  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim",
    'nvim-telescope/telescope-file-browser.nvim',
    'AckslD/nvim-neoclip.lua',
  },

  config = function() -- load refactoring Telescope extension
    require("telescope").load_extension("refactoring")

    -- remap to open the Telescope refactoring menu in visual mode
    vim.api.nvim_set_keymap(
      "v",
      "<leader>rr",
      "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
      { noremap = true }
    )
    local lga_actions = require('telescope-live-grep-args.actions')

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = { '.git/', 'yarn.lock', 'pnpm-lock.yaml', '.yarn/', 'node_modules/', 'dist/' },
        layout_strategy = 'vertical',
        layout_config = { vertical = { width = 0.9 } },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--hidden',
          },
        },
      },
      extensions = {
        live_grep_args = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--hidden',
          },
          auto_quoting = true,
          mappings = {
            i = { ['<C-k>'] = lga_actions.quote_prompt() },
          },
        },
        file_browser = {
          hijack_netrw = false,
          hidden = true,
          respect_gitignore = false,
        },
      },
    })

    require('telescope').load_extension('live_grep_args')
    require('telescope').load_extension('neoclip')
    require('telescope').load_extension('file_browser')
  end
}
