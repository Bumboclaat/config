-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)


-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
  "v",
  "<leader>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  { noremap = true }
)

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- leader remaps
-- telescope
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it [F]Files' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>nc', '<Cmd>:Telescope neoclip<CR>')
vim.keymap.set('n', '<leader>fb', '<Cmd>:Telescope file_browser path=%:p:h select_buffer=true<CR>')

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader><leader>c', vim.cmd.up)
vim.keymap.set('n', '<leader>q', '<Cmd>:bd<CR>')
vim.keymap.set('n', '<leader>pf', '<Cmd>:Prettier<CR>')
vim.keymap.set('n', '<leader>t', '<Cmd>:Neotree toggle<CR>')
vim.keymap.set('n', '<leader>tt', '<Cmd>:ToggleTerm<CR>')


-- own configurations
-- visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- normal mode
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-j>', vim.cmd.bnext)
vim.keymap.set('n', '<C-k>', vim.cmd.bprev)
vim.keymap.set('n', '<C-w>', vim.cmd.bd)
vim.keymap.set('n', '<C-h>', vim.cmd.tabn)
vim.keymap.set('n', '<C-l>', vim.cmd.tabp)
vim.keymap.set('n', '<C-s>', vim.cmd.w)
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'gb', '<C-o>')
vim.keymap.set('n', 'gf', '<C-i>')

-- move between splits
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
-- vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
-- vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')


-- adjust window size
vim.keymap.set('n', '<C-,>', '<C-W><')
vim.keymap.set('n', '<C-.>', '<C-W>>')


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>di', vim.diagnostic.setloclist)
