function LineNumberColors()
    -- vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#ADD8E6', bold = true })
    -- vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#ADD8E6', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#627d9a', bold = true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#627d9a', bold = true })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FF9D3C', bold = true })
    vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FF9D3C', bold = true })
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#627d9a', bold = true })
    vim.api.nvim_set_hl(0, 'Todo', { bg = '#edde32', bold = true })
    vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#627d9a', bold = true })
    -- vim.api.nvim_set_hl(0, 'Visual', { bg = 'blue', bold = true })
end

return {
    'rebelot/kanagawa.nvim',
    config = function()
        require('kanagawa').setup({
            -- theme="dragon",
            overrides = function(colors) -- add/modify highlights
                local theme = colors.theme
                return {
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                    --popup menu
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },

                    -- Telescope
                    -- TelescopeTitle = { fg = theme.ui.special, bold = true },
                    -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                    -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                }
            end,
        })
    end,
    LineNumberColors()
}
