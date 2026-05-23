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

  -- LazyGit integration (temporarily disabled)
  {
    "kdheepak/lazygit.nvim",
    enabled = false,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Neogit: magit-style git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "esmuellert/codediff.nvim",
      "m00qek/baleia.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    opts = {},
  },
}
