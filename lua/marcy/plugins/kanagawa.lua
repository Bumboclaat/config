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

    vim.opt.laststatus = 3
    vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'none' })
    -- vim.api.nvim_set_hl(0, 'Visual', { bg = 'blue', bold = true })
end

function MarkdownColors()
    -- Markview highlight groups
    -- Headings (H1-H6) - Progressive color intensity using kanagawa palette
    vim.api.nvim_set_hl(0, 'MarkviewHeading1', { fg = '#E46876', bold = true })        -- waveRed
    vim.api.nvim_set_hl(0, 'MarkviewHeading2', { fg = '#FF5D62', bold = true })        -- peachRed  
    vim.api.nvim_set_hl(0, 'MarkviewHeading3', { fg = '#DCA561', bold = true })        -- autumnYellow
    vim.api.nvim_set_hl(0, 'MarkviewHeading4', { fg = '#7E9CD8', bold = true })        -- crystalBlue
    vim.api.nvim_set_hl(0, 'MarkviewHeading5', { fg = '#957FB8', bold = true })        -- oniViolet
    vim.api.nvim_set_hl(0, 'MarkviewHeading6', { fg = '#7AA89F', bold = true })        -- waveAqua2

    -- Code blocks and inline code
    vim.api.nvim_set_hl(0, 'MarkviewCode', { bg = '#2A2A37', fg = '#98BB6C' })         -- springGreen
    vim.api.nvim_set_hl(0, 'MarkviewInlineCode', { bg = '#363646', fg = '#E6C384' })   -- carpYellow

    -- Links and references
    vim.api.nvim_set_hl(0, 'MarkviewHyperlink', { fg = '#7FB4CA', underline = true })  -- springBlue
    vim.api.nvim_set_hl(0, 'MarkviewImage', { fg = '#957FB8', italic = true })         -- oniViolet
    vim.api.nvim_set_hl(0, 'MarkviewEmail', { fg = '#7FB4CA', underline = true })      -- springBlue

    -- Lists
    vim.api.nvim_set_hl(0, 'MarkviewListItemMinus', { fg = '#C34043', bold = true })   -- autumnRed
    vim.api.nvim_set_hl(0, 'MarkviewListItemPlus', { fg = '#98BB6C', bold = true })    -- springGreen
    vim.api.nvim_set_hl(0, 'MarkviewListItemStar', { fg = '#E6C384', bold = true })    -- carpYellow

    -- Blockquotes
    vim.api.nvim_set_hl(0, 'MarkviewBlockQuoteDefault', { fg = '#727169', italic = true })  -- fujiGray
    vim.api.nvim_set_hl(0, 'MarkviewBlockQuoteNote', { fg = '#7FB4CA', italic = true })     -- springBlue
    vim.api.nvim_set_hl(0, 'MarkviewBlockQuoteWarn', { fg = '#DCA561', italic = true })     -- autumnYellow
    vim.api.nvim_set_hl(0, 'MarkviewBlockQuoteError', { fg = '#E46876', italic = true })    -- waveRed

    -- Tables
    vim.api.nvim_set_hl(0, 'MarkviewTableHeader', { fg = '#7E9CD8', bold = true })     -- crystalBlue
    vim.api.nvim_set_hl(0, 'MarkviewTableBorder', { fg = '#54546D' })                  -- sumiInk4
    vim.api.nvim_set_hl(0, 'MarkviewTableAlignLeft', { fg = '#98BB6C' })               -- springGreen
    vim.api.nvim_set_hl(0, 'MarkviewTableAlignCenter', { fg = '#E6C384' })             -- carpYellow
    vim.api.nvim_set_hl(0, 'MarkviewTableAlignRight', { fg = '#957FB8' })              -- oniViolet

    -- Checkboxes
    vim.api.nvim_set_hl(0, 'MarkviewCheckboxChecked', { fg = '#98BB6C', bold = true })     -- springGreen
    vim.api.nvim_set_hl(0, 'MarkviewCheckboxUnchecked', { fg = '#727169' })                -- fujiGray
    vim.api.nvim_set_hl(0, 'MarkviewCheckboxPending', { fg = '#DCA561', bold = true })     -- autumnYellow
    vim.api.nvim_set_hl(0, 'MarkviewCheckboxCancelled', { fg = '#E46876', strikethrough = true })  -- waveRed

    -- Standard markdown highlight groups (for when markview is not active)
    -- Headings
    vim.api.nvim_set_hl(0, 'markdownH1', { fg = '#E46876', bold = true })              -- waveRed
    vim.api.nvim_set_hl(0, 'markdownH2', { fg = '#FF5D62', bold = true })              -- peachRed
    vim.api.nvim_set_hl(0, 'markdownH3', { fg = '#DCA561', bold = true })              -- autumnYellow
    vim.api.nvim_set_hl(0, 'markdownH4', { fg = '#7E9CD8', bold = true })              -- crystalBlue
    vim.api.nvim_set_hl(0, 'markdownH5', { fg = '#957FB8', bold = true })              -- oniViolet
    vim.api.nvim_set_hl(0, 'markdownH6', { fg = '#7AA89F', bold = true })              -- waveAqua2
    
    -- TreeSitter markdown headings
    vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#E46876', bold = true })  -- waveRed
    vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#FF5D62', bold = true })  -- peachRed
    vim.api.nvim_set_hl(0, '@markup.heading.3.markdown', { fg = '#DCA561', bold = true })  -- autumnYellow
    vim.api.nvim_set_hl(0, '@markup.heading.4.markdown', { fg = '#7E9CD8', bold = true })  -- crystalBlue
    vim.api.nvim_set_hl(0, '@markup.heading.5.markdown', { fg = '#957FB8', bold = true })  -- oniViolet
    vim.api.nvim_set_hl(0, '@markup.heading.6.markdown', { fg = '#7AA89F', bold = true })  -- waveAqua2

    -- Code
    vim.api.nvim_set_hl(0, 'markdownCode', { fg = '#E6C384', bg = '#363646' })         -- carpYellow
    vim.api.nvim_set_hl(0, 'markdownCodeBlock', { fg = '#98BB6C', bg = '#2A2A37' })   -- springGreen
    vim.api.nvim_set_hl(0, '@markup.raw.markdown_inline', { fg = '#E6C384', bg = '#363646' })  -- carpYellow
    vim.api.nvim_set_hl(0, '@markup.raw.block.markdown', { fg = '#98BB6C', bg = '#2A2A37' })   -- springGreen

    -- Links
    vim.api.nvim_set_hl(0, 'markdownUrl', { fg = '#7FB4CA', underline = true })       -- springBlue
    vim.api.nvim_set_hl(0, 'markdownLink', { fg = '#7FB4CA', underline = true })      -- springBlue
    vim.api.nvim_set_hl(0, 'markdownLinkText', { fg = '#957FB8' })                    -- oniViolet
    vim.api.nvim_set_hl(0, '@markup.link.url.markdown_inline', { fg = '#7FB4CA', underline = true })    -- springBlue
    vim.api.nvim_set_hl(0, '@markup.link.label.markdown_inline', { fg = '#957FB8' })  -- oniViolet

    -- Lists
    vim.api.nvim_set_hl(0, 'markdownListMarker', { fg = '#E6C384', bold = true })     -- carpYellow
    vim.api.nvim_set_hl(0, '@markup.list.markdown', { fg = '#E6C384', bold = true })  -- carpYellow

    -- Emphasis
    vim.api.nvim_set_hl(0, 'markdownBold', { fg = '#FF5D62', bold = true })           -- peachRed
    vim.api.nvim_set_hl(0, 'markdownItalic', { fg = '#957FB8', italic = true })       -- oniViolet
    vim.api.nvim_set_hl(0, '@markup.strong.markdown_inline', { fg = '#FF5D62', bold = true })    -- peachRed
    vim.api.nvim_set_hl(0, '@markup.italic.markdown_inline', { fg = '#957FB8', italic = true })  -- oniViolet

    -- Blockquotes
    vim.api.nvim_set_hl(0, 'markdownBlockquote', { fg = '#727169', italic = true })   -- fujiGray
    vim.api.nvim_set_hl(0, '@markup.quote.markdown', { fg = '#727169', italic = true })  -- fujiGray

    -- Rules
    vim.api.nvim_set_hl(0, 'markdownRule', { fg = '#54546D', bold = true })           -- sumiInk4
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

    LineNumberColors(),
    MarkdownColors()
}
