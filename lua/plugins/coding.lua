return {
  --Auto-complete configuration
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      return {
        auto_brackets = {
          "python",
        }, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        preselect = cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),

          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Intellij-like autocompletion
          -- <CR> to select the options
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),
          -- Use <TAB> to cycle through auto-complete option
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- <Shift-TAB> to cycle backwards
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      }
    end,
  },

  -- Refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup({
        show_success_message = true,
      })

      require("telescope").load_extension("refactoring")

      vim.keymap.set({ "n", "x" }, "<leader>rr", function()
        require("telescope").extensions.refactoring.refactors()
      end)
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- load the plugin before saving
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ lsp_fallback = true })
        end,
        desc = "Format",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format" },
        markdown = { "inject" },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    },
  },

  --Auto-pair braces and quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      require("nvim-autopairs").setup({
        enable_check_bracket_line = false,
        ignored_next_char = "[%w%.]",
      })
    end,
  },
}
