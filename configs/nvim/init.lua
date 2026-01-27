package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/lua/?.lua"
package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/lua/util/?.lua"


require("config.lazy")
require ("config.keymaps")

local Config = require("config")
Config.init()
Config.setup({})

function PrintConfig()
  local output = vim.inspect(_G.Config)
  print(output)
--   local file = io.open("/home/ynnek/konfig/configs/nvim/lua/config/temp.lua", "w")
--   if file then
--     file:write(output)
--     file:close()
--   end
end

vim.api.nvim_create_user_command("PrintConfig", PrintConfig, {})
-- require'nvim-treesitter'.setup {
--   -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
--   install_dir = vim.fn.stdpath('data') .. '/site'
-- }
require("config.kiro")
