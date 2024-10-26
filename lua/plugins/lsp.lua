return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        config = function() end,
      },
    },
    event = "LazyFile",
    keys = {
      { "gd",         vim.lsp.buf.definition,      desc = "Goto Definition" },
      { "gr",         vim.lsp.buf.references,      desc = "Goto References" },
      { "gy",         vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
      { "gD",         vim.lsp.buf.declaration,     desc = "Goto Declaration" },
      { "K",          vim.lsp.buf.hover,           desc = "Hover" },
      { "gK",         vim.lsp.buf.signature_help,  desc = "Signature Help", },
      { "<c-k>",      vim.lsp.buf.signature_help,  mode = "i",                     desc = "Signature Help" },
      { "<leader>ca", vim.lsp.buf.code_action,     desc = "Code Action",           mode = { "n", "v" } },
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "basedpyright",
        "ruff",
      },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
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
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        basedpyright = {
          enabled = true,
          settings = {
            basedpyright = {
              analysis = {
                autoImportCompletions = true,
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff = {
          enabled = true,
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
        clangd = {
          keys = {
            { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        }
      },
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = {
            inlay_hints = {
              inline = true,
            },
            ast = {
              role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
              },
              kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
              },
            },
          }
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      }
    },
    config = function(_, opts)
      -- Setup diagnostics
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- Setup lsp navigation using telescope, if telescope is available
      local has_telescope, builtin = pcall(require, "telescope.builtin")
      if has_telescope then
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Goto Definition" })
        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "References" })
        vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "Goto Implementation" })
        vim.keymap.set("n", "gY", builtin.lsp_type_definitions, { desc = "Goto Type Definition" })
      end

      -- Improve lsp capabilities
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities
      )

      -- Setup handler for mason-lspconfig
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, opts.servers[server] or {})


        -- For default and manual setup
        -- If the manual setup returns true, no need to call lspconfig setup
        if opts.setup[server] and opts.setup[server](server, server_opts) then
          return
        elseif opts.setup["*"] and opts.setup["*"](server, server_opts) then
          return
        end

        require("lspconfig")[server].setup(server_opts)
      end

      -- Setup mason and mason-lspconfig
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
        handlers = { setup },
      })
    end,
  },
}
