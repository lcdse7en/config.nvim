local M = {}

M.settings = {
  Lua = {
    hint = {
      enable = true,
      arrIndex = "Enable",
      setType = true,
    },
    diagnostics = {
      globals = { 'vim', 'bit', 'packer_plugins', 'missing-fields', 'incomplete-signature-doc' }
    }
  }
}

return M
