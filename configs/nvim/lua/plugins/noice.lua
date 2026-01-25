-- local spinners = require("noice.util.spinners")
-- spinners.spinners["moon"] = {
--     -- stylua: ignore
--     frames = {
--         " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
--         " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "
--     },
--     interval = 80,
-- }

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = true,
  opts = function()
    local icons = _G.Config.config.icons
    return {
      format = {
        spinner = {
          name = "moon",
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
      },
      cmdline = {
        view = "cmdline_popup",
        format = {
          cmdline = { pattern = "^:", icon = icons.cmdline, lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = icons.search_down, lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = icons.search_up, lang = "regex" },
          filter = { pattern = "^:%s*!", icon = icons.bash, lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = icons.lua, lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = icons.help },
          calculator = { pattern = "^=", icon = icons.calculator, lang = "vimnormal" },
          input = {},
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        message = {
          enabled = false,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            event = "lsp",
            kind = "progress",
            cond = function(message)
              local client = vim.tbl_get(message.opts, "progress", "client")
              local title = vim.tbl_get(message.opts, "progress", "title")
              return title == "Finding references" or client == "null-ls" or client == "grammar_guard"
            end,
          },
          opts = { skip = true },
        },
        {
          filter = { find = "method textDocument/codeLens is not supported" },
          opts = { skip = true },
        },
        {
          filter = { find = "Invalid offset" },
          opts = { skip = true },
        },
        {
          filter = { find = "No information available" },
          opts = { skip = true },
        },
        {
          filter = { kind = "echo", find = "[WakaTime]" },
          opts = { skip = true },
        },
      },
    }
  end,
  keys = function()
    return {
      { "<leader>sn", "", desc = "+noice" },
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>sna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<leader>snd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All",
      },
      {
        "<leader>snt",
        function()
          require("noice").cmd("pick")
        end,
        desc = "Noice Picker (Telescope/FzfLua)",
      },
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll Forward",
        mode = { "i", "n", "s" },
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll Backward",
        mode = { "i", "n", "s" },
      },
    }
  end,
  config = function(_, opts)
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    require("noice").setup(opts)
  end,
}
