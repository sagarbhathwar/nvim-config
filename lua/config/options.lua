-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd.colorscheme("tokyonight")

-- Code-folding options
-- vim.opt.foldmethod = "expr"
-- -- :h vim.treesitter.foldexpr()
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--
-- -- ref: https://github.com/neovim/neovim/pull/20750
-- vim.opt.foldtext = ""
-- vim.opt.fillchars:append("fold: ")
--
-- -- Open all folds by default, zm is not available
-- vim.opt.foldlevelstart = 99

-- Undo file
vim.o.undofile = false

-- vim.o.hidden = false
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
