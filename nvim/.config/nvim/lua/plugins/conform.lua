return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        
        conform.setup({
            formatters_by_ft = {
                python = { "black", "isort" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                cmake = { "cmake-format" },
                -- Add more filetypes as needed
            },
            
            -- Use the system-wide clang-format configuration
            formatters = {
                ["clang-format"] = {
                    prepend_args = {
                        "-style=file:" .. os.getenv("HOME") .. "/.clang-format"
                    }
                }
            },
            
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 500,
            },
        })

        -- Optional: Create a keymapping for manual formatting
        vim.keymap.set({ "n", "v" }, "<leader>fm", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = "Format file or range" })
    end,
}
