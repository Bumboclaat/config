---@type LazySpec
local plugin = {
  'mfussenegger/nvim-dap',
  enabled = false,
  event = 'VeryLazy',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    "nvim-neotest/nvim-nio",
    'leoluz/nvim-dap-go',
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = 'mason.nvim',
      cmd = { 'DapInstall', 'DapUninstall' },
    },
    {
      'folke/which-key.nvim',
      opts = {
        defaults = {
          ['<leader>d'] = { name = '+debug' },
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({}) end,                                           desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end,                                               desc = "Eval",                   mode = { "n", "v" } },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
    { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
  },
  config = function()
    local dap = require("dap")
    local mason_registry = require("mason-registry")
    -- Mason integration
    require('mason-nvim-dap').setup({
      ensure_installed = { 'js-debug-adapter' },
    })

    local node_debug_path = mason_registry.get_package("node-debug2-adapter"):get_install_path()
        .. "/out/src/nodeDebug.js"

    local js_debug_adapter = mason_registry.get_package('js-debug-adapter')
    local js_debug_adapter_path = js_debug_adapter and js_debug_adapter:get_install_path()

    print('----------------------------------------------------------------------')
    print(js_debug_adapter)
    print(js_debug_adapter_path)
    print('----------------------------------------------------------------------')

    require('dap').adapters['pwa-node'] = {
      type = 'server',
      host = '127.0.0.1',
      port = '8080',
      executable = {
        command = js_debug_adapter_path .. '/js-debug-adapter',
        args = { '${port}', '127.0.0.1' },
      },
    }

    require('dap').configurations.typescript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
    }

    -- dap.adapters.node2 = {
    --   type = "executable",
    --   command = "node",
    --   args = {
    --     node_debug_path,
    --   },
    -- }
    --
    -- dap.configurations.typescript = {
    --   {
    --     name = "attach to typescript",
    --     type = "node2",
    --     request = "attach",
    --     port = function()
    --       return tonumber(vim.fn.input("Debug Port: ", "9229"))
    --     end,
    --     cwd = vim.fn.getcwd(),
    --     sourceMaps = true,
    --     skipFiles = { "<node_internals>/**", "node_modules/**" },
    --   },
    -- }

    dap.adapters.go = function(callback, config)
      local handle
      local pid_or_err
      local port = 3000
      handle, pid_or_err = vim.loop.spawn('dlv', {
        args = { 'dap', '-l', '127.0.0.1:' .. port },
        detached = true,
      }, function(code)
        handle:close()
        print('Delve exited with code', code)
      end)
      vim.defer_fn(function()
        callback({ type = 'server', host = '127.0.0.1', port = port })
      end, 100) -- Wait 100ms for delve to start
    end

    dap.configurations.go = {
      {
        type = 'go',
        name = 'Debug',
        request = 'launch',
        program = '${file}'
      },
      {
        type = 'go',
        name = 'Debug test', -- Configuration for debugging test files
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}'
      }
    }

    -- UI
    local dapui = require('dapui')
    dapui.setup({
    })
    require("dap-go").setup()
    dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
    dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
    dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end
  end,
}

return plugin
