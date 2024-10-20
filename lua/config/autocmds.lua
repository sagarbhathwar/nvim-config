-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here


local ns = vim.api.nvim_create_namespace("vim_lsp_references")

local get = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local current, ret = nil, {}
  for _, extmark in ipairs(vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { details = true })) do
    local w = {
      from = { extmark[2] + 1, extmark[3] },
      to = { extmark[4].end_row + 1, extmark[4].end_col },
    }
    ret[#ret + 1] = w
    if cursor[1] >= w.from[1] and cursor[1] <= w.to[1] and cursor[2] >= w.from[2] and cursor[2] <= w.to[2] then
      current = #ret
    end
  end
  return ret, current
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buffer = args.buf
    -- Disable hover capability from ruff
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end

    if client.supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation
      vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
    end

    if client.supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true)

      vim.keymap.set("n", "<leader>uh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "Toggle inlay hints" })
    end

    -- CodeLens
    if client.supports_method('textDocument/codeLens') then
      vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = buffer,
        callback = vim.lsp.codelens.refresh,
      })
      vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
      vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
    end

    -- Document Highlight
    if client.supports_method("textDocument/documentHighlight") then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" }, {
        group = vim.api.nvim_create_augroup("lsp_word_" .. buffer, { clear = true }),
        buffer = buffer,
        callback = function(ev)
          local has_cmp, cmp = pcall(require, "cmp")
          if not has_cmp or not cmp.visible() then
            if not ({ get() })[2] then
              if ev.event:find("CursorMoved") then
                vim.lsp.buf.clear_references()
              end
              vim.lsp.buf.document_highlight()
            end
          else
            vim.lsp.buf.clear_references()
          end
        end
      })
    end
  end
})
