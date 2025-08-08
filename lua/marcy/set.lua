vim.opt.relativenumber = true

-- make cursorline visible
vim.opt.cursorline = true

-- reduce update time
vim.opt.updatetime = 1000

vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.winborder = "rounded"

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
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true
-- vim.opt.colorcolumn = "160"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.opt.splitright = true

vim.cmd([[colorscheme kanagawa]])
-- vim.cmd [[colorscheme kanagawa-wave]]
-- vim.cmd [[colorscheme kanagawa-dragon]]
-- vim.cmd [[colorscheme kanagawa-lotus]]
-- vim.cmd [[colorscheme catppuccin-latte]]

vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldtext = "nvim_treesitter#foldtext()"

local function fold_virt_text(result, s, lnum, coloff)
	if not coloff then
		coloff = 0
	end
	local text = ""
	local hl
	for i = 1, #s do
		local char = s:sub(i, i)
		local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
		local _hl = hls[#hls]
		if _hl then
			local new_hl = "@" .. _hl.capture
			if new_hl ~= hl then
				table.insert(result, { text, hl })
				text = ""
				hl = nil
			end
			text = text .. char
			hl = new_hl
		else
			text = text .. char
		end
	end
	table.insert(result, { text, hl })
end

function _G.custom_foldtext()
	local start = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
	local end_str = vim.fn.getline(vim.v.foldend)
	local end_ = vim.trim(end_str)
	local result = {}
	fold_virt_text(result, start, vim.v.foldstart - 1)
	table.insert(result, { " ... ", "Delimiter" })
	fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match("^(%s+)") or ""))
	return result
end

vim.opt.foldtext = "v:lua.custom_foldtext()"
