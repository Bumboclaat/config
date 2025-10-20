return {

  "nvim-telescope/telescope.nvim",
  tag = '0.1.8',
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim",
    'nvim-telescope/telescope-file-browser.nvim',
    -- 'AckslD/nvim-neoclip.lua',
    'aaronhallaert/advanced-git-search.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      -- Native sorter for vastly improved performance
      'nvim-telescope/telescope-fzf-native.nvim',
    },
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
    local make_entry = require('telescope.make_entry')

    local quickfix_entry_maker = make_entry.gen_from_quickfix({
      fname_width = 0.5,
    })

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = { '.git/', 'yarn.lock', 'pnpm-lock.yaml', '.yarn/', 'node_modules/', 'dist/' },
        layout_strategy = 'vertical',
        layout_config = { vertical = { width = 0.9 } },
      },
      path_displays = 'smart',
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
            '--smart-case',
          },
        },
        lsp_references = { entry_maker = quickfix_entry_maker },
        quickfix = { entry_maker = quickfix_entry_maker },
        colorscheme = {
          enable_preview = true
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
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
        advanced_git_search = {
          -- fugitive or diffview
          diff_plugin = 'fugitive',
          git_flags = { '--no-pager', '-c', 'delta.side-by-side=false' },
          git_diff_flags = {},
          show_builtin_git_pickers = false,
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }
        }
      },

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
    })

    require('telescope').load_extension('live_grep_args')
    -- require('telescope').load_extension('neoclip')
    require('telescope').load_extension('file_browser')
    require("telescope").load_extension("ui-select")
    require "marcy.telescope.multigrep".setup()
  end
}
