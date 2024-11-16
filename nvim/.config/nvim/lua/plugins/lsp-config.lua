return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",

    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {"clangd", "pyright", "texlab"} 

      })
    end

  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({
        capabilities = capabilities

      })
      lspconfig.pyright.setup({
        capabilities = capabilities
      })
      lspconfig.gdscript.setup({
        capabilities = capabilities
      })
      lspconfig.texlab.setup({
        capabilities = capabilities
      })

    end

  }



}



