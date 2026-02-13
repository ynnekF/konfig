return {
  "neovim/nvim-lspconfig",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason-lspconfig.nvim" },
    { "mason-org/mason.nvim" },
    { "saghen/blink.cmp" },
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "bashls",
        "ts_ls",
        "rust_analyzer",
      },
      automatic_enable = {
        exclude = {},
      },
    })
  end,
}
