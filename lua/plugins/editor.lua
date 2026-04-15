return {
  -- Indent guides (all levels + current scope highlight)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },

  -- Highlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    enbaled = false,
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      providers = { "lsp", "treesitter" },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      -- Use a subtle background instead of underline
      -- vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#2a2b3d" })
      -- vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#2a2b3d" })
      -- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#2a2b3d" })
    end,
  },

  -- Surround motions (cs, ds, ys)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- Highlight TODO/FIXME/NOTE
  {
    "folke/todo-comments.nvim",
    opts = {},
  },

  -- File explorer as buffer
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["q"] = "actions.close",
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },
}
