local keymap = vim.keymap.set
local silent = { silent = true }

table.unpack = table.unpack or unpack -- 5.1 compatibility

keymap('i', 'jj', '<ESC>', silent)
keymap('n', '<Leader>q', '<cmd>q<CR>', silent)

-- Fix moving forward in jumplist via <C-i>
keymap('n', '<C-I>', '<C-I>', silent)

-- Better window movement
keymap('n', '<C-h>', '<C-w>h', silent)
keymap('n', '<C-j>', '<C-w>j', silent)
keymap('n', '<C-k>', '<C-w>k', silent)
keymap('n', '<C-l>', '<C-w>l', silent)

-- H to move to the first non-blank character of the line
keymap('n', 'H', '^', silent)
keymap('n', 'L', '$', silent)

keymap('x', '<', '<gv', { desc = 'One indent left and reselect' })
keymap('x', '>', '>gv|', { desc = 'One indent right and reselect' })

-- Move selected line / block of text in visual mode
keymap('x', 'K', ":move '<-2<CR>gv-gv", silent)
keymap('x', 'J', ":move '>+1<CR>gv-gv", silent)

-- Keep visual mode indenting
keymap('v', '<', '<gv', silent)
keymap('v', '>', '>gv', silent)

-- Case change in visual mode
keymap('v', '`', 'u', silent)
keymap('v', '<A-`>', 'U', silent)

-- Save file by CTRL-S
keymap('n', 'W', ':w<CR>', silent)
keymap('i', '<C-s>', '<ESC> :w<CR>', silent)

-- Telescope
keymap('n', '<C-p>', "<CMD>lua require('plugins.telescope').project_files()<CR>")
keymap('n', '<S-p>', "<CMD>lua require('plugins.telescope.pickers.multi-rg')()<CR>")

-- Remove highlights
keymap('n', '<ESC>', ':noh<CR><CR>', silent)

-- Buffers
keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', silent)
keymap('n', 'gn', ':bn<CR>', silent)
keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', silent)
keymap('n', 'gp', ':bp<CR>', silent)
keymap('n', '<S-q>', ":lua require('mini.bufremove').delete(0, false)<CR>", silent)

-- keymap("n", "<Leader>fu", "<CMD>DBUIToggle<CR>", silent)

-- Don't yank on delete char
keymap('n', 'x', '"_x', silent)
keymap('n', 'X', '"_X', silent)
keymap('v', 'x', '"_x', silent)
keymap('v', 'X', '"_X', silent)

-- Don't yank on visual paste
keymap('v', 'p', '"_dP', silent)

-- Avoid issues because of remapping <c-a> and <c-x> below
vim.cmd [[
  nnoremap <Plug>SpeedDatingFallbackUp <c-a>
  nnoremap <Plug>SpeedDatingFallbackDown <c-x>
]]

-- Quickfix
keymap('n', '<Space>,', ':cp<CR>', silent)
keymap('n', '<Space>.', ':cn<CR>', silent)

-- Toggle quicklist
-- keymap("n", "<leader>q", "<cmd>lua require('utils').toggle_quicklist()<CR>", silent)

-- Manually invoke speeddating in case switch.vim didn't work
keymap('n', '<C-a>', ':if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif<CR>', silent)
keymap(
  'n',
  '<C-x>',
  ":if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif<CR>",
  silent
)

-- Open links under cursor in browser with gx
if vim.fn.has 'macunix' == 1 then
  keymap('n', 'gx', "<cmd>silent execute '!open ' . shellescape('<cWORD>')<CR>", silent)
else
  keymap('n', 'gx', "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<CR>", silent)
end

-- which-key
keymap('n', '<leader>/c', '<cmd>e $MYVIMRC<CR>', { silent = true, desc = 'open vimrc' })
keymap('n', '<leader>/u', '<cmd>Lazy update<CR>', { silent = true, desc = 'update plugins' })

keymap('n', '<leader>=', '<cmd>vertical resize +5<CR>', { silent = true, desc = 'resize +5' })
keymap('n', '<leader>-', '<cmd>vertical resize -5<CR>', { silent = true, desc = 'resize -5' })
keymap('n', '<leader>v', '<C-W>v', { silent = true, desc = 'split right' })
keymap('n', '<leader>V', '<C-W>s', { silent = true, desc = 'split below' })

-- ╭─────────────────────────────────────────────────────────╮
-- │ Edit file                                               │
-- ╰─────────────────────────────────────────────────────────╯
keymap(
  'n',
  '<leader>aaa',
  '<cmd>e ~/.config/nvim/lua/config/autocmds.lua<CR>',
  { silent = true, desc = 'edit autocmds.lua' }
)
keymap(
  'n',
  '<leader>aab',
  '<cmd>e ~/.config/nvim/lua/plugins/browse.lua<CR>',
  { silent = true, desc = 'edit browse.lua' }
)
keymap(
  'n',
  '<leader>aah',
  '<cmd>e ~/Clone/hyprdots/archlinux-scripts/edit_hosts.sh<CR>',
  { silent = true, desc = 'edit edit_hosts.sh' }
)
keymap(
  'n',
  '<leader>aak',
  '<cmd>e ~/.config/nvim/lua/config/keymappings.lua<CR>',
  { silent = true, desc = 'edit keymappings.lua' }
)
keymap(
  'n',
  '<leader>aao',
  '<cmd>e ~/.config/nvim/lua/config/options.lua<CR>',
  { silent = true, desc = 'edit options.lua' }
)
keymap(
  'n',
  '<leader>aap',
  '<cmd>e ~/.config/nvim/lua/config/plugins.lua<CR>',
  { silent = true, desc = 'edit plugins.lua' }
)
keymap(
  'n',
  '<leader>aaw',
  '<cmd>e ~/.config/nvim/lua/plugins/which-key.lua<CR>',
  { silent = true, desc = 'edit which-key.lua' }
)

-- ╭─────────────────────────────────────────────────────────╮
-- │ Edit lua snippet                                        │
-- ╰─────────────────────────────────────────────────────────╯
keymap(
  'n',
  '<leader>aal',
  '<cmd>e ~/.config/nvim/luasnip/lua.lua<CR>',
  { silent = true, desc = 'edit snippet lua.lua' }
)
keymap(
  'n',
  '<leader>aat',
  '<cmd>e ~/.config/nvim/luasnip/typst.lua<CR>',
  { silent = true, desc = 'edit snippet typst.lua' }
)

keymap('n', '<leader>an', '<cmd>set nonumber!<CR>', { silent = true, desc = 'line numbers' })
keymap('n', '<leader>ar', '<cmd>set norelativenumber!<CR>', { silent = true, desc = 'relative number' })
keymap(
  'n',
  '<leader>asa',
  '<cmd>lua require("scissors").addNewSnippet()<CR>',
  { silent = true, desc = 'Add new snippet(json)' }
)
keymap(
  'n',
  '<leader>ase',
  '<cmd>lua require("scissors").editSnippet()<CR>',
  { silent = true, desc = 'Edit snippet(json)' }
)

keymap(
  'n',
  '<leader>bc',
  '<cmd>lua require("utils").closeOtherBuffers()<CR>',
  { silent = true, desc = 'Close but current' }
)
keymap('n', '<leader>bf', '<cmd>bfirst<CR>', { silent = true, desc = 'First buffer' })

-- Find word/file across project
keymap(
  'n',
  '<Leader>pf',
  "<CMD>lua require('plugins.telescope').project_files({ default_text = vim.fn.expand('<cword>'), initial_mode = 'normal' })<CR>",
  { silent = true, desc = 'file' }
)
keymap(
  'n',
  '<Leader>pr',
  "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
  { silent = true, desc = 'spectre' }
)
keymap('v', '<Leader>pr', "<cmd>lua require('spectre').open_visual()<CR>", { silent = true, desc = 'spectre' })
keymap(
  'n',
  '<Leader>pw',
  "<CMD>lua require('telescope.builtin').grep_string({ initial_mode = 'normal' })<CR>",
  { silent = true, desc = 'word' }
)

keymap('n', '<leader>fb', '<cmd>silent BrowseBookmarks<CR>', { silent = true, desc = 'Browse bookmarks' })
keymap('n', '<leader>fc', '<cmd>Telescope colorscheme<CR>', { silent = true, desc = 'Color schemes' })
keymap(
  'n',
  '<leader>fd',
  '<cmd>lua require("plugins.telescope").edit_neovim()<CR>',
  { silent = true, desc = 'nvim dotfiles' }
)
keymap(
  'n',
  '<leader>fg',
  '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>',
  { silent = true, desc = 'Find text' }
)
keymap('n', '<leader>fh', '<cmd>Telescope oldfiles hidden=true<CR>', { silent = true, desc = 'File history' })
keymap(
  'n',
  '<leader>fH',
  '<cmd>lua require("plugins.telescope").command_history()<CR>',
  { silent = true, desc = 'Command history' }
)
keymap(
  'n',
  '<leader>fm',
  '<cmd>Telescope vim_bookmarks current_file<CR>',
  { silent = true, desc = 'Search bookmarks on current file' }
)
keymap('n', '<leader>fM', '<cmd>Telescope vim_bookmarks all<CR>', { silent = true, desc = 'Search all bookmarks' })
keymap(
  'n',
  '<leader>fs',
  '<cmd>Telescope search_history theme=dropdown<CR>',
  { silent = true, desc = 'search history' }
)
keymap('n', '<leader>fq', '<cmd>Telescope quickfix<CR>', { silent = true, desc = 'quickfix list' })

keymap('n', '<leader>ma', '<cmd>silent BookmarkAnnotate<CR>', { silent = true, desc = 'Marks Annotate' })
keymap('n', '<leader>mc', '<cmd>silent BookmarkClear<CR>', { silent = true, desc = 'Marks Clear' })
keymap('n', '<leader>mj', '<cmd>silent BookmarkNext<CR>', { silent = true, desc = 'Marks next' })
keymap('n', '<leader>mk', '<cmd>silent BookmarkNext<CR>', { silent = true, desc = 'Marks prev' })
keymap('n', '<leader>ms', '<cmd>silent BookmarkShowAll<CR>', { silent = true, desc = 'Marks showAll' })
keymap('n', '<leader>mt', '<cmd>silent BookmarkToggle<CR>', { silent = true, desc = 'Marks toggle' })
keymap('n', '<leader>mx', '<cmd>BookmarkClearAll<CR>', { silent = true, desc = 'Marks Clear All' })

-- ╭─────────────────────────────────────────────────────────╮
-- │ LSP Keymap                                              │
-- ╰─────────────────────────────────────────────────────────╯
keymap('n', '<C-Space>', '<cmd>lua vim.lsp.buf.code_action()<CR>', silent)
keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true, desc = 'Code action' })
keymap('v', '<leader>ca', "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>", { silent = true, desc = 'Code action' })
keymap('n', '<leader>cd', '<cmd>TroubleToggle<CR>', { silent = true, desc = 'local diagnostics' })
keymap(
  'n',
  '<leader>cD',
  '<cmd>Telescope diagnostics wrap_results=true<CR>',
  { silent = true, desc = 'workspace diagnostics' }
)
keymap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', { silent = true, desc = 'rename' })
keymap('n', '<leader>ct', '<cmd>LspToggleAutoFormat<CR>', { silent = true, desc = 'toggle format on save' })
keymap(
  'n',
  '<leader>cf',
  "<cmd>lua require('config.lsp.functions').format()<CR>",
  { silent = true, desc = 'Lsp Format' }
)
keymap('v', '<leader>cf', function()
  local start_row, _ = table.unpack(vim.api.nvim_buf_get_mark(0, '<'))
  local end_row, _ = table.unpack(vim.api.nvim_buf_get_mark(0, '>'))

  vim.lsp.buf.format {
    range = {
      ['start'] = { start_row, 0 },
      ['end'] = { end_row, 0 },
    },
    async = true,
  }
end, silent)
keymap(
  'n',
  '<leader>cl',
  "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>",
  { silent = true, desc = 'line diagnostics' }
)
keymap('n', 'gl', "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
-- keymap("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)
keymap('n', ']g', "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
keymap('n', '[g', "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
keymap('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)
