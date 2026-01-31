return {
  {
    "folke/which-key.nvim",
    enabled = false,
    event = "VeryLazy",
    loop = true,
    opts = {
      preset = "modern",
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      triggers = {
        { "<auto>", mode = "nixsotc" },
      },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
      ellipsis = "…",
      -- set to false to disable all mapping icons,
      -- both those explicitly added in a mapping
      -- and those from rules
      mappings = true,
      --- See `lua/which-key/icons.lua` for more details
      --- Set to `false` to disable keymap icons from rules
      ---@type wk.IconRule[]|false
      rules = {},
      -- use the highlights from mini.icons
      -- When `false`, it will use `WhichKeyIcon` instead
      colors = true,
      -- used by key format
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
      },
    },
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    -- disable WhichKey for certain buf types and file types.
    disable = {
      ft = {},
      bt = {},
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts_extend = { "spec" },
  --   opts = {
  --     preset = "helix",
  --     defaults = {},
  --     spec = {
  --       {
  --         mode = { "n", "x" },
  --         { "<leader><tab>", group = "tabs" },
  --         { "<leader>c", group = "code" },
  --         { "<leader>d", group = "debug" },
  --         { "<leader>dp", group = "profiler" },
  --         { "<leader>f", group = "file/find" },
  --         { "<leader>g", group = "git" },
  --         { "<leader>gh", group = "hunks" },
  --         { "<leader>q", group = "quit/session" },
  --         { "<leader>s", group = "search" },
  --         { "<leader>u", group = "ui" },
  --         { "<leader>x", group = "diagnostics/quickfix" },
  --         { "[", group = "prev" },
  --         { "]", group = "next" },
  --         { "g", group = "goto" },
  --         { "gs", group = "surround" },
  --         { "z", group = "fold" },
  --         {
  --           "<leader>b",
  --           group = "buffer",
  --           expand = function()
  --             return require("which-key.extras").expand.buf()
  --           end,
  --         },
  --         {
  --           "<leader>w",
  --           group = "windows",
  --           proxy = "<c-w>",
  --           expand = function()
  --             return require("which-key.extras").expand.win()
  --           end,
  --         },
  --         -- better descriptions
  --         { "gx", desc = "Open with system app" },
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>?",
  --       function()
  --         require("which-key").show({ global = false })
  --       end,
  --       desc = "Buffer Keymaps (which-key)",
  --     },
  --     {
  --       "<c-w><space>",
  --       function()
  --         require("which-key").show({ keys = "<c-w>", loop = true })
  --       end,
  --       desc = "Window Hydra Mode (which-key)",
  --     },
  --   },
  --   config = function(_, opts)
  --     local wk = require("which-key")
  --     wk.setup(opts)
  --     if not vim.tbl_isempty(opts.defaults) then
  --       LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
  --       wk.register(opts.defaults)
  --     end
  --   end,
  -- },
}
