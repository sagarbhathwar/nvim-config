return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Terminal (horizontal)" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Terminal (float)" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle Terminal (vertical)" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = false,
    float_opts = {
      border = "rounded",
    },
  },
}
