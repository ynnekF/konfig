return {
  {
    'akinsho/toggleterm.nvim',
    enabled = true,
    lazy = false,
    version = "*",
    opts = {
      direction = "horizontal"
    },
    keys = {
      { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Open ToggleTerm" },
    },
    config = true
  }
}
