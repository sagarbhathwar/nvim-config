return {
    cmd = {"pyright-langserver", "--stdio"},
    root_markers = {"pyproject.toml", ".git"},
    filetypes = {"python"},
    settings = {
        {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true
            }
          }
        }
    }
}
