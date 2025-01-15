-- return {
--
--   "nvim-lualine/lualine.nvim",
--   config = function()
--     require('lualine').setup({
--       options = {
--         theme = "palenight"
--       }
--     })
--   end
-- }

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'folke/tokyonight.nvim' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'tokyonight-night', 
      },
    })
  end
}
