-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})
-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd(
  { 'BufRead', 'BufNewFile' },
  { pattern = '*/node_modules/*', command = 'lua vim.diagnostic.disable(0)' }
)
-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd(
  { 'BufRead', 'BufNewFile' },
  { pattern = { '*.txt', '*.md', '*.tex' }, command = 'setlocal spell' }
)
-- Show `` in specific files
vim.api.nvim_create_autocmd(
  { 'BufRead', 'BufNewFile' },
  { pattern = { '*.txt', '*.md', '*.json' }, command = 'setlocal conceallevel=0' }
)

-- Attach specific keybindings in which-key for specific filetypes
local present, _ = pcall(require, 'which-key')
if not present then
  return
end
local _, pwk = pcall(require, 'plugins.which-key')

-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*.md",
-- 	callback = function()
-- 		pwk.attach_markdown(0)
-- 	end,
-- })
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.ts', '*.tsx' },
  callback = function()
    pwk.attach_typescript(0)
  end,
})
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { 'package.json' },
  callback = function()
    pwk.attach_npm(0)
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*test.js', '*test.ts', '*test.tsx' },
  callback = function()
    pwk.attach_jest(0)
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'spectre_panel',
  callback = function()
    pwk.attach_spectre(0)
  end,
})

--  NOTE: go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Jump to the last place you’ve visited in a file before exiting',
  callback = function()
    local ignore_ft = { 'neo-tree', 'toggleterm', 'lazy' }
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
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup('TrimWhiteSpaceGrp', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})

--  NOTE: auto close NvimTree
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('NvimTreeClose', { clear = true }),
  pattern = 'NvimTree_*',
  callback = function()
    local layout = vim.api.nvim_call_function('winlayout', {})
    if
      layout[1] == 'leaf'
      and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), 'filetype') == 'NvimTree'
      and layout[3] == nil
    then
      vim.api.nvim_command [[confirm quit]]
    end
  end,
})

--  NOTE: Automaically reload the file if it is changed outsize of Nvim
vim.api.nvim_create_autocmd({ 'FileChangedShellPost' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('auto_read', { clear = true }),
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded!', vim.log.levels.WARN, { title = 'nvim-config' })
  end,
})
vim.api.nvim_create_autocmd({ 'FocusGained', 'CursorHold', 'TermClose', 'TermLeave' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('auto_read', { clear = true }),
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd 'checktime'
    end
  end,
})
--  NOTE:  Don't auto commenting new lines
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
  desc = 'Do not auto comment on new line',
})

--  NOTE: Jump out of parenthetical quotation marks
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd([[
--     inoremap <silent> ii <C-\><C-n>:call search('[>)\]}"'']', 'W')<CR>a
--      ]])
-- 	end,
-- })

--  NOTE: show cursor line only in active window
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline',
  group = vim.api.nvim_create_augroup('CursorLine', { clear = true }),
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  pattern = '*',
  command = 'set nocursorline',
  group = vim.api.nvim_create_augroup('noCursorLine', { clear = true }),
})

--  NOTE: auto close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  pattern = {
    'fugitive',
    'tsplayground',
    'PlenaryTestPopup',
    'qf',
    'toggleterm',
    'help',
    'lspinfo',
    'man',
    'notify',
    'aerial',
    'oil',
    'qf',
    'dbout', -- vim-dadbod-ui output
    'query', -- :InspectTree
    'dap-float',
    'NvimTree',
    'dap-float',
    'null-ls-info',
    'checkhealth',
    'spectre_panel',
    'startuptime',
    'neotest-output',
    'neotest-summary',
    'neotest-output-panel',
    'terminal',
    'copilot',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', ':q<cr>', { buffer = event.buf, silent = true })
  end,
})
vim.api.nvim_create_autocmd('FileType', { pattern = 'man', command = [[nnoremap <buffer><silent> q :quit<CR>]] })

--  NOTE: markdown vim-table-mode
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('vimtablemode', { clear = true }),
  pattern = { '*.md' },
  command = 'silent! TableModeEnable',
})

--  NOTE: Set scripts to be executable from the shell
vim.cmd [[ au BufWritePost * if getline(1) =~ "^#!" | silent !chmod +x <afile> | endif ]]

--  NOTE: shell
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('sh', { clear = true }),
  pattern = {
    'sh',
  },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.opt.colorcolumn = '100'
    vim.opt.wrap = false
  end,
})
--  NOTE: python
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('python', { clear = true }),
  pattern = {
    'python',
  },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.copyindent = true
    vim.opt.colorcolumn = '100'
    vim.opt.wrap = false
  end,
})
--  NOTE: typst
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('typst', { clear = true }),
  pattern = {
    '*.typ',
  },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.copyindent = true
    vim.opt.colorcolumn = '120'
    vim.wo.wrap = true
  end,
})

--  NOTE: Open new file insert text
vim.cmd [[
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
]]
vim.cmd [[
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
]]
vim.cmd [[
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
]]
vim.cmd [[
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
]]

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('typst', { clear = true }),
  pattern = {
    '*.typ',
  },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.copyindent = true
    vim.opt.colorcolumn = '120'
    vim.wo.wrap = true
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('sh', { clear = true }),
  pattern = {
    'sh',
  },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.opt.colorcolumn = '100'
    vim.opt.wrap = false
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('python', { clear = true }),
  pattern = {
    'python',
  },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.autoindent = true
    vim.bo.cindent = true
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.copyindent = true
    vim.opt.colorcolumn = '100'
    vim.opt.wrap = false
  end,
})

-- ╭─────────────────────────────────────────────────────────╮
-- │ Jump out                                                │
-- ╰─────────────────────────────────────────────────────────╯
_G.jump_out_bracket = function()
  local col = vim.fn.col '.'
  local line = vim.fn.getline '.'
  local char = line:sub(col, col)
  if char:match '[%)%]%}"\'"]' then
    return vim.api.nvim_replace_termcodes('<Right>', true, true, true)
  else
    return vim.api.nvim_replace_termcodes('<C-l>', true, true, true)
  end
end
vim.api.nvim_set_keymap('i', '<C-l>', 'v:lua.jump_out_bracket()', { expr = true, noremap = true, silent = true })

-- ╭─────────────────────────────────────────────────────────╮
-- │ Transparent                                             │
-- ╰─────────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd 'hi! Normal guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NormalNC guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! Nontext guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! LineNr guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! StatusLine guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! StatusLineNC guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! SignColumn guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NormalFloat guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NormalNC guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! MsgSeparator guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! ErrorMsg guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! CmpDocumentation guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! VertSplit guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! FloatBorder guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! WinBar guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! MsgArea guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! Directory guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! LirFloatNormal guibg=NONE ctermbg=NONE'

    -- ╭─────────────────────────────────────────────────────────╮
    -- │ NvimTree                                                │
    -- ╰─────────────────────────────────────────────────────────╯
    vim.cmd 'hi! NvimTreeNormal guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NvimTreeWinSeparator guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE'

    -- ╭─────────────────────────────────────────────────────────╮
    -- │ Telescope                                               │
    -- ╰─────────────────────────────────────────────────────────╯
    vim.cmd 'hi! TelescopeBorder guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! TelescopePreviewNormal guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! TelescopePromptNormal guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! TelescopePromptTitle guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! TelescopePromptBorder guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! TelescopeResultsNormal guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! WhichKeyFloat guibg=NONE ctermbg=NONE'

    -- ╭─────────────────────────────────────────────────────────╮
    -- │ Notify                                                  │
    -- ╰─────────────────────────────────────────────────────────╯
    vim.cmd 'hi! NotifyINFOBody guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NotifyINFOBorder guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NotifyWARNBody guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NotifyWARNBorder guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NotifyERRORBody guibg=NONE ctermbg=NONE'
    vim.cmd 'hi! NotifyERRORBorder guibg=NONE ctermbg=NONE'

  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    -- skip if a pop up window
    if vim.fn.win_gettype() == 'popup' then
      return
    end

    -- skip if new buffer
    if vim.bo.filetype == '' then
      return
    end

    vim.wo.winbar = "%{%v:lua.require'utils.nvim.winbar'.eval()%}"
  end,
  group = vim.api.nvim_create_augroup('WinBar', {}),
})

---Following fixes the border issue in terminals
---@see https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})

vim.api.nvim_create_autocmd('UILeave', {
  callback = function()
    io.write '\027]111\027\\'
  end,
})

-- Disable built-in spellchecking for markdown
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'txt', 'gitcommit', 'typst', 'markdown' },
  callback = function()
    vim.opt_local.spell = false
    -- vim.wo.spell = false
  end,
})

vim.api.nvim_create_autocmd({"BufNewFile","BufRead"},{
  pattern = "*.typ",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, "filetype", "typst")
  end
})
