return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    -- Core setup
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
      injected_languages = true,
      priority = 500,
    },
    -- Exclude specific filetypes
    exclude = {
      filetypes = {
        "help",
        "dashboard",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      buftypes = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
      },
    },
  },
  -- Optional: If you want to use different symbols for different contexts
  -- hooks = {
  --   char = function()
  --     return {
  --       char = "▏",
  --       highlight = "IndentBlanklineChar",
  --     }
  --   end,
  -- },
}
