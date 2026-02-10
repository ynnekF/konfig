return {
  --       {
  --     "catppuccin/nvim",
  --     lazy = false, -- Load immediately on startup
  --     priority = 1000, -- Highest priority
  --     config = function()
  --       vim.cmd([[colorscheme catppuccin-mocha]]) -- Or your desired colorscheme
  --     end,
  --   },
  -- tokyonight
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        -- your options here
        opts = { style = "dragon" },
      })
      -- vim.cmd([[colorscheme kanagawa-dragon]])
    end,
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("tokyonight").setup({
  --       -- your options here
  --       opts = { style = "night" },
  --     })
  --     vim.cmd([[colorscheme tokyonight-night]])
  --   end,
  -- },
}
