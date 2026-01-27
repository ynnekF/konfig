return {
  "folke/snacks.nvim",
  enabled = true,
  priority = 1000,
  lazy = false,
  opts = {
    keys = {
      {
        "<leader>n",
        function()
          if Snacks.config.picker and Snacks.config.picker.enabled then
            Snacks.picker.notifications()
          else
            Snacks.notifier.show_history()
          end
        end,
        desc = "Notification History",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
    bigfile = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    picker = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    terminal = { enabled = false },
		styles = {
			notification = {
				wo = { wrap = true }
			}
		},
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = {},
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { key = "n", desc = "New File", action = ":ene | startinsert" },
            { key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { key = "s", desc = "Restore Session", section = "session" },
            --- { key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { key = "l", desc = "Lazy", action = ":Lazy" },
            { key = "q", desc = "Quit", action = ":qa" },
          },
      },
    },
  },
}
