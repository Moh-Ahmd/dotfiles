-- linting_config.lua
return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            python = { "flake8", "mypy", "pylint" },
            c = { "gcc" },  -- Assuming gcc is installed for linting
            cpp = { "gcc" },
        }

        -- Run linter on file save
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
            group = vim.api.nvim_create_augroup("LintOnSave", {}),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
