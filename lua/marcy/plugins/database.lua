return {
	{
		"kristijanhusak/vim-dadbod-ui",
		commit = "0f51d8de368c8c6220973e8acd156d17da746f4c",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = { "sql", "mysql", "plsql" },
				lazy = true,
			},
			-- 'kristijanhusak/vim-dadbod-completion',
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		config = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,

	},
	{ -- optional saghen/blink.cmp completion source
		'saghen/blink.cmp',
		opts = {
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { 'snippets', 'dadbod', 'buffer' },
				},
				-- add vim-dadbod-completion to your completion providers
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
		},
	}
}
