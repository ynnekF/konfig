local map = vim.keymap.set
map("n", "<Space>", "<Nop>")
vim.g.leader = " "

map("n", "<leader>pv", vim.cmd.Ex)

map("n", "h", "<Nop>", { desc = "Disable default nav. key" })
-- map("n", "j", "<Nop>", { desc = "Disable default nav. key" })
-- map("n", "k", "<Nop>", { desc = "Disable default nav. key" })
map("n", "l", "<Nop>", { desc = "Disable default nav. key" })

-- map("n", "f", "<Nop>", { desc = "Disable f" })
-- map("n", "t", "<Nop>", { desc = "Disable t" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to L window " })
map("n", "<C-l>", "<C-w>l", { desc = "Go to R window " })
map("n", "<C-j>", "<C-w>j", { desc = "Go to B window " })
map("n", "<C-k>", "<C-w>k", { desc = "Go to T window " })

map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go to L window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go to R window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go to B window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go to T window" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Windows split
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
Snacks.toggle.zen():map("<leader>uz")

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- Line Navigation
map("n", "<S-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("n", "<S-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("i", "<S-Up>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<S-Down>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

map("v", "<S-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
map("v", "<S-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })

-- Search
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Write
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Normal mode
map({ "v", "i" }, "jf", "<ESC>")

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Indentation
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Terminal
-- map("n", "<leader>tm", "<CMD>ToggleTerm 1<CR>")
-- map("n", "<leader>tm2", "<CMD>ToggleTerm 2<CR>")
-- map("n", "<leader>tm3", "<CMD>ToggleTerm 3<CR>")
-- vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<C-\\><C-n><CMD>ToggleTerm<CR>", { silent = true, noremap = true })

-- Telescope
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>fr", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fk", "<cmd> Telescope keymaps <CR>")
map("n", "<leader>fg", "<cmd> Telescope git_files <CR>")
map("n", "<leader>fc", "<cmd> Telescope colorschemes <CR>")

-- Snacks + pickers
map("n", "<leader>cf", ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})<CR>")
map("n", "<leader>sm", ":lua Snacks.picker.marks()<CR>")
map("n", "<leader>sz", ":lua Snacks.zen()<CR>")

-- LSP Doc
map("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>")
map("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>")
map("n", "K", ":lua vim.lsp.buf.hover()<CR>")

vim.keymap.set("n", "gs", function()
  require("telescope.builtin").lsp_definitions()
end, { noremap = true, silent = true })

-- LSP Action
map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")

--[[
	Marks
	`.    - Jump to position where last change in current buffer
	`"    - Jump to position where last exited current buffer
	`0    - Jump to position in last file edited
	`1    - Like `0 but the previous file (same with `2)
	''    - Jump back to line in current buffer where jumped from
	``    - Jump back to position in current buffer where jumped from
	`[/`] - Jump to beginning/end of previously changed or yanked text
	`</`> - Jump to beginning/end of last visual selection
]]
map("n", "<leader>ma", ":marks<CR>")
map("n", "<leader>mc", ":delm! | delm A-Z0-9<CR>")
map("n", "<leader>mw", ":wshada!<CR>")
