---@type LazySpec
local plugin = {
  "mfussenegger/nvim-dap",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "igorlfs/nvim-dap-view",
    "theHamsta/nvim-dap-virtual-text",
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
    { "<leader>du", function() require("dap-view").toggle(true) end,                                      desc = "Dap View" },
    { "<leader>de", function() require("dap-view").hover(nil, true) end,                                  desc = "Eval",                   mode = { "n", "v" } },
    { "<leader>dW", function() require("dap-view").add_expr() end,                                        desc = "Add Watch",              mode = { "n", "v" } },
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
    { "<leader>dw", function() require("dap-view").hover(nil, true) end,                                  desc = "Hover",                  mode = { "n", "v" } },
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
        program = "${workspaceFolder}/apps/backend/src/main.ts",
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
          "${workspaceFolder}/dist/**/*.js",
        },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to octopus-backend",
        processId = require("dap.utils").pick_process,
        port = 9229,
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
          "${workspaceFolder}/dist/**/*.js",
        },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to ocpp-backend",
        processId = require("dap.utils").pick_process,
        port = 9229,
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
          "${workspaceFolder}/dist/**/*.js",
        },
      },
    }

    dap.configurations.go = {
      {
        name = "Attach to Air",
        type = "go",
        request = "attach",
        mode = "remote",
        port = 2345,
        host = "127.0.0.1",
      },
    }

    require("dap-go").setup()

    -- UI
    local dap_view = require("dap-view")
    dap_view.setup()

    dap.listeners.after.event_initialized["dap_view_config"] = function()
      dap_view.open()
    end
    dap.listeners.before.event_terminated["dap_view_config"] = function()
      dap_view.close(true)
    end
    dap.listeners.before.event_exited["dap_view_config"] = function()
      dap_view.close(true)
    end
  end,
}

return plugin
