return {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        -- Configure the colorscheme before loading it
        require("kanagawa").setup({
            on_highlights = function(hl, c)
                -- Custom highlights that will persist
                hl.CursorLineNr = {
                    fg = "#ff9e64",
                    bold = true
                }
            end
        })

        -- Set the colorscheme
        vim.cmd.colorscheme('kanagawa-wave')

        -- Ensure relative line numbers are enabled
        vim.opt.number = true
        vim.opt.relativenumber = true

        -- Additional failsafe to set the highlight after a brief delay
        vim.defer_fn(function()
            vim.cmd([[
                highlight CursorLineNr guifg=#ff9e64 gui=bold
            ]])
        end, 100)

        -- Enable cursorline to make sure the current line is highlighted
        vim.opt.cursorline = true
    end
}
