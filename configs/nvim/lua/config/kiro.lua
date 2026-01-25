local kiro_buf = nil
local kiro_win = nil

local function toggle_kiro()
  if kiro_win and vim.api.nvim_win_is_valid(kiro_win) then
    vim.api.nvim_win_hide(kiro_win)
    kiro_win = nil
  else
    if kiro_buf and vim.api.nvim_buf_is_valid(kiro_buf) then
      kiro_win = vim.api.nvim_open_win(kiro_buf, true, {
        relative = "editor",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        col = math.floor(vim.o.columns * 0.1),
        row = math.floor(vim.o.lines * 0.1),
        style = "minimal",
        border = "rounded",
      })
    else
      kiro_buf = vim.api.nvim_create_buf(false, true)
      kiro_win = vim.api.nvim_open_win(kiro_buf, true, {
        relative = "editor",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        col = math.floor(vim.o.columns * 0.1),
        row = math.floor(vim.o.lines * 0.1),
        style = "minimal",
        border = "rounded",
      })
      vim.fn.termopen("kiro-cli chat")
    end
  end
end

local kiro_buf_split = nil
local kiro_win_split = nil

local function toggle_kiro_buf(opts)
  if kiro_win_split and vim.api.nvim_win_is_valid(kiro_win_split) then
    vim.api.nvim_win_hide(kiro_win_split)
    kiro_win_split = nil
  else
    if not kiro_buf_split or not vim.api.nvim_buf_is_valid(kiro_buf_split) then
      kiro_buf_split = vim.api.nvim_create_buf(false, true)
    end
    local direction = opts.args or "bottom"
    local cmd_map = {
      bottom = "botright split",
      top = "topleft split",
      left = "topleft vsplit",
      right = "botright vsplit",
    }
    vim.cmd(cmd_map[direction] or cmd_map.bottom)
    kiro_win_split = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(kiro_win_split, kiro_buf_split)
    if direction == "left" or direction == "right" then
      vim.api.nvim_win_set_width(kiro_win_split, 80)
    else
      vim.api.nvim_win_set_height(kiro_win_split, 15)
    end
    if vim.bo[kiro_buf_split].buftype ~= "terminal" then
      vim.fn.termopen("kiro-cli chat")
    end
  end
end

vim.api.nvim_create_user_command("Kiro", toggle_kiro, {})
vim.keymap.set("n", "<leader>k", toggle_kiro, { desc = "Toggle Kiro" })

vim.api.nvim_create_user_command("KiroBuf", toggle_kiro_buf, { nargs = "?" })
vim.keymap.set("n", "<leader>kb", toggle_kiro_buf, { desc = "Toggle Kiro Buffer" })

local function brazil_build(opts)
  local target = opts.args ~= "" and opts.args or ""
  local cwd = vim.fn.expand("%:p:h")

  if
    vim.fn.filereadable(cwd .. "/packageInfo") == 0
    and vim.fn.filereadable(cwd .. "/package-lock.json") == 0
    and vim.fn.filereadable(cwd .. "/Config") == 0
  then
    vim.notify(
      "Not in a Brazil package directory (no packageInfo, package-lock.json, or Config found)",
      vim.log.levels.ERROR
    )
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.cmd("botright split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_win_set_height(win, 15)
  vim.fn.termopen("brazil-build " .. target, { cwd = cwd })
end

vim.api.nvim_create_user_command("BrazilBuild", brazil_build, { nargs = "?" })
vim.keymap.set("n", "<leader>br", function()
  brazil_build({ args = "" })
end, { desc = "Brazil Build" })
