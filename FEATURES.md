# Features & Keybindings

Leader key: `Space`

## Window Management

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h>` | n | Move to left window |
| `<C-j>` | n | Move to below window |
| `<C-k>` | n | Move to above window |
| `<C-l>` | n | Move to right window |
| `<C-Up>` | n | Increase window height |
| `<C-Down>` | n | Decrease window height |
| `<C-Left>` | n | Decrease window width |
| `<C-Right>` | n | Increase window width |

## Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<C-d>` | n | Scroll down (centered) |
| `<C-u>` | n | Scroll up (centered) |
| `n` | n | Next search result (centered) |
| `N` | n | Prev search result (centered) |
| `[b` / `]b` | n | Prev / Next buffer |
| `<leader>bd` | n | Close buffer |
| `<leader>w` | n | Save |
| `<leader>qq` | n | Toggle quickfix list |
| `-` | n | Open parent directory (Oil) |

## Editing

| Key | Mode | Description |
|-----|------|-------------|
| `J` | n | Join lines (keep cursor position) |
| `J` | v | Move selection down |
| `K` | v | Move selection up |
| `<` | v | Indent left (keep selection) |
| `>` | v | Indent right (keep selection) |
| `<leader>p` | x | Paste without yanking replaced text |
| `gcc` | n | Toggle line comment (built-in) |
| `gc` | v | Toggle comment on selection (built-in) |
| `cs"'` | n | Change surrounding `"` to `'` (nvim-surround) |
| `ds"` | n | Delete surrounding `"` |
| `ys{motion}"` | n | Add surrounding `"` |

## Search & Find (Telescope)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader><space>` | n | Find files |
| `<leader>/` | n | Live grep |
| `<leader>,` | n | Switch buffer (MRU) |
| `<leader>:` | n | Command history |
| `<leader>sw` | n | Grep word under cursor |
| `<leader>sr` | n | Resume last picker |
| `<leader>fo` | n | Recent files |
| `<leader>sh` | n | Search help tags |
| `<leader>sk` | n | Search keymaps |

## LSP (active when a language server is attached)

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Goto definition (Telescope) |
| `gD` | n | Goto declaration |
| `gr` | n | Find references (Telescope) |
| `gI` | n | Goto implementation (Telescope) |
| `gY` | n | Goto type definition (Telescope) |
| `K` | n | Hover docs |
| `gK` | n | Signature help |
| `<leader>cr` | n | Rename symbol |
| `<leader>ca` | n, v | Code action |
| `<leader>cd` | n | Line diagnostics (float) |
| `<leader>ci` | n | Toggle inlay hints |
| `<leader>cl` | n | LSP info |
| `<leader>ss` | n | Document symbols (Telescope) |
| `<leader>sS` | n | Workspace symbols (Telescope) |
| `<leader>sd` | n | Search diagnostics (Telescope) |
| `]d` | n | Next diagnostic |
| `[d` | n | Previous diagnostic |
| `]e` | n | Next error |
| `[e` | n | Previous error |

## Git

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gg` | n | Open LazyGit |
| `<leader>gc` | n | Git commits (Telescope) |
| `<leader>gs` | n | Git status (Telescope) |
| `<leader>gd` | n | Open CodeDiff |
| `<leader>gf` | n | File history (current file) |

### Hunks (Gitsigns)

| Key | Mode | Description |
|-----|------|-------------|
| `]h` | n | Next hunk |
| `[h` | n | Previous hunk |
| `]H` | n | Last hunk |
| `[H` | n | First hunk |
| `<leader>hs` | n, v | Stage hunk |
| `<leader>hr` | n, v | Reset hunk |
| `<leader>hu` | n | Undo stage hunk |
| `<leader>hS` | n | Stage buffer |
| `<leader>hR` | n | Reset buffer |
| `<leader>hb` | n | Blame line |
| `<leader>hd` | n | Diff this |
| `<leader>hD` | n | Diff this ~ |
| `ih` | o, x | Select hunk (text object) |

## Diagnostics Panel (Trouble)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>xx` | n | Toggle diagnostics |
| `<leader>xb` | n | Buffer diagnostics |
| `<leader>xs` | n | Symbols |
| `]q` | n | Next trouble/quickfix item |
| `[q` | n | Previous trouble/quickfix item |

## Debugging (DAP)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>dc` | n | Run / Continue |
| `<leader>da` | n | Run with args |
| `<leader>dq` | n | Terminate |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Conditional breakpoint |
| `<leader>dn` | n | Step over |
| `<leader>di` | n | Step into |
| `<leader>do` | n | Step out |
| `<leader>dC` | n | Run to cursor |
| `<leader>dj` | n | Stack down |
| `<leader>dk` | n | Stack up |
| `<leader>dt` | n | Toggle DAP view |
| `<leader>dPt` | n | Debug method (Python) |
| `<leader>dPc` | n | Debug class (Python) |

## Terminal (toggleterm)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tt` | n | Toggle terminal (horizontal) |
| `<leader>tf` | n | Toggle terminal (float) |
| `<leader>tv` | n | Toggle terminal (vertical) |
| `<Esc><Esc>` | t | Exit terminal mode |

## Formatting (conform)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>f` | n | Format file |

Commands: `:FormatDisable` / `:FormatEnable` to toggle auto-format on save.

## Completion (nvim-cmp)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-y>` | i | Accept completion / expand snippet |
| `<C-n>` | i, s | Next item / jump to next snippet field |
| `<C-p>` | i, s | Previous item / jump to previous snippet field |
| `<C-Space>` | i | Trigger completion |
| `<C-b>` | i | Scroll docs up |
| `<C-f>` | i | Scroll docs down |
| `<C-CR>` | i | Dismiss completion and insert newline |

## Treesitter Text Objects

| Key | Mode | Description |
|-----|------|-------------|
| `af` / `if` | o, x | Select around/inside function |
| `ac` / `ic` | o, x | Select around/inside class |
| `aa` / `ia` | o, x | Select around/inside parameter |
| `]f` / `[f` | n | Next / previous function |
| `]c` / `[c` | n | Next / previous class |
| `]a` / `[a` | n | Next / previous parameter |

## Automatic Behaviors

- **Auto-format on save** — via conform.nvim (ruff + stylua)
- **Auto-lint on save** — via nvim-lint (ruff)
- **Auto-pairs** — brackets, quotes auto-close; `()` inserted on function completion
- **Auto-reload** — files changed externally (e.g. by Claude Code) are reloaded
- **Highlight on yank** — brief flash confirms what was copied
- **Restore cursor** — reopening a file returns to last position
- **Treesitter folding** — code folding via `zc`/`zo`/`za`, all folds open by default

## Installed Plugins

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| tokyonight.nvim | Colorscheme |
| telescope.nvim | Fuzzy finder |
| telescope-fzf-native | FZF sorting for Telescope |
| telescope-ui-select | Telescope for `vim.ui.select` |
| nvim-treesitter | Syntax highlighting, folding, text objects |
| nvim-cmp | Completion engine |
| cmp-nvim-lsp | LSP completion source |
| cmp-buffer | Buffer word completion source |
| cmp-path | File path completion source |
| cmp-cmdline | Command line completion source |
| LuaSnip | Snippet engine |
| nvim-autopairs | Auto-close brackets/quotes |
| conform.nvim | Formatting (stylua, ruff) |
| nvim-lint | Linting (ruff) |
| mason.nvim | LSP/tool installer |
| mason-lspconfig | Mason + LSP integration |
| gitsigns.nvim | Git signs + hunk operations |
| lazygit.nvim | LazyGit integration |
| diffview.nvim | ~~Multi-file diff review~~ (replaced by codediff.nvim) |
| codediff.nvim | VSCode-style diff review with character-level highlighting |
| nvim-dap | Debug adapter protocol |
| nvim-dap-python | Python debugging |
| nvim-dap-view | DAP UI panel |
| nvim-dap-virtual-text | Inline debug values |
| trouble.nvim | Diagnostics panel |
| noice.nvim | Enhanced command line & messages |
| lualine.nvim | Statusline |
| which-key.nvim | Keymap discovery |
| indent-blankline.nvim | Indent guides |
| vim-illuminate | Highlight word under cursor |
| nvim-surround | Surround motions |
| todo-comments.nvim | Highlight TODO/FIXME/NOTE |
| oil.nvim | File explorer as buffer |
| toggleterm.nvim | Terminal integration |

## LSP Servers

| Server | Language | Installed via |
|--------|----------|---------------|
| pyright | Python | Mason |
| lua_ls | Lua | Mason |
