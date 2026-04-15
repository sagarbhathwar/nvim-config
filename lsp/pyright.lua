return {
  cmd = { "pyright-langserver", "--stdio" },
  root_markers = { "pyproject.toml", ".git" },
  filetypes = { "python" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
    pyright = {
      inlayHints = {
        variableTypes = true,
        functionReturnTypes = true,
        callArgumentNames = "partial",
        pytestParameters = true,
      },
    },
  },
}
