local map = vim.keymap.set
map("n", "<Space>", "<Nop>")
vim.g.leader = " "

--[[
Shift + g -- Move to the last line of the file. (A number before G, like 10G, moves to that specific line number).
Shift + j -- Join the current line with the line below it.
Shift + o -- Open a new line above the current line and enter Insert mode.
Shift + a -- Jump to the end of the current line and enter Insert mode.
Shift + i -- Jump to the first non-blank character of the current line and enter Insert mode.
Shift + d -- Delete from the cursor to the end of the line.
Shift + y -- Yank (copy) the current line.
Shift + p -- Paste the copied/deleted text before the cursor (lowercase p pastes after).
Shift + x -- Delete the character before the cursor (lowercase x deletes the character under the cursor).
Shift + ` -- Switch the case of the character under the cursor
Ctrl + o  -- Jump to the older position in the jump list (previous location).
Ctrl + i  -- Jump to the newer position in the jump list (next location).
g;        -- Jump to the older position in the change list (previous change).
g,        -- Jump to the newer position in the change list (next change).
[a/A      -- Prev param. start/end 
[c/C      -- Prev param. start/end
[f/F      -- Prev func. start/end
[h/H      -- Next/prev hunk.

vim.keymap.set options
noremap = true, -- Do not allow remapping of the mapped key
silent = true, -- Do not show the command in the command line when the key is pressed
expr = true,   -- The right-hand side of the mapping is evaluated as an expression
unique = true, -- Ensure that the mapping is unique and does not override existing mappings
nowait = true, -- Do not wait for further key sequences after the mapped key is pressed
force = true,  -- Force the mapping even if it already exists
script = true, -- Allow the mapping to be used in scripts

Marks
	`.    - Jump to position where last change in current buffer
	`"    - Jump to position where last exited current buffer
	`0    - Jump to position in last file edited
	`1    - Like `0 but the previous file (same with `2)
	''    - Jump back to line in current buffer where jumped from
	``    - Jump back to position in current buffer where jumped from
	`[/`] - Jump to beginning/end of previously changed or yanked text
	`</`> - Jump to beginning/end of last visual selection
--]]

map("n", "t", "<Nop>", { desc = "Disable default nav. key" })

-- Core
map({ "v", "i", "c" }, "jf", "<ESC>", { noremap = true, desc = "To normal mode" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Search navigation (direction-aware)
local next_search = "'Nn'[v:searchforward]"
local prev_search = "'nN'[v:searchforward]"
map({ "o", "x" }, "n", next_search, { expr = true, desc = "Next Search Result" })
map({ "o", "x" }, "N", prev_search, { expr = true, desc = "Prev Search Result" })
map("n", "n", next_search .. ".'zv'", { expr = true, desc = "Next Search Result" })
map("n", "N", prev_search .. ".'zv'", { expr = true, desc = "Prev Search Result" })

-- Window Navigation
for _, key in ipairs({ "h", "j", "k", "l" }) do
  map("n", "<C-" .. key .. ">", "<C-w>" .. key)
  map("t", "<C-" .. key .. ">", "<cmd>wincmd " .. key .. "<CR>")
end
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- stylua: ignore start
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
-- stylua: ignore end

-- Navigation
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map({ "n", "o", "x" }, ";", "f", { noremap = true })
map({ "n", "o", "x" }, "f", "F", { noremap = true })

-- Line movement
map("n", "<S-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("n", "<S-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("i", "<S-Up>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<S-Down>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<S-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
map("v", "<S-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })

-- Code
map("n", "K", ":lua vim.lsp.buf.hover()<CR>")
map("v", "<", "<gv", { desc = "Indent" })
map("v", ">", ">gv", { desc = "Indent" })
map("n", "cc", "gcc", { remap = true, desc = "Toggle comment line" })
map("v", "cc", "gc", { remap = true, desc = "Toggle comment block" })
map("n", "cco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "ccO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>gr", ":lua vim.lsp.buf.references()<CR>")
map("n", "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>")
map("n", "<leader>gs", ":lua vim.lsp.buf.definition()<CR>")

-- Telescope
map("n", "<leader>km", "<cmd>lua require('telescope.builtin').keymaps()<CR>", { desc = "View Keymaps" })
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>fW", "<cmd> Telescope grep_string <CR>")
map("n", "<leader>fr", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fk", "<cmd> Telescope keymaps <CR>")
map("n", "<leader>fg", "<cmd> Telescope git_files <CR>")
map("n", "<leader>fc", "<cmd> Telescope colorschemes <CR>")
map("n", "<leader>fj", "<cmd> Telescope jumplist <CR>")

-- Snacks + pickers
map("n", "<leader>cf", ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})<CR>")
map("n", "<leader>m", ":lua Snacks.picker.marks()<CR>")
map("n", "<leader>sz", ":lua Snacks.zen()<CR>")
map({ "n", "t" }, ",.", function()
  if vim.bo.buftype == "terminal" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
  end
  require("snacks.terminal").toggle()
end, { desc = "Toggle terminal" })

-- Copilot
map("n", "cp", ":Copilot panel<CR>", { desc = "Open Copilot Panel" })
