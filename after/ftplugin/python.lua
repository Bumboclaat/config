vim.opt.colorcolumn = "120"

local space = "·"

-- vim.opt.list = true
vim.opt_local.listchars = {
    multispace = space,
    lead = space,
    trail = space,
    nbsp = space,
    space = space,
    eol = "↵",
    tab = "▸·",
}
