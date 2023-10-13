-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland (yank to system clipboard)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- replace all occurrences of the word under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

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
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').search_history, { desc = '[S]earch [H]istory' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it [F]Files' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').quickfix, { desc = 'Quick [F]ix [F]iles' })
vim.keymap.set('n', '<leader>dv', '<Cmd>:DiffviewOpen<CR>', { desc = 'open [D]iff [V]iew'})
vim.keymap.set('n', '<leader>dc', '<Cmd>:DiffviewClose<CR>', { desc = 'open [D]iff [C]lose'})
vim.keymap.set('n', '<leader>dm', '<Cmd>:DiffviewOpen origin/main...HEAD<CR>', { desc = 'open [D]iff [M]ain'})
vim.keymap.set('n', '<leader>nc', '<Cmd>:Telescope neoclip<CR>')
vim.keymap.set('n', '<leader>fb', '<Cmd>:Telescope file_browser path=%:p:h select_buffer=true<CR>')

vim.keymap.set('n', '<leader><leader>c', vim.cmd.up)
vim.keymap.set('n', '<leader>q', '<Cmd>:bd<CR>', {desc = '[Q]uit Buffer'})
vim.keymap.set('n', '<leader>Q', '<Cmd>:only<CR>', {desc = 'Quit Other Windows'})
vim.keymap.set('n', '<leader>pf', '<Cmd>:Prettier<CR>', {desc = '[P]rettier [F]ormat'})
vim.keymap.set('n', '<leader>t', '<Cmd>:Neotree toggle<CR>', {desc = '[T]oggle Neotree'})
vim.keymap.set('n', '<leader>tt', '<Cmd>:ToggleTerm<CR>',{desc = '[T]oggle [T]erminal'})

-- lsp remaps
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
	{ desc = '[W]orkspace [S]ymbols' })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat' })

-- See `:help K` for why this keymap
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
-- vim.keymap.set('n',('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

-- Lesser used LSP functionality
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[W]orkspace [A]dd Folder' })
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '[W]orkspace [R]emove Folder' })
vim.keymap.set('n', '<leader>wl', function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = '[W]orkspace [L]ist Folders' })

-- own configurations
-- visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- normal mode
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- vim.keymap.set('n', '<C-j>', vim.cmd.bnext)
-- vim.keymap.set('n', '<C-k>', vim.cmd.bprev)
vim.keymap.set('n', '<C-h>', vim.cmd.tabn)
vim.keymap.set('n', '<C-l>', vim.cmd.tabp)
vim.keymap.set('n', '<C-s>', vim.cmd.w)
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'gb', '<C-o>')
vim.keymap.set('n', 'gf', '<C-i>')

-- move between splits
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')


-- adjust window size
vim.keymap.set('n', '<C-,>', '<C-W><')
vim.keymap.set('n', '<C-.>', '<C-W>>')


-- Diagnostic keymaps
vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, {desc = '[G]o to next [e]rror'})
vim.keymap.set('n', 'gE', vim.diagnostic.goto_prev, {desc = '[G]o to previous [E]rror'})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {desc = 'Open [e]rror float'})
vim.keymap.set('n', '<leader>di', vim.diagnostic.setloclist, {desc = '[d][i]agnostics'})
