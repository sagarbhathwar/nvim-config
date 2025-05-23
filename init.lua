require("config.lazy")
require("config").setup()

local configs = {}

for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  local name = vim.fn.fnamemodify(v, ":t:r")
  configs[name] = true
end

vim.lsp.enable(vim.tbl_keys(configs))
