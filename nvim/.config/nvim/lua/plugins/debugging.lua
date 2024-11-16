return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      
      -- GDB configuration that works for both C and C++
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = {"-i", "dap"},
        name = "gdb"
      }

      -- Shared configuration for C and C++
      local gdb_config = {
        name = "Debug STM32",
        type = "gdb",
        request = "launch",
        program = "${workspaceFolder}/build/your_program.elf",
        cwd = '${workspaceFolder}',
        gdbpath = "arm-none-eabi-gdb",
        runInTerminal = false,
        stopAtEntry = true,
        setupCommands = {
          {
            text = "target extended-remote localhost:3333",
            description = "Connect to OpenOCD",
            ignoreFailures = false
          },
          {
            text = "monitor reset halt",
            description = "Reset and halt the target",
            ignoreFailures = false
          },
          {
            text = "load",
            description = "Load program",
            ignoreFailures = false
          }
        }
      }

      -- Set configuration for both C and C++
      dap.configurations.c = { gdb_config }
      dap.configurations.cpp = { gdb_config }  -- Same config works for C++

      -- Key mappings
      vim.keymap.set('n', '<Leader>s', function() dap.continue() end)
      vim.keymap.set('n', '<Leader>o', function() dap.step_over() end)
      vim.keymap.set('n', '<Leader>i', function() dap.step_into() end)
      vim.keymap.set('n', '<Leader>e', function() dap.step_out() end)
      vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
      vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
      vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10
          }
        }
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        virt_text_pos = 'eol',
      })
    end
  }
}
