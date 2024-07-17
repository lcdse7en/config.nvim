require("config.EcoVim")

require("utils.globals")
require("utils.functions")

require("config.options")
require("config.lazy")
require("config.keymappings")
require("config.autocmds")
require("config.lsp.config")
require("config.lsp.setup")
require("config.lsp.functions")

require("internal.winbar")
require("internal.cursorword")
require("internal.vmlens")


-- function ExecuteCurrentSQL()
--   vim.api.nvim_command('normal! vi:DB<CR>')
-- end
--
-- vim.api.nvim_exec(
-- 	[[
--   augroup DadbodAutoExecute
--     autocmd!
--     autocmd FileType mysql autocmd BufWritePost <buffer> lua ExecuteCurrentSQL()
--     augroup END
-- ]],
-- 	false
-- )
