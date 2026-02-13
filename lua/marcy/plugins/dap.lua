---@type LazySpec
local plugin = {
  "mfussenegger/nvim-dap",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
    },
    {
      "folke/which-key.nvim",
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
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
    { "<leader>dC", function() require("dap").continue() end,                                             desc = "Continue" },
    -- { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
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
    -- Mason integration
    require("mason-nvim-dap").setup({
      ensure_installed = {
        "js-debug-adapter",
        "dlv",
      },
    })

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}", "127.0.0.1" },
      },
    }

    dap.configurations.typescript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Program",
        program = "${workspaceFolder}/apps/backend/src/main.ts", -- Path to your main TypeScript file
        cwd = "${workspaceFolder}",
        runtimeExecutable = "node",
        runtimeArgs = {
          "--nolazy",
          "-r",
          "ts-node/register/transpile-only",
          "-r",
          "tsconfig-paths/register.js",
        },
        sourceMaps = true,
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
        skipFiles = {
          "<node_internals>/**",
          "node_modules/**",
        },
        outFiles = {
          "${workspaceFolder}/dist/**/*.js", -- Points to transpiled JavaScript files
        },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to octopus-backend",
        processId = require("dap.utils").pick_process, -- Optional: prompts you to pick a process
        port = 9229,                                   -- Ensure your Node.js app is running with `--inspect=9229` or similar
        cwd = "${workspaceFolder}/apps/backend/",
        sourceMaps = true,
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
        skipFiles = {
          "<node_internals>/**",
          "node_modules/**",
        },
        outFiles = {
          "${workspaceFolder}/dist/**/*.js", -- Points to transpiled JavaScript files
        },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to ocpp-backend",
        processId = require("dap.utils").pick_process, -- Optional: prompts you to pick a process
        port = 9229,                                   -- Ensure your Node.js app is running with `--inspect=9229` or similar
        cwd = "${workspaceFolder}/apps/ocpp/",
        sourceMaps = true,
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
        skipFiles = {
          "<node_internals>/**",
          "node_modules/**",
        },
        outFiles = {
          "${workspaceFolder}/dist/**/*.js", -- Points to transpiled JavaScript files
        },
      },
    }

    dap.configurations.go = {
 {
      name= "Attach to Air",
      type= "go",
      request= "attach",
      mode= "remote",
      port= 2345,
      host= "127.0.0.1"
    }
    }

    require("dap-go").setup()

    -- UI
    local dapui = require("dapui")
    dapui.setup()
    require("dap-go").setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end
  end,
}

return plugin
