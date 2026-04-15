-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resize
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffer
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })

-- Quickfix
vim.keymap.set("n", "<leader>qq", function()
  local qf_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_open = true
      break
    end
  end
  if qf_open then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle Quickfix" })

-- Navigation (centered)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- Editing
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left (keep selection)" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right (keep selection)" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste (don't yank replaced)" })

-- Telescope extras
vim.keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "Grep Word Under Cursor" })
vim.keymap.set("n", "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "Resume Last Picker" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Search Help" })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Search Keymaps" })

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

