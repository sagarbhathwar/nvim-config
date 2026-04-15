return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "bash",
          "c",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "vim",
          "vimdoc",
          "yaml",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]a"] = "@parameter.inner",
            },
            goto_prev_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[a"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },
}
