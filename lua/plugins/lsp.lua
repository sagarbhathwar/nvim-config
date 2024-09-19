return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "clangd",
            "pyright",
            "ruff",
          },
        },
        config = function(_, opts)
          require("mason").setup()
          require("mason-lspconfig").setup(opts)
        end,
      },
    },
    event = "LazyFile",
    keys = {
      { "gd",        vim.lsp.buf.definition,  desc = "Goto Definition" },
      { "gr",        vim.lsp.buf.references,  desc = "Goto References" },
      { "<leader>c", vim.lsp.buf.code_action, desc = "Code Action" },
    },
    opts = {
      diagnostics = {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = require("util.ui").icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = require("util.ui").icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = require("util.ui").icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = require("util.ui").icons.diagnostics.Info,
          },
        },
      },
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = true,
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
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
      },
      servers = {
        lua_ls = {
          -- keys = {},
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        pyright = {
          enabled = true,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic"
              },
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
        ruff = {
          enabled = true,
        },
      },
    },
    config = function(_, opts)
      -- Setup lsp navigation using telescope, if telescope is available
      local has_telescope, builtin = pcall(require, "telescope.builtin")
      if has_telescope then
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Goto Definition" })
        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "References" })
        vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "Goto Implementation" })
        vim.keymap.set("n", "gY", builtin.lsp_type_definitions, { desc = "Goto Type Definition" })
      end

      -- Improve lsp capabilities
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities(),
        opts.capabilities
      )


      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, opts.servers[server] or {})

        require("lspconfig")[server].setup(server_opts)
      end

      require("mason-lspconfig").setup({
        handlers = { setup },
      })
    end,
  },
}
