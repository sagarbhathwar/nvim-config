return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      python = { "ruff" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      group = vim.api.nvim_create_augroup("Linting", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
