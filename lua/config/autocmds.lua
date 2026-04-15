-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Restore cursor to last position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Trigger checktime on focus/buffer enter so autoread picks up external changes
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("AutoRead", { clear = true }),
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- LSP keymaps (buffer-local, only when a server is attached)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(ev)
    local buf = ev.buf
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end

    -- Navigation (via Telescope when available, fallback to vim.lsp.buf)
    local has_telescope, builtin = pcall(require, "telescope.builtin")
    if has_telescope then
      map("n", "gd", builtin.lsp_definitions, "Goto Definition")
      map("n", "gr", builtin.lsp_references, "References")
      map("n", "gI", builtin.lsp_implementations, "Goto Implementation")
      map("n", "gY", builtin.lsp_type_definitions, "Goto Type Definition")
      map("n", "<leader>ss", builtin.lsp_document_symbols, "Document Symbols")
      map("n", "<leader>sS", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
      map("n", "<leader>sd", builtin.diagnostics, "Diagnostics")
    else
      map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      map("n", "gr", vim.lsp.buf.references, "References")
      map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
      map("n", "gY", vim.lsp.buf.type_definition, "Goto Type Definition")
    end
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")

    -- Hover and signature
    map("n", "K", vim.lsp.buf.hover, "Hover Docs")
    map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")

    -- Code actions
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

    -- Diagnostics
    map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
    map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", "LSP Info")

    -- Inlay hints toggle (only if server supports it)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      map("n", "<leader>ci", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
      end, "Toggle Inlay Hints")
    end

    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, "Next Diagnostic")
    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, "Prev Diagnostic")
    map("n", "]e", function()
      vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
    end, "Next Error")
    map("n", "[e", function()
      vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
    end, "Prev Error")
  end,
})
