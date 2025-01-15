-- return {
--   'morhetz/gruvbox', 
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme('gruvbox')
--   end
-- }

return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme('tokyonight-night')
    end
}
