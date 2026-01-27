return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    version = "*",
    lazy = false,
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
        path_display = { "truncate" },
        prompt_prefix = "🔍 ",
        results_title = vim.fn.getcwd(),
      },
    },
    keys = {
      -- disable the keymap to grep files
      { "<leader>/", false },
      -- change a keymap
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      {
        "<leader>fw",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Git Files",
      },
      {
        "<leader>FF",
        function()
          require("telescope.builtin").live_grep({ cwd = vim.fn.expand('%:p:h') })
        end,
        desc = "Grep cur dir",
      },
      {
        "<leader>gw",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>"), cwd = vim.fn.expand('%:p:h') })
        end,
        desc = "Grep cur word",
      }
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
          find_files = {
            theme = "ivy"
          },
        },
      })
    end,
  },
}
