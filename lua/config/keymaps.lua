local has_telescope, builtin = pcall(require, "telescope.builtin")
if has_telescope then
  vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Goto Definition" })
  vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "References" })
  vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "Goto Implementation" })
  vim.keymap.set("n", "gY", builtin.lsp_type_definitions, { desc = "Goto Type Definition" })
else
  vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Goto Definition" })
  vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "References" })
  vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "Goto Implementation" })
  vim.keymap.set("n", "gY", builtin.lsp_type_definitions, { desc = "Goto Type Definition" })
end
