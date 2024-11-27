return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- DAP UI setup
        dap.listeners.before.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Key bindings
        vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
        vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Continue debugging" })
        vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = "Step over" })
        vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Step into" })
        vim.keymap.set('n', '<leader>do', dap.step_out, { desc = "Step out" })
        vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = "Open REPL" })
        vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = "Run last debug session" })

        -- C/C++ configuration using gdb
        dap.adapters.gdb = {
            type = 'executable',
            command = '/usr/bin/gdb', -- Adjust the path if necessary
            name = 'gdb'
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
        }

        dap.configurations.c = dap.configurations.cpp
    end,
}
