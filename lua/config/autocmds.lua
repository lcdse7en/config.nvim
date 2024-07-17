-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})
-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	{ pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" }
)
-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	{ pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)
-- Show `` in specific files
vim.api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	{ pattern = { "*.txt", "*.md", "*.json" }, command = "setlocal conceallevel=0" }
)

-- Attach specific keybindings in which-key for specific filetypes
local present, _ = pcall(require, "which-key")
if not present then
	return
end
local _, pwk = pcall(require, "plugins.which-key")

-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*.md",
-- 	callback = function()
-- 		pwk.attach_markdown(0)
-- 	end,
-- })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.ts", "*.tsx" },
	callback = function()
		pwk.attach_typescript(0)
	end,
})
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "package.json" },
	callback = function()
		pwk.attach_npm(0)
	end,
})
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "*",
-- 	callback = function()
-- 		if EcoVim.plugins.zen.enabled and vim.bo.filetype ~= "alpha" then
-- 			pwk.attach_zen(0)
-- 		end
-- 	end,
-- })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*test.js", "*test.ts", "*test.tsx" },
	callback = function()
		pwk.attach_jest(0)
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "spectre_panel",
	callback = function()
		pwk.attach_spectre(0)
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "NvimTree",
	callback = function()
		pwk.attach_nvim_tree(0)
	end,
})

--  NOTE: go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Jump to the last place you’ve visited in a file before exiting",
	callback = function()
		local ignore_ft = { "neo-tree", "toggleterm", "lazy" }
		local ft = vim.bo.filetype
		if not vim.tbl_contains(ignore_ft, ft) then
			local mark = vim.api.nvim_buf_get_mark(0, '"')
			local lcount = vim.api.nvim_buf_line_count(0)
			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end
	end,
})

--  NOTE: Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	command = [[:%s/\s\+$//e]],
	group = TrimWhiteSpaceGrp,
})

--  NOTE: auto close NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
			and layout[3] == nil
		then
			vim.api.nvim_command([[confirm quit]])
		end
	end,
})

--  NOTE: Automaically reload the file if it is changed outsize of Nvim
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
	pattern = "*",
	group = vim.api.nvim_create_augroup("auto_read", { clear = true }),
	callback = function()
		vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "nvim-config" })
	end,
})
vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold", "TermClose", "TermLeave" }, {
	pattern = "*",
	group = vim.api.nvim_create_augroup("auto_read", { clear = true }),
	callback = function()
		if vim.fn.getcmdwintype() == "" then
			vim.cmd("checktime")
		end
	end,
})
--  NOTE:  Don't auto commenting new lines
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "Do not auto comment on new line",
})

--  NOTE: Jump out of parenthetical quotation marks
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	callback = function()
		vim.cmd([[
    inoremap <silent> ii <C-\><C-n>:call search('[>)\]}"'']', 'W')<CR>a
     ]])
	end,
})

--  NOTE: show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = "*",
	command = "set cursorline",
	group = vim.api.nvim_create_augroup("CursorLine", { clear = true }),
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	pattern = "*",
	command = "set nocursorline",
	group = vim.api.nvim_create_augroup("noCursorLine", { clear = true }),
})

--  NOTE: auto close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"fugitive",
		"tsplayground",
		"PlenaryTestPopup",
		"qf",
		"toggleterm",
		"help",
		"lspinfo",
		"man",
		"notify",
		"aerial",
		"oil",
		"qf",
		"dbout", -- vim-dadbod-ui output
		"query", -- :InspectTree
		"dap-float",
		"NvimTree",
		"dap-float",
		"null-ls-info",
		"checkhealth",
		"spectre_panel",
		"startuptime",
		"neotest-output",
		"neotest-summary",
		"neotest-output-panel",
		"terminal",
		"copilot",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", ":q<cr>", { buffer = event.buf, silent = true })
	end,
})
vim.api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

--  NOTE: markdown vim-table-mode
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("vimtablemode", { clear = true }),
	pattern = { "*.md" },
	command = "silent! TableModeEnable",
})

--  NOTE: Set scripts to be executable from the shell
vim.cmd([[ au BufWritePost * if getline(1) =~ "^#!" | silent !chmod +x <afile> | endif ]])

--  NOTE: Open new file insert text
vim.cmd([[
    augroup title_sh
        autocmd!
        autocmd BufNewFile *.sh exec":call SetTitle_sh()"
          func SetTitle_sh()
            if expand("%:e") == "sh"
              call setline(1, "#!/usr/bin/bash")
              call setline(2, "")
              call setline(3, "#********************************************")
              call setline(4, "# Author      : lcdse7en                    *")
              call setline(5, "# E-mail      : 2353442022@qq.com           *")
              call setline(6, "# Create_Time : ".strftime("%Y-%m-%d %H:%M:%S")."         *")
              call setline(7, "# Description :                             *")
              call setline(8, "#********************************************")
              call setline(9, "")
              call setline(10, "# source /etc/profile.d/import_shell_libs.sh")
              call setline(11, "")
              call setline(12, "")
              call setline(13, "RED=$(printf '\\033[31m')")
              call setline(14, "GREEN=$(printf '\\033[32m')")
              call setline(15, "YELLOW=$(printf '\\033[33m')")
              call setline(16, "BLUE=$(printf '\\033[34m')")
              call setline(17, "SKYBLUE=$(printf '\\033[36m')")
              call setline(18, "BOLD=$(printf '\\033[1m')")
              call setline(19, "RESET=$(printf '\\033[m')")
              call setline(20, "")
              call setline(21, "")
              call setline(22, "main() {")
              call setline(23, "    pass")
              call setline(24, "}")
              call setline(25, "")
              call setline(26, "main")
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]])
vim.cmd([[
    augroup title_lua
        autocmd!
        autocmd BufNewFile *.lua exec":call SetTitle_lua()"
          func SetTitle_lua()
            if expand("%:e") == "lua"
              call setline(1, "--********************************************")
              call setline(2, "-- Author      : lcdse7en                    *")
              call setline(3, "-- E-mail      : 2353442022@qq.com           *")
              call setline(4, "-- Create_Time : ".strftime("%Y-%m-%d %H:%M:%S")."         *")
              call setline(5, "-- Description :                             *")
              call setline(6, "--********************************************")
              call setline(7, "")
              call setline(8, "")
              normal G
              normal o
              normal o
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]])
vim.cmd([[
    augroup title_py
        autocmd!
        autocmd BufNewFile *.py exec":call SetTitle_py()"
          func SetTitle_py()
            if expand("%:e") == "py"
              call setline(1, "\# -*- coding: utf-8 -*-")
              call setline(2, "")
              call setline(3, "#********************************************")
              call setline(4, "# Author       : lcdse7en                   *")
              call setline(5, "# E-mail       : 2353442022@qq.com          *")
              call setline(6, "# Create_Time  : ".strftime("%Y-%m-%d %H:%M:%S")."        *")
              call setline(7, "# Description  :                            *")
              call setline(8, "#********************************************")
              call setline(9, "")
              call setline(10, "")
              call setline(11, "# import requests")
              call setline(12, "# from fake_useragent import UserAgent #  NOTE: ua = UserAgent(), headers = {'User-Agent': ua.random}")
              call setline(13, "# from loguru import logger")
              call setline(14, "# from tqdm.rich import tqdm")
              normal G
              normal o
              normal o
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]])
vim.cmd([[
    augroup title_yaml
        autocmd!
        autocmd BufNewFile *.yaml,*.yml exec":call SetTitle_yaml()"
          func SetTitle_yaml()
            if expand("%:e") == "yaml"
              call setline(1, "#********************************************")
              call setline(2, "# Author      : lcdse7en                     ")
              call setline(3, "# E-mail      : 2353442022@qq.com            ")
              call setline(4, "# Create_Time : ".strftime("%Y-%m-%d %H:%M")."             ")
              call setline(5, "# Description :                              ")
              call setline(6, "#********************************************")
              call setline(7, "")
              call setline(8, "")
            endif
            if expand("%:e") == "yml"
              call setline(1, "#********************************************")
              call setline(2, "# Author      : lcdse7en                     ")
              call setline(3, "# E-mail      : 2353442022@qq.com            ")
              call setline(4, "# Create_Time : ".strftime("%Y-%m-%d %H:%M")."             ")
              call setline(5, "# Description :                              ")
              call setline(6, "#********************************************")
              call setline(7, "")
              call setline(8, "")
            endif
          endfunc
        autocmd BufNewFile * normal G
    augroup end
]])

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("typst", { clear = true }),
	pattern = {
		"*.typ",
	},
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
		vim.bo.autoindent = true
		vim.bo.cindent = true
		vim.bo.expandtab = true
		vim.bo.smartindent = true
		vim.bo.copyindent = true
		vim.opt.colorcolumn = "120"
		vim.wo.wrap = true
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("sh", { clear = true }),
	pattern = {
		"sh",
	},
	callback = function()
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
		vim.bo.autoindent = true
		vim.bo.cindent = true
		vim.bo.expandtab = false
		vim.bo.smartindent = true
		vim.opt.colorcolumn = "100"
		vim.opt.wrap = false
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("python", { clear = true }),
	pattern = {
		"python",
	},
	callback = function()
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
		vim.bo.autoindent = true
		vim.bo.cindent = true
		vim.bo.expandtab = true
		vim.bo.smartindent = true
		vim.bo.copyindent = true
		vim.opt.colorcolumn = "100"
		vim.opt.wrap = false
	end,
})

local function execute_sql()
	if vim.bo.filetype == "sql" then
		vim.cmd("DBUIExecuteQuery")
	end
end
vim.api.nvim_create_augroup("DadbodExecuteOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*sql",
	group = "DadbodExecuteOnSave",
	callback = execute_sql,
})
