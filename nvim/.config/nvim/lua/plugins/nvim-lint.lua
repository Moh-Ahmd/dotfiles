return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require('lint')
        
        -- Configure linters for different filetypes
        lint.linters_by_ft = {
            python = { 
                'flake8', 
                'mypy', 
                'pylint' 
            },
            c = { 'clangtidy' },
            cpp = { 'clangtidy' },
            cmake = { 'cmakelint' }
        }
        
        -- Automatically trigger linting
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                -- Delay to reduce potential performance impact
                require('lint').try_lint()
            end,
        })

        -- Optional: Keymapping to manually trigger linting
        vim.keymap.set('n', '<leader>fl', function()
            require('lint').try_lint()
        end, { desc = "Trigger linting" })
    end,
}
