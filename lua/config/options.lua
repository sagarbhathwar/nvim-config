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
vim.opt.undofile = true

-- Indentattion setting
vim.opt.autoindent = true
vim.o.breakindent = true

-- vim.o.hidden = false
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Highlight current line
vim.opt.cursorline = true

-- Min lines below cursor
vim.opt.scrolloff = 20

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Easier way to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- HACK: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!"<CR>')
