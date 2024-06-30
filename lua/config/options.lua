-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.expandtab = true
opt.shiftwidth = 2

opt.ignorecase = true

opt.smoothscroll = true
-- opt.foldexpr = "v:lua.require'util.ui'.foldexpr()"
opt.foldmethod = "expr"
opt.foldtext = ""

-- TODO: Remove after getting rid of LazyVim
opt.showtabline = 0

vim.cmd.colorscheme("tokyonight")
