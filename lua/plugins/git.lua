return {
  -- Gitsigns: inline git signs + hunk operations
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- Hunk navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")

        map("n", "]H", function()
          gs.nav_hunk("last")
        end, "Last Hunk")
        map("n", "[H", function()
          gs.nav_hunk("first")
        end, "First Hunk")

        -- Hunk operations (<leader>h = "hunk")
        map({ "n", "v" }, "<leader>hs", gs.stage_hunk, "Stage Hunk")
        map({ "n", "v" }, "<leader>hr", gs.reset_hunk, "Reset Hunk")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>hd", gs.diffthis, "Diff This")
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, "Diff This ~")

        -- Hunk text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
    },
    config = function()
      local has_telescope, telescope = pcall(require, "telescope")
      if has_telescope then
        telescope.load_extension("lazygit")
      end
    end,
  },

  -- Multi-file diff review
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    },
    opts = {
      enhanced_diff_hl = true,
    },
    config = function(_, opts)
      require("diffview").setup(opts)

      -- Make filler lines (lines that don't exist on one side) subtle
      -- instead of bright red, use a dim background
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#2d202a", fg = "#3b3052" })
      -- Tone down diff backgrounds for readability
      -- vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1a2e1a" })
      -- vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1a2a3a" })
      -- vim.api.nvim_set_hl(0, "DiffText", { bg = "#2a4a5a" })
    end,
  },
}
