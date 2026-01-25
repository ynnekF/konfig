---@type table<string, vim.lsp.Config>
local M = {}

---@type vim.lsp.Config
M.basedpyright = {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      typeCheckingMode = "standard",
      analysis = {
        inlayHints = {
          callArgumentNames = "all",
          functionReturnTypes = true,
          pytestParameters = true,
          variableTypes = true,
        },
        autoFormatStrings = true,
      },
      linting = { enabled = true },
    },
  },
}

---@type vim.lsp.Config
M.clangd = {
  cmd = {
    "clangd",
    "--fallback-style=Google",
    "--offset-encoding=utf-16",
  },
}

---@type vim.lsp.Config
M.jdtls = {
  root_dir = require("lspconfig").util.root_pattern(
    "build.xml", -- Ant
    "pom.xml", -- Maven
    ".git",
    ".java_project",
    "build.gradle",
    "settings.gradle", -- Gradle
    "settings.gradle.kts" -- Gradle
  ) or vim.fn.getcwd(),
}

---@type vim.lsp.Config
M.lua_ls = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "Snacks" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

---@type vim.lsp.Config
M.marksman = {
  filetypes = { "markdown", "markdown.mdx", "quarto" },
  root_dir = require("lspconfig").util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
}

---@type vim.lsp.Config
M.pylsp = {
  settings = {
    pylsp = {
      configurationSources = "null",
      plugins = {
        autopep8 = {
          enabled = false,
        },
        pycodestyle = {
          enabled = false,
        },
      },
    },
  },
}

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason-lspconfig.nvim" },
    { "mason-org/mason.nvim" },
  },
  config = function()
    require("mason").setup()

    local lsp_configs = {}

    for _, f in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
      local server_name = vim.fn.fnamemodify(f, ':t:r')
      table.insert(lsp_configs, server_name)
    end

    vim.lsp.enable(lsp_configs)
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "bashls",
        "ts_ls",
      },
      automatic_enable = {
        exclude = {},
      },
    })
  end,
}
