return {

  'simrat39/rust-tools.nvim',
  config = function()
    require('rust-tools').setup({
      tools = { autoSetHints = false, hover_with_actions = false },
      reload_workspace_from_cargo_toml = false,
      server = {
        standalone = false,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = { command = 'clippy' },
            cargo = {
              allFeatures = true,
            },
            completion = {
              callable = {
                snippets = 'none',
              },
            },
          },
        },
      },
    })
  end
}
