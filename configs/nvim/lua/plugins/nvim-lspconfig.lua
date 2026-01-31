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

    -- local lsp_configs = {}
    -- for _, f in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
    --   local server_name = vim.fn.fnamemodify(f, ':t:r')
    --   table.insert(lsp_configs, server_name)
    -- end
    -- vim.lsp.enable(lsp_configs)
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
  end,
}
