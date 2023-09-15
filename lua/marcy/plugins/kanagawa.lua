function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#ADD8E6', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#ADD8E6', bold = true })
    vim.api.nvim_set_hl(0, 'Visual', { bg = 'Blue', bold = true })
end

return {
    'rebelot/kanagawa.nvim',
    LineNumberColors()
}
