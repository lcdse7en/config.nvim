local M = {}

M.settings = {
  filetypes = { "cpp", "c" },
  cmd = {
    "clangd",
    "--clangd-tidy",
    "--completion-style=detailed",
    "--header-insertion=never",
    "--offset-encoding=utf-16",
  },
}

return M
