-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
vim.g.leader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Disable default keys
vim.keymap.set("n", "<Space>", "<Nop>")
vim.keymap.set("n", "j", "<Nop>")
vim.keymap.set("n", "k", "<Nop>")
vim.keymap.set("n", "l", "<Nop>")

-- Buffer Navigation
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
vim.keymap.set("n", "<Tab>", ":bnext<CR>")

-- Line Navigation
-- vim.keymap.set("n", "u", "0")
-- vim.keymap.set("n", "o", "$")
vim.keymap.set("n", "<S-Down>", ":m+<CR>")
vim.keymap.set("n", "<S-Up>", ":m-2<CR>")

-- Indentation
vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "<", "<<")

-- Search Navigation
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Insert Line Below
vim.keymap.set("n", "<S-i>", "o")

vim.keymap.set("i", "jf", "<ESC>")
vim.keymap.set("i", "<S-Down>", "<ESC>:m+<CR>")
vim.keymap.set("i", "<S-Up>", "<ESC>:m-2<CR>")
vim.keymap.set("v", "<", "<<")
vim.keymap.set("v", ">", ">>")

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true, noremap = true })
---{ key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
---            { key = "n", desc = "New File", action = ":ene | startinsert" },
---            { key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
---            { key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
---            { key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
---            { key = "s", desc = "Restore Session", section = "session" },
---            { key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
---            { key = "l", desc = "Lazy", action = ":Lazy" },
---            { key = "q", desc = "Quit", action = ":qa" },
---          },

vim.keymap.set("n", "<leader>rf", ":lua Snacks.dashboard.pick('oldfiles')<CR>")
vim.keymap.set("n", "<leader>cf", ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})<CR>")
