local lsp = "pyright"
local ruff = "ruff_lsp"

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
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
    config = function(_, opts)
      require("mason").setup()
      require("mason-tool-installer").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    keys = {
      { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
      { "gr", vim.lsp.buf.references, desc = "Goto References" },
      { "<leader>c", vim.lsp.buf.code_action, desc = "Code Action" },
    },
    opts = {
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
      servers = {
        lua_ls = {
          -- keys = {},
          settings = {
            Lua = {
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
        pyright = {
          enabled = true,
        },
        ruff_lsp = {
          enabled = true,
        },
      },
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
        [ruff] = function()
          require("util").on_attach(function(client, _)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end, ruff)
        end,
      },
    },
    config = function(_, opts)
      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      -- Manual setup for servers which can't be installed with mason
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            end
          end
        end
      end

      local plugin = require("lazy.core.config").spec.plugins["mason-lspconfig.nvim"]
      mlsp.setup({
        ensure_installed = require("lazy.core.plugin").values(plugin, "opts", false).ensure_installed or {},
        handlers = { setup },
      })

      -- local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
      -- lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
      --
      -- local lspconfig = require("lspconfig")
      --
      -- lspconfig.pyright.setup({
      --   capabilities = lspCapabilities,
      -- })
      --
      -- lspconfig.lua_ls.setup({})
    end,
  },
}
