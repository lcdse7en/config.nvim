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

vim.api.nvim_set_keymap("i", "<C-l>", "v:lua.jump_out_bracket()", { expr = true, noremap = true, silent = true })
_G.jump_out_bracket = function()
	local col = vim.fn.col(".")
	local line = vim.fn.getline(".")
	local char = line:sub(col, col)
	if char:match('[%)%]%}"\'"]') then
		return vim.api.nvim_replace_termcodes("<Right>", true, true, true)
	else
		return vim.api.nvim_replace_termcodes("<C-l>", true, true, true)
	end
end

vim.api.nvim_exec([[
  autocmd BufNewFile,BufRead queries set filetype=mysql
]],false)

vim.api.nvim_exec(
	[[
  augroup DadbodAutoExecute
    autocmd!
    autocmd FileType mysql autocmd BufWritePost * echo "Executing :%DB" | execute 'normal :%DB<CR>'
    augroup END
]],
	false
)
