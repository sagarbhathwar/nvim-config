-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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


require("config.lazy")
require("config").setup()
