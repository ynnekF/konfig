return {
  {
    "folke/flash.nvim",
    enabled = true,
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = { enabled = true },
        char = {
          keys = {},
        },
      },
    },
    keys = {
      { "f", false, { desc = "Flash binding" } },
      { "F", false, { desc = "Flash binding" } },
      { "t", false, { desc = "Flash binding" } },
      { "T", false, { desc = "Flash binding" } },
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "flash",
      },
    },
  },
}
