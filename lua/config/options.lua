-- OSC-52 clipboard (required for SSH)
vim.g.clipboard = "osc52"

-- Disable mouse to build better habits
vim.opt.mouse = ""

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Faster CursorHold (gitsigns, illuminate)
vim.opt.updatetime = 250

-- Undo file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Auto-reload files changed externally (e.g. by Claude Code)
vim.opt.autoread = true

-- Indentation setting
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

-- Diagnostics
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  float = {
    border = "rounded",
    source = true,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
})

-- Git diff context window
vim.opt.diffopt:append("context:10")
