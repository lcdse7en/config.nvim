local conform = require 'conform'
local prettier = { { 'prettierd', 'prettier' } }
local util = require 'conform.util'

local opts = {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    typst = { 'typstyle' },
    sh = { 'shfmt' },
    toml = { 'taplo' },
    json = { 'jq' },
    jsonc = { 'prettierd' },
    html = prettier,
    css = prettier,
    scss = prettier,
    javascript = prettier,
    typescript = prettier,
    javascriptreact = prettier,
    typescriptreact = prettier,
    graphql = { { 'prettied', 'prettier' } },
    markdown = { { 'prettied', 'prettier' } },
    sql = { 'sql-formatter' },
    svelte = { { 'prettied', 'prettier' } },
    yaml = { 'prettier' },
    ['*'] = { 'trim_whitespace', 'squeeze_blanks', 'trim_newlines' },
  },
  formatters = {
    -- NOTE: lua
    stylua = {
      command = 'stylua',
      args = { '--search-parent-directories', '--stdin-filepath', '$FILENAME', '-' },
      range_args = function(ctx)
        local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
        return {
          '--search-parent-directories',
          '--stdin-filepath',
          '$FILENAME',
          '--range-start',
          tostring(start_offset),
          '--range-end',
          tostring(end_offset),
          '-',
        }
      end,
      cwd = util.root_file {
        '.stylua.toml',
        'stylua.toml',
      },
    },
    -- NOTE: shell
    shfmt = {
      command = 'shfmt',
      args = { '-i', '4', '-filename', '$FILENAME', '-ci', '-bn' },
    },
    rustfmt = {
      prepend_args = { '--edition', '2021' },
    },
    -- NOTE: C | C++
    clang_format = {
      command = 'clang-format',
      args = { '-assume-filename', '$FILENAME' },
      range_args = function(ctx)
        local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
        local length = end_offset - start_offset
        return {
          '-assume-filename',
          '$FILENAME',
          '--offset',
          tostring(start_offset),
          '--length',
          tostring(length),
        }
      end,
    },
    -- NOTE: yaml
    yamlfix = {
      command = 'yamlfix',
      -- Adds environment args to the yamlfix formatter
      env = {
        YAMLFIX_SEQUENCE_STYLE = 'block_style',
      },
    },
    --  NOTE: json
    jq = {
      command = 'jq',
    },
    --  NOTE: latex
    latexindent = {
      command = 'latexindent',
      args = { '-l', 'defaultSettings.yaml', '-y', 'lookForAlignDelims', '{bNiceMatrix: 1}' },
      -- stdin = true,
    },
    --  NOTE: typst
  },
}

conform.setup(opts)

vim.keymap.set({ 'n' }, '<leader>s', function()
  conform.format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  }
end, { desc = 'format file' })

vim.keymap.set({ 'v' }, '<leader>s', function()
  conform.format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  }
end, { desc = 'format selection' })

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end

  conform.format { async = true, lsp_fallback = true, range = range }
end, { range = true })
