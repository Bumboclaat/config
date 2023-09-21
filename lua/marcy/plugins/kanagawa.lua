function LineNumberColors()
    -- vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#ADD8E6', bold = true })
    -- vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#ADD8E6', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#627d9a', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#627d9a', bold = true })
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#627d9a', bold = true })
    vim.api.nvim_set_hl(0, 'Todo', { fg = 'yellow', bold = true })
    -- vim.api.nvim_set_hl(0, 'Visual', { bg = 'blue', bold = true })
end

return {
    'rebelot/kanagawa.nvim',
    LineNumberColors()
}
