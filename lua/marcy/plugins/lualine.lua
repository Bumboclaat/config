return {
  "nvim-lualine/lualine.nvim",
  -- Set lualine as statusline
  -- See `:help lualine.txt`
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_b = {
          "branch",
          "diff",
        },
        lualine_c = {
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1,     -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = {
          "encoding",
          "filetype",
        },
        lualine_y = {},
      },
    })
  end,
}
