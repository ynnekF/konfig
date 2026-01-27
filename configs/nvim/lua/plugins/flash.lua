return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "flash",
      },
      -- { "s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "flash treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "remote flash" },
      -- { "r", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "treesitter search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "toggle flash search" },
    },
  },
}
