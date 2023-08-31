-- OR setup with some options
require("neo-tree").setup({
  sort_by = "case_sensitive",
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  renderer = {
    group_empty = true,
  },
  filesystem = {
    filtered_items = {
      visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
      hide_dotfiles = false,
      hide_gitignored = true,
    },
    follow_current_file = {
      enabled = true,               -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = true,       -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    follow
  },
  filters = {
  },
})
