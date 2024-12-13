return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      -- Configure nvim-dap-ui
      dapui.setup()
      -- Open and close dapui automatically
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      -- DAP Adapter configuration for GDB with cppdbg
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = '/usr/share/cpptools-debug/bin/OpenDebugAD7',
      }
      
      -- Flexible argument input function
      local function get_arguments()
        local args = {}
        while true do
          local arg = vim.fn.input('Argument (press enter twice to finish): ')
          if arg == '' then
            break
          end
          table.insert(args, arg)
        end
        return args
      end
      
      -- DAP Configuration for C++
      dap.configurations.cpp = {
        {
          name = "Launch C++",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          args = get_arguments,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description = 'Enable GDB pretty printing',
              ignoreFailures = false
            },
          },
        },
        {
          -- Attach to a running process
          name = "Attach to process (C++)",
          type = "cppdbg",
          request = "attach",
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
      
      -- DAP Configuration for C (nearly identical to C++)
      dap.configurations.c = {
        {
          name = "Launch C",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          args = get_arguments,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description = 'Enable GDB pretty printing',
              ignoreFailures = false
            },
          },
        },
        {
          -- Attach to a running process
          name = "Attach to process (C)",
          type = "cppdbg",
          request = "attach",
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
      
      -- Helper function to end the debug session and clean up
      local function clean_debug_session()
        dap.terminate({}, {terminateDebuggee = true})
        dap.disconnect()
        dapui.close()
        -- Instead of wiping out all buffers, close dap and inactive buffers
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.fn.getbufvar(buf, '&filetype') == 'dap-repl' or
             vim.fn.getbufvar(buf, '&filetype') == 'dapui_scopes' or
             vim.fn.getbufvar(buf, '&filetype') == 'dapui_stacks' or
             vim.fn.getbufvar(buf, '&filetype') == 'dapui_watches' or
             vim.fn.getbufvar(buf, '&filetype') == 'dapui_breakpoints' then
            vim.api.nvim_buf_delete(buf, {force = true})
          end
        end
      end
      
      -- Key bindings for common DAP actions
      vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, {desc = "Toggle Breakpoint"})
      vim.keymap.set('n', '<leader>dc', dap.continue, {desc = "Continue"})
      vim.keymap.set('n', '<leader>dn', dap.step_over, {desc = "Step Over"})
      vim.keymap.set('n', '<leader>di', dap.step_into, {desc = "Step Into"})
      vim.keymap.set('n', '<leader>do', dap.step_out, {desc = "Step Out"})
      vim.keymap.set('n', '<leader>dr', dap.repl.open, {desc = "Open REPL"})
      vim.keymap.set('n', '<leader>dl', dap.run_last, {desc = "Run Last"})
      vim.keymap.set('n', '<leader>dq', clean_debug_session, {desc = "End debug session and close UI"})
      
      -- Key binding to add a watch
      vim.keymap.set('n', '<leader>dw', function()
        local expr = vim.fn.input('Expression to watch: ')
        if expr ~= '' then
          dap.set_breakpoint(expr)
        end
      end, {desc = "Add Watch"})
    end,
  }
}
