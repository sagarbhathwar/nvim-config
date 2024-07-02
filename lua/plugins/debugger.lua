return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dap-python").setup("python3")
      require("dapui").setup()

      local dap = require("dap")
      local ui = require("dapui")
      local dap_python = require("dap-python")

      -- Set python test runner to pytest, else it defaults to unittest
      dap_python.test_runner = "pytest"

      -- Register codelldb adapter with dap
      -- Installation and automatic path configuration handled by mason
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.exepath("codelldb"),
          args = { "--port", "${port}" },
        },
      }

      local dap_py_config = dap.configurations.python or {}
      table.insert(dap_py_config, {
        name = "Debug C++ from python",
        type = "codelldb",
        request = "launch",
        program = "python3",
        args = function()
          local args_string = "${file} " .. vim.fn.input("Arguments: ")
          return vim.split(args_string, " +")
        end,
      })
      dap.configurations.python = dap_py_config

      -- Register listeners with dap-ui actions on dap events
      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end

      -- Define keymaps for debugging
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>dr", dap.run_to_cursor)
      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F12>", dap.restart)
      vim.keymap.set("n", "<leader>dpt", dap_python.test_method)
      vim.keymap.set("n", "<leader>dpc", dap_python.test_class)

      -- UI keymaps
      vim.keymap.set("n", "<leader>?", function()
        require("dapui").eval(nil, { enter = true })
      end)
      vim.keymap.set("n", "<leader>dt", ui.toggle)
      vim.keymap.set("n", "<leader>dq", ui.close)
    end,
  },
}
