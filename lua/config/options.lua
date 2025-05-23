vim.cmd.colorscheme("tokyonight")

-- OSC-52 clipboard
vim.g.clipboard = "osc52"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Undo file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Indentattion setting
vim.opt.autoindent = true
vim.o.breakindent = true

-- Highlight current line
vim.opt.cursorline = true

-- Disable search highlight
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Min lines below cursor
vim.opt.scrolloff = 20
vim.opt.smoothscroll = true

-- Code-folding options
vim.opt.foldmethod = "expr"
-- :h vim.treesitter.foldexpr()
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- ref: https://github.com/neovim/neovim/pull/20750
vim.opt.foldtext = ""
vim.opt.fillchars:append("fold: ")

-- Open all folds by default, zm is not available
vim.opt.foldlevelstart = 99

-- NOTE: Making life a bit harder
vim.opt.mouse = ""
