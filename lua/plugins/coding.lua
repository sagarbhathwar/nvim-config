return {
  -- Simpler completion plugin
  --
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      -- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        preselect = cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),

          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Intellij-like autocompletion
          -- <CR> to select the options
          ["<C-y>"] = cmp.mapping(function(fallback)
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
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- <Shift-TAB> to cycle backwards
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-Space>"] = cmp.mapping(function(fallback)
            cmp.close()
          end, { "i" }),

          ["<C-CR>"] = cmp.mapping(function(fallback)
            cmp.abort()
            fallback()
          end, { "i" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "path" },
          { name = "buffer" },
        }),
        -- sorting = {
        --   comparators = {
        --     require("clangd_extensions.cmp_scores"),
        --   },
        -- },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        formatting = {
          format = function(entry, item)
            local icons = {
              Array = " ",
              Boolean = "󰨙 ",
              Class = " ",
              Codeium = "󰘦 ",
              Color = " ",
              Control = " ",
              Collapsed = " ",
              Constant = "󰏿 ",
              Constructor = " ",
              Copilot = " ",
              Enum = " ",
              EnumMember = " ",
              Event = " ",
              Field = " ",
              File = " ",
              Folder = " ",
              Function = "󰊕 ",
              Interface = " ",
              Key = " ",
              Keyword = " ",
              Method = "󰊕 ",
              Module = " ",
              Namespace = "󰦮 ",
              Null = " ",
              Number = "󰎠 ",
              Object = " ",
              Operator = " ",
              Package = " ",
              Property = " ",
              Reference = " ",
              Snippet = " ",
              String = " ",
              Struct = "󰆼 ",
              TabNine = "󰏚 ",
              Text = " ",
              TypeParameter = " ",
              Unit = " ",
              Value = " ",
              Variable = "󰀫 ",
            }
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end

            return item
          end,
        },
        -- experimental = {
        --   ghost_text = {
        --     hl_group = "CmpGhostText",
        --   },
        -- },
      }
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   dependencies = {
  --     {
  --       "L3MON4D3/LuaSnip",
  --       build = (vim.fn.executable("make") == 1) and "make install_jsregexp",
  --     },
  --     "hrsh7th/cmp-nvim-lsp",
  --     "saadparwaiz1/cmp_luasnip",
  --   },
  --   opts = function()
  --     -- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  --     local cmp = require("cmp")
  --     local luasnip = require("luasnip")
  --     return {
  --       -- completion = {
  --       --   completeopt = "menu,menuone,noinsert",
  --       -- },
  --       -- preselect = cmp.PreselectMode.Item or cmp.PreselectMode.None,
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --
  --         -- Intellij-like autocompletion
  --         -- <CR> to select the options
  --         -- ["<CR>"] = cmp.mapping(function(fallback)
  --         --   if cmp.visible() then
  --         --     if luasnip.expandable() then
  --         --       luasnip.expand()
  --         --     else
  --         --       cmp.confirm({
  --         --         select = true,
  --         --       })
  --         --     end
  --         --   else
  --         --     fallback()
  --         --   end
  --         -- end),
  --         -- -- Use <TAB> to cycle through auto-complete option
  --         -- ["<Tab>"] = cmp.mapping(function(fallback)
  --         --   if cmp.visible() then
  --         --     cmp.select_next_item()
  --         --   elseif luasnip.locally_jumpable(1) then
  --         --     luasnip.jump(1)
  --         --   else
  --         --     fallback()
  --         --   end
  --         -- end, { "i", "s" }),
  --         -- -- <Shift-TAB> to cycle backwards
  --         -- ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         --   if cmp.visible() then
  --         --     cmp.select_prev_item()
  --         --   elseif luasnip.locally_jumpable(-1) then
  --         --     luasnip.jump(-1)
  --         --   else
  --         --     fallback()
  --         --   end
  --         -- end, { "i", "s" }),
  --
  --         ["<C-Space>"] = cmp.mapping(function(fallback)
  --           cmp.close()
  --         end, { "i" }),
  --
  --         ["<C-CR>"] = cmp.mapping(function(fallback)
  --           cmp.abort()
  --           fallback()
  --         end, { "i" }),
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         -- { name = "luasnip" },
  --       }),
  --       -- sorting = {
  --       --   comparators = {
  --       --     require("clangd_extensions.cmp_scores"),
  --       --   },
  --       -- },
  --       -- snippet = {
  --       --   expand = function(args)
  --       --     require("luasnip").lsp_expand(args.body)
  --       --   end,
  --       -- },
  --       -- formatting = {
  --       --   format = function(entry, item)
  --       --     local icons = {
  --       --       Array = " ",
  --       --       Boolean = "󰨙 ",
  --       --       Class = " ",
  --       --       Codeium = "󰘦 ",
  --       --       Color = " ",
  --       --       Control = " ",
  --       --       Collapsed = " ",
  --       --       Constant = "󰏿 ",
  --       --       Constructor = " ",
  --       --       Copilot = " ",
  --       --       Enum = " ",
  --       --       EnumMember = " ",
  --       --       Event = " ",
  --       --       Field = " ",
  --       --       File = " ",
  --       --       Folder = " ",
  --       --       Function = "󰊕 ",
  --       --       Interface = " ",
  --       --       Key = " ",
  --       --       Keyword = " ",
  --       --       Method = "󰊕 ",
  --       --       Module = " ",
  --       --       Namespace = "󰦮 ",
  --       --       Null = " ",
  --       --       Number = "󰎠 ",
  --       --       Object = " ",
  --       --       Operator = " ",
  --       --       Package = " ",
  --       --       Property = " ",
  --       --       Reference = " ",
  --       --       Snippet = " ",
  --       --       String = " ",
  --       --       Struct = "󰆼 ",
  --       --       TabNine = "󰏚 ",
  --       --       Text = " ",
  --       --       TypeParameter = " ",
  --       --       Unit = " ",
  --       --       Value = " ",
  --       --       Variable = "󰀫 ",
  --       --     }
  --       --     if icons[item.kind] then
  --       --       item.kind = icons[item.kind] .. item.kind
  --       --     end
  --       --     local widths = {
  --       --       abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
  --       --       menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
  --       --     }
  --       --
  --       --     for key, width in pairs(widths) do
  --       --       if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
  --       --         item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
  --       --       end
  --       --     end
  --       --
  --       --     return item
  --       --   end,
  --       -- },
  --       -- experimental = {
  --       --   ghost_text = {
  --       --     hl_group = "CmpGhostText",
  --       --   },
  --       -- },
  --     }
  --   end,
  -- },

  -- Auto-pairs
  -- {
  --   "echasnovski/mini.pairs",
  --   version = "*",
  --   event = "VeryLazy",
  --   opts = {
  --     modes = { insert = true, command = true, terminal = false },
  --     -- skip autopair when next character is one of these
  --     skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  --     -- skip autopair when the cursor is inside these treesitter nodes
  --     skip_ts = { "string" },
  --     -- skip autopair when next character is closing pair
  --     -- and there are more closing pairs than opening pairs
  --     skip_unbalanced = true,
  --     -- better deal with markdown code blocks
  --     markdown = true,
  --   },
  --   config = function(_, opts)
  --     require("mini.pairs").setup(opts)
  --   end,
  -- },

  -- formatting
  {
    "stevearc/conform.nvim",
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
        timeout_ms = 1000,
      },
    },
    init = function()
      require("conform").setup({
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end,
      })
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        -- NOTE: FormatDisable! will disable formatting just for this buffer
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}
