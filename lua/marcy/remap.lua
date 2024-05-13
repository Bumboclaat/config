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

-- vim.keymap.set('n', '<leader>r', ":so ~/.config/nvim/init.lua<CR>", { desc = '[R]reload Config' })

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
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it [F]Files' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').quickfix, { desc = 'Quick [F]ix [F]iles' })
vim.keymap.set('n', '<leader>cs', require('telescope.builtin').colorscheme, { desc = '[C]olor [S]cheme' })
vim.keymap.set('n', '<leader>dv', '<Cmd>:DiffviewOpen<CR>', { desc = '[D]iff [V]iew' })
vim.keymap.set('n', '<leader>dc', '<Cmd>:DiffviewClose<CR>', { desc = '[D]iff [C]lose' })
vim.keymap.set('n', '<leader>dm', '<Cmd>:DiffviewOpen origin/main...HEAD<CR>', { desc = '[D]iff [M]ain' })
vim.keymap.set('n', '<leader>nc', '<Cmd>:Telescope neoclip<CR>')
vim.keymap.set('n', '<leader>fb', '<Cmd>:Telescope file_browser path=%:p:h select_buffer=true<CR>')

vim.keymap.set('n', '<leader><leader>c', vim.cmd.up)
vim.keymap.set('n', '<leader>q', '<Cmd>:bd<CR>', { desc = '[Q]uit Buffer' })
vim.keymap.set('n', '<leader>Q', '<Cmd>:only<CR>', { desc = 'Quit Other Windows' })
vim.keymap.set('n', '<leader>pf', '<Cmd>:Prettier<CR>', { desc = '[P]rettier [F]ormat' })
vim.keymap.set('n', '<leader>t', '<Cmd>:Neotree toggle<CR>', { desc = '[T]oggle Neotree' })

-- lsp remaps
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = '[G]oto [D]efinition' })
-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition(), { desc = '[G]oto [D]efinition' })
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
-- vim.keymap.set('n', '<C-s>', vim.cmd.w)
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<ESC>:w<CR>')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'gb', '<C-o>')
vim.keymap.set('n', 'gf', '<C-i>')

-- splits
-- vim.keymap.set('n', '<leader>v', ':vsplit')
-- vim.keymap.set('n', '<leader>h', ':split')

vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')


-- adjust window size
vim.keymap.set('n', '<M-,>', '<C-W><')
vim.keymap.set('n', '<M-.>', '<C-W>>')

vim.keymap.set('n', '<leader>cf', '<cmd>:cexpr[]<cr>', { desc = '[C]lear Quick[F]ix List' })

-- Diagnostic keymaps
vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, { desc = '[G]o to next [e]rror' })
vim.keymap.set('n', 'gE', vim.diagnostic.goto_prev, { desc = '[G]o to previous [E]rror' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open [e]rror float' })
vim.keymap.set('n', '<leader>di', vim.diagnostic.setloclist, { desc = '[d][i]agnostics' })

vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<cr>', { desc = 'Run previous test again' })
vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<cr>', { desc = 'Run tests in file' })
vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<cr>', { desc = 'Run test close to cursor' })
vim.keymap.set('n', '<leader>tv', '<cmd>TestVisit<cr>', { desc = 'Open test close to cursor' })

vim.keymap.set('n', '<leader>gt', '<cmd>:A<cr>', { desc = '[G]o [T]o Alternate' })

-- refactoring remaps
vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end,
	{ desc = 'Extract Function' })
vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end,
	{ desc = 'Extract Function to File' })
-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end,
	{ desc = 'Extract Variable' })
-- Extract variable supports only visual mode
vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end,
	{ desc = 'Inline Function' })
-- Inline func supports only normal
vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end,
	{ desc = 'Inline Variable' })
-- Inline var supports both normal and visual mode

vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end,
	{ desc = 'Extract Block' })
vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end,
	{ desc = 'Extract Block to File' })
-- Extract block supports only normal mode

vim.keymap.set('v', '<leader>]', ':Gen<CR>')
vim.keymap.set('n', '<leader>]', ':Gen<CR>')


-- tmux navigator
vim.keymap.set('n', "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set('n', "<C-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set('n', "<C-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set('n', "<C-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set('n', "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>")

-- trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = 'e[X]ecute Trouble' })
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, { desc = 'e[X]ecute Trouble on [W]orkspace' })
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,{ desc = 'e[X]ecute Trouble on [D]ocument' })
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = 'e[X]ecute Trouble on [Q]uickfix' })
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = 'e[X]ecute Trouble on [L]oclist' })
vim.keymap.set("n", "<leader>xn", function() require("trouble").next({skip_groups = true, jump = true}) end, { desc = 'ne[X]t Trouble' })
vim.keymap.set("n", "<leader>xp", function() require("trouble").previous({skip_groups = true, jump = true}) end, { desc = '[P]revious Trouble' })


-- spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {desc = "Toggle Spectre" })
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Search current word" })
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file" })
