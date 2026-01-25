return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- optional but recommended
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    keys = {
      -- disable the keymap to grep files
      { "<leader>/", false },
      -- change a keymap
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for > ") })
        end,
        desc = "Grep for String",
      },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Git Files",
      },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          colorscheme = {
            enable_preview = true, -- shows a live preview as you scroll
            layout_config = {
              height = 0.4,
              width = 0.4,
              prompt_position = "top", -- moves prompt to the top of the popup
            },
            layout_strategy = "center", -- centers the popup on screen
          },
        },
      })
    end,
  },
}
