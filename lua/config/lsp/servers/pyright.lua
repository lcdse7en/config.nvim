local M = {}

M.settings = {
  cmd = { "delance-langserver", "--stdio"},
  python = {
    disableOrganizeImports = true,
    pythonPath = vim.fn.exepath "python3",
    analysis = {
      extraPaths = { vim.fn.getcwd() },
      ignore = { "*" },
      inlayHints = {
        callArgumentNames = "partial",
        functionReturnTypes = true,
        pytestParameters = true,
        variableTypes = true,
      },
    },
  },
}

return M
