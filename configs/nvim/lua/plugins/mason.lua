return {
  {
    "mason-org/mason.nvim",
    enabled = true,
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = true,
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {},
  }
}
