return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = (vim.fn.executable("make") == 1) and "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    keys = {
      -- Godly to avoid using tabs
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },

      {
        "<leader><space>",
        "<cmd>Telescope find_files<cr>",
        desc = "Find Files (Root Dir)",
      },

      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },

      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
    },
    config = function()
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
    end,
  },
}
