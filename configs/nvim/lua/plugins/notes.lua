return {
  {
    "notes",
    dir = vim.fn.stdpath("config"),
    config = function()
      local function open_note(opts)
        local buf = vim.api.nvim_create_buf(false, true)
        local width = 60
        local height = 15
        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          col = (vim.o.columns - width) / 2,
          row = (vim.o.lines - height) / 2,
          style = "minimal",
          border = "rounded",
        })

        if opts.args == "show" then
          local map_file = vim.fn.stdpath("config") .. "/map.txt"
          if vim.fn.filereadable(map_file) == 1 then
            local lines = vim.fn.readfile(map_file)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
            vim.api.nvim_buf_set_option(buf, "modifiable", false)
          end
        else
          vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
          vim.cmd("startinsert")
        end

        vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":q<CR>", { noremap = true, silent = true })
      end

      vim.api.nvim_create_user_command("Note", open_note, { nargs = "?" })
    end,
  },
}
