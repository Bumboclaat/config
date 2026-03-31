vim.opt.colorcolumn = "140"

local space = "·"

vim.opt_local.listchars = {
    multispace = space,
    lead = space,
    trail = space,
    nbsp = space,
    space = space,
    eol = "↵",
    tab = "▸·",
}
