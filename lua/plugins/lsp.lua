return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "codelldb",
        "pyright",
        "ruff-lsp",
        "debugpy",
        "black",
        "isort",
        "taplo",
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    keys = {
      { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
      { "gr", vim.lsp.buf.references, desc = "Goto References" },
      { "<leader>c", vim.lsp.buf.code_action, desc = "Code Action" },
    },
    opts = function()
      return {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = require("util").icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = require("util").icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = require("util").icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = require("util").icons.diagnostics.Info,
            },
          },
        },
        inlay_hints = {
          enabled = true,
        },
        codelens = {
          enabled = false,
        },
        document_highlight = {
          enabled = true,
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
      }
    end,
    config = function(_, opts) end,
    init = function()
      -- this snippet enables auto-completion
      local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
      lspCapabilities.textDocument.completion.completionItem.snippetSupport = true

      require("lspconfig").pyright.setup({
        capabilities = lspCapabilities,
      })

      -- require("lspconfig").ruff_lsp.setup({
      --   settings = {
      --     organizeImports = false,
      --   },
      --   on_attach = function(client)
      --     client.server_capabilities.hoverProvider = false
      --   end,
      -- })
    end,
  },
}
