return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'rebelot/kanagawa.nvim' },
  config = function()
    local colors = {
      wave = {
        bg = '#1F1F28',
        fg = '#DCD7BA',
        yellow = '#E6C384',
        cyan = '#7FB4CA',
        green = '#98BB6C',
        orange = '#FFA066',
        magenta = '#957FB8',
        blue = '#7E9CD8',
        red = '#E46876',
      },
    }

    local kanagawa_theme = {
      normal = {
        a = { fg = colors.wave.bg, bg = colors.wave.yellow, gui = 'bold' },
        b = { fg = colors.wave.fg, bg = colors.wave.bg },
        c = { fg = colors.wave.fg, bg = colors.wave.bg },
      },
      insert = {
        a = { fg = colors.wave.bg, bg = colors.wave.green, gui = 'bold' },
      },
      visual = {
        a = { fg = colors.wave.bg, bg = colors.wave.magenta, gui = 'bold' },
      },
      replace = {
        a = { fg = colors.wave.bg, bg = colors.wave.red, gui = 'bold' },
      },
      command = {
        a = { fg = colors.wave.bg, bg = colors.wave.blue, gui = 'bold' },
      },
      inactive = {
        a = { fg = colors.wave.fg, bg = colors.wave.bg, gui = 'bold' },
        b = { fg = colors.wave.fg, bg = colors.wave.bg },
        c = { fg = colors.wave.fg, bg = colors.wave.bg },
      },
    }

    require('lualine').setup({
      options = {
        theme = kanagawa_theme,
      },
    })
  end
}
