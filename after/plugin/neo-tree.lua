-- OR setup with some options
require("neo-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filesystem = {
    filtered_items = {
      visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
  filters = {
  },
})
