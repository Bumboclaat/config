vim.opt.relativenumber = true

-- make cursorline visible
vim.opt.cursorline = true

-- reduce update time
vim.opt.updatetime = 1000

vim.opt.signcolumn = 'yes'

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- smart wrap lines
vim.opt.showbreak = string.rep(" ", 3)
-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 1337
vim.opt.foldlevelstart = 1337

-- Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
-- vim.opt.colorcolumn = "160"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.opt.splitright = true

vim.cmd [[colorscheme kanagawa]]
-- vim.cmd [[colorscheme kanagawa-wave]]
-- vim.cmd [[colorscheme kanagawa-dragon]]
-- vim.cmd [[colorscheme kanagawa-lotus]]
-- vim.cmd [[colorscheme catppuccin-latte]]

vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldtext = "nvim_treesitter#foldtext()"

-- vim.opt.list = true
-- vim.opt.listchars = {
--     eol = "⏎"
-- }
