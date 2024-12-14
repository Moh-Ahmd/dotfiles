-- conform_config.lua
return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        -- Enable the formatters you want
        conform.formatters = {
            python = { "black", "isort" },
            c = { "clang-format" },
            cpp = { "clang-format" },
        }

        -- Keybindings for formatting
        vim.keymap.set({ "n", "v" }, "<space>fm", function()
            conform.format({
                async = true,
                bufnr = 0,
                timeout_ms = 2000,
            })
        end, { desc = "Format file or range (in visual mode) using conform.nvim" })

        -- Autoformat on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("FormatOnSave", {}),
            callback = function()
                conform.format({
                    async = false,
                    bufnr = 0,
                    timeout_ms = 2000,
                })
            end,
        })
    end,
}
