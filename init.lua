-- 1. Leaders FIRST (before any keymap or lazy spec)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 2. Options SECOND (before any plugin loads)
require("config.options")

-- 3. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  change_detection = { notify = false },
  spec = { { import = "plugins" } },
})

-- 4. Keymaps + autocmds AFTER plugins (so pcall(require, "telescope.builtin") works)
require("config.keymaps")
require("config.autocmds")

-- 5. Enable LSP servers from lsp/ directory
local lsp_configs = {}
for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  lsp_configs[vim.fn.fnamemodify(v, ":t:r")] = true
end
vim.lsp.enable(vim.tbl_keys(lsp_configs))
