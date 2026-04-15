return {
  cmd = { "lua-language-server" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  filetypes = { "lua" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      hint = {
        enable = true,
        setType = true,
        paramName = "All",
        paramType = true,
        arrayIndex = "Disable",
      },
      telemetry = { enable = false },
    },
  },
}
