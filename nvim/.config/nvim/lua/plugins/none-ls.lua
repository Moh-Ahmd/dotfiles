return {

  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local gdformat = {
      method = null_ls.methods.FORMATTING,
      filetypes = {"gdscript"},
      generator = null_ls.generator({
        command = "gdformat",
        args = {"-"},
        to_stdin = true,
      }),
    }
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        require("none-ls.diagnostics.flake8"),
        -- null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.pylint,
        -- null_ls.builtins.diagnostics.mypy,
        gdformat,
        null_ls.builtins.formatting.clang_format,


      },
      autostart = true,
    })
    -- Add keybinding for formatting
    vim.keymap.set({ "n", "v" }, "<space>fm", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format file or range (in visual mode)" })


    -- Set up autoformatting on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
}
