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
      },
      automatic_enable = {
        exclude = {},
      },
    })

    vim.lsp.config("rust_analyzer", {
      cmd = { vim.fn.expand("~/.toolbox/bin/rust-analyzer") },
      filetypes = { "rust" },
      root_markers = { "Cargo.toml" },
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          checkOnSave = true,
          check = { command = "clippy" },
        },
      },
    })
    vim.lsp.enable("rust_analyzer")
  end,
}
