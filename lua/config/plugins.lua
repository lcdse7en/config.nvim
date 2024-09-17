return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Themes                                                  │
  -- ╰─────────────────────────────────────────────────────────╯
  -- {
  -- 	"folke/tokyonight.nvim",
  -- 	lazy = false,
  -- 	priority = 1000,
  -- 	config = function()
  -- 		-- load the colorscheme here
  -- 		vim.cmd([[colorscheme tokyonight]])
  -- 		require("config.colorscheme")
  -- 	end,
  -- },
  {
    'LunarVim/darkplus.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup { default = true }
    end,
  },
  {
    'goolord/alpha-nvim',
    lazy = false,
    config = function()
      require 'plugins.alpha'
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Treesitter                                              │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPre',
    config = function()
      require 'plugins.treesitter'
    end,
    dependencies = {
      'hiphish/rainbow-delimiters.nvim',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Navigating (Telescope/Tree/Refactor)                    │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'nvim-pack/nvim-spectre',
    lazy = true,
    keys = {
      {
        '<Leader>pr',
        "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
        desc = 'refactor',
      },
      {
        '<Leader>pr',
        "<cmd>lua require('spectre').open_visual()<CR>",
        mode = 'v',
        desc = 'refactor',
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'cljoly/telescope-repo.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-live-grep-raw.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'MattesGroeger/vim-bookmarks' },
      { 'tom-anders/telescope-vim-bookmarks.nvim' },
      { 'nvim-telescope/telescope-smart-history.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'kkharji/sqlite.lua' },
    },
    config = function()
      require 'plugins.telescope'
    end,
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    init = function()
      require 'plugins.bqf-init'
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = {
      'NvimTreeOpen',
      'NvimTreeClose',
      'NvimTreeToggle',
      'NvimTreeFindFile',
      'NvimTreeFindFileToggle',
    },
    keys = {
      { '<F2>', "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = 'NvimTree' },
    },
    config = function()
      require 'plugins.tree'
    end,
  },
  {
    'gbprod/stay-in-place.nvim',
    lazy = false,
    config = true, -- run require("stay-in-place").setup()
  },
  {
    'chentoast/marks.nvim',
    event = 'BufEnter',
    config = true,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ LSP Base                                                │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    servers = nil,
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    cmd = 'Mason',
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' },
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ LSP Cmp                                                 │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      require 'plugins.cmp'
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-calc',
      'saadparwaiz1/cmp_luasnip',
      {
        'L3MON4D3/LuaSnip',
        dependencies = 'rafamadriz/friendly-snippets',
        build = 'make install_jsregexp',
      },
      {
        cond = EcoVim.plugins.ai.tabnine.enabled,
        'tzachar/cmp-tabnine',
        build = './install.sh',
      },
      {
        'David-Kunz/cmp-npm',
        config = function()
          require 'plugins.cmp-npm'
        end,
      },
      {
        'zbirenbaum/copilot-cmp',
        cond = EcoVim.plugins.ai.copilot.enabled,
        config = function()
          require('copilot_cmp').setup()
        end,
      },
      'petertriho/cmp-git',
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ LSP Addons                                              │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    dependencies = 'MunifTanjim/nui.nvim',
    config = function()
      require 'plugins.dressing'
    end,
  },
  { 'onsails/lspkind-nvim' },
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = function()
      require 'plugins.trouble'
    end,
  },
  { 'nvim-lua/popup.nvim' },
  {
    'SmiteshP/nvim-navic',
    config = function()
      require 'plugins.navic'
    end,
    dependencies = 'neovim/nvim-lspconfig',
  },
  {
    'pmizio/typescript-tools.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    ft = { 'typescript', 'typescriptreact' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require 'plugins.typescript-tools'
    end,
  },
  {
    'axelvc/template-string.nvim',
    event = 'InsertEnter',
    ft = {
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
    },
    config = true, -- run require("template-string").setup()
  },
  {
    'dmmulroy/tsc.nvim',
    cmd = { 'TSC' },
    config = true,
  },
  {
    'dnlhc/glance.nvim',
    config = function()
      require 'plugins.glance'
    end,
    cmd = { 'Glance' },
    keys = {
      { 'gd', '<cmd>Glance definitions<CR>', desc = 'LSP Definition' },
      { 'gr', '<cmd>Glance references<CR>', desc = 'LSP References' },
      { 'gm', '<cmd>Glance implementations<CR>', desc = 'LSP Implementations' },
      { 'gy', '<cmd>Glance type_definitions<CR>', desc = 'LSP Type Definitions' },
    },
  },
  {
    'antosha417/nvim-lsp-file-operations',
    event = 'LspAttach',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-tree.lua' },
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  -- {
  --   'ThePrimeagen/refactoring.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   cmd = 'Refactor',
  --   keys = {
  --     { '<leader>re', ':Refactor extract ', mode = 'x', desc = 'Extract function' },
  --     { '<leader>rf', ':Refactor extract_to_file ', mode = 'x', desc = 'Extract function to file' },
  --     { '<leader>rv', ':Refactor extract_var ', mode = 'x', desc = 'Extract variable' },
  --     { '<leader>ri', ':Refactor inline_var', mode = { 'x', 'n' }, desc = 'Inline variable' },
  --     { '<leader>rI', ':Refactor inline_func', mode = 'n', desc = 'Inline function' },
  --     { '<leader>rb', ':Refactor extract_block', mode = 'n', desc = 'Extract block' },
  --     { '<leader>rf', ':Refactor extract_block_to_file', mode = 'n', desc = 'Extract block to file' },
  --   },
  --   config = true,
  -- },

  {
    'nvim-pack/nvim-spectre', --  NOTE: <leader>R : confirm all
    lazy = true,
    keys = {
      {
        '<Leader>rf',
        "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
        mode = { 'n', 'v' },
        desc = '󰛔 Spectre search current file',
      },
      {
        '<Leader>ro',
        "<cmd>lua require('spectre').open()<CR>",
        mode = { 'n', 'v' },
        desc = '󰛔 Open Spectre',
      },
      {
        '<Leader>rw',
        "<cmd>lua require('spectre').open_visual({select_word})<CR>",
        mode = { 'v' },
        desc = '󰛔 Spectre search current word',
      },
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ General                                                 │
  -- ╰─────────────────────────────────────────────────────────╯
  -- {
  --   "mistricky/codesnap.nvim",
  --   build = "make",
  --   cmd = "CodeSnapPreviewOn",
  --   opts = {
  --     watermark = nil
  --   }
  -- },
  { 'AndrewRadev/switch.vim', lazy = false },
  {
    'Wansmer/treesj',
    lazy = true,
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
    keys = {
      { 'gJ', '<cmd>TSJToggle<CR>', desc = 'Toggle Split/Join' },
    },
    config = function()
      require('treesj').setup {
        use_default_keymaps = false,
      }
    end,
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require 'plugins.comment'
    end,
  },
  {
    'LudoPinelli/comment-box.nvim',
    lazy = false,
    keys = {
      { '<leader>ac', "<cmd>lua require('comment-box').llbox()<CR>", desc = 'comment box' },
      { '<leader>ac', "<cmd>lua require('comment-box').llbox()<CR>", mode = 'v', desc = 'comment box' },
    },
  },
  {
    'akinsho/nvim-toggleterm.lua',
    lazy = false,
    branch = 'main',
    config = function()
      require 'plugins.toggleterm'
    end,
    keys = {
      { '<Leader>at', '<cmd>ToggleTerm direction=float<CR>', desc = 'terminal float' },
    },
  },
  { 'tpope/vim-repeat', lazy = false },
  { 'tpope/vim-speeddating', lazy = false },
  { 'dhruvasagar/vim-table-mode', ft = { 'markdown' } },
  {
    'smoka7/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'smoka7/hydra.nvim',
    },
    opts = {
      hint_config = {
        border = EcoVim.ui.float.border or 'rounded',
        position = 'bottom',
        show_name = false,
      },
    },
    cmd = {
      'MCstart',
      'MCvisual',
      'MCclear',
      'MCpattern',
      'MCvisualPattern',
      'MCunderCursor',
    },
    keys = {
      {
        mode = { 'v', 'n' },
        '<LEADER>e',
        '<CMD>MCstart<CR>',
        desc = 'multicursor',
      },
      {
        mode = { 'v', 'n' },
        '<C-Down>',
        '<CMD>MCunderCursor<CR>',
        desc = 'multicursor down',
      },
    },
  },
  {
    'nacro90/numb.nvim',
    lazy = false,
    config = function()
      require 'plugins.numb'
    end,
  },
  {
    'folke/todo-comments.nvim',
    lazy = false,
    event = 'BufEnter',
    config = function()
      require 'plugins.todo-comments'
    end,
  },
  {
    'folke/zen-mode.nvim',
    cmd = { 'ZenMode' },
    config = function()
      require 'plugins.zen'
    end,
    cond = EcoVim.plugins.zen.enabled,
  },
  {
    'folke/twilight.nvim',
    config = true,
    cond = EcoVim.plugins.zen.enabled,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      char = {
        keys = { 'f', 'F', 't', 'T' },
      },
    },
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    lazy = true,
    config = function()
      require 'plugins.which-key'
    end,
  },
  {
    'ecosse3/galaxyline.nvim',
    config = function()
      require 'plugins.galaxyline'
    end,
    lazy = false,
    -- event = "VeryLazy",
  },
  {
    'echasnovski/mini.bufremove',
    version = '*',
    config = function()
      require('mini.bufremove').setup {
        silent = true,
      }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'echasnovski/mini.bufremove',
    },
    version = '*',
    keys = {
      { '<Space>1', '<cmd>BufferLineGoToBuffer 1<CR>' },
      { '<Space>2', '<cmd>BufferLineGoToBuffer 2<CR>' },
      { '<Space>3', '<cmd>BufferLineGoToBuffer 3<CR>' },
      { '<Space>4', '<cmd>BufferLineGoToBuffer 4<CR>' },
      { '<Space>5', '<cmd>BufferLineGoToBuffer 5<CR>' },
      -- { "<Space>6", "<cmd>BufferLineGoToBuffer 6<CR>" },
      -- { "<Space>7", "<cmd>BufferLineGoToBuffer 7<CR>" },
      -- { "<Space>8", "<cmd>BufferLineGoToBuffer 8<CR>" },
      -- { "<Space>9", "<cmd>BufferLineGoToBuffer 9<CR>" },
      { '<A-1>', '<cmd>BufferLineGoToBuffer 1<CR>' },
      { '<A-2>', '<cmd>BufferLineGoToBuffer 2<CR>' },
      { '<A-3>', '<cmd>BufferLineGoToBuffer 3<CR>' },
      { '<A-4>', '<cmd>BufferLineGoToBuffer 4<CR>' },
      { '<A-5>', '<cmd>BufferLineGoToBuffer 5<CR>' },
      { '<A-6>', '<cmd>BufferLineGoToBuffer 6<CR>' },
      { '<A-7>', '<cmd>BufferLineGoToBuffer 7<CR>' },
      { '<A-8>', '<cmd>BufferLineGoToBuffer 8<CR>' },
      { '<A-9>', '<cmd>BufferLineGoToBuffer 9<CR>' },
      { '<Leader>bb', '<cmd>BufferLineMovePrev<CR>', desc = 'Move back' },
      { '<Leader>bl', '<cmd>BufferLineCloseLeft<CR>', desc = 'Close Left' },
      { '<Leader>br', '<cmd>BufferLineCloseRight<CR>', desc = 'Close Right' },
      { '<Leader>bn', '<cmd>BufferLineMoveNext<CR>', desc = 'Move next' },
      { '<Leader>bp', '<cmd>BufferLinePick<CR>', desc = 'Pick Buffer' },
      { '<Leader>bP', '<cmd>BufferLineTogglePin<CR>', desc = 'Pin/Unpin Buffer' },
      { '<Leader>bsd', '<cmd>BufferLineSortByDirectory<CR>', desc = 'Sort by directory' },
      { '<Leader>bse', '<cmd>BufferLineSortByExtension<CR>', desc = 'Sort by extension' },
      { '<Leader>bsr', '<cmd>BufferLineSortByRelativeDirectory<CR>', desc = 'Sort by relative dir' },
    },
    config = function()
      require 'plugins.bufferline'
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        background_colour = '#000000',
      }
    end,
    init = function()
      local banned_messages = {
        'No information available',
        'LSP[tsserver] Inlay Hints request failed. Requires TypeScript 4.4+.',
        'LSP[tsserver] Inlay Hints request failed. File not opened in the editor.',
      }
      vim.notify = function(msg, ...)
        for _, banned in ipairs(banned_messages) do
          if msg == banned then
            return
          end
        end
        return require 'notify'(msg, ...)
      end
    end,
  },
  {
    'vuki656/package-info.nvim',
    event = 'BufEnter package.json',
    config = function()
      require 'plugins.package-info'
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.keymap.set('n', '<leader>mp', "<cmd>MarkdownPreview<CR>", { desc = 'MarkdownPreview' })
    end,
  },
  {
    'airblade/vim-rooter',
    event = 'VeryLazy',
    config = function()
      vim.g.rooter_patterns = EcoVim.plugins.rooter.patterns
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_resolve_links = 1
    end,
  },
  {
    'Shatur/neovim-session-manager',
    lazy = false,
    config = function()
      require 'plugins.session-manager'
    end,
    keys = {
      { '<Leader>ps', '<cmd>SessionManager available_commands<CR>', desc = 'session manager' },
      { '<Leader>pS', '<cmd>SessionManager save_current_session<CR>', desc = 'save session' },
    },
  },
  -- {
  --   'kylechui/nvim-surround',
  --   version = '*', -- Use for stability; omit to use `main` branch for the latest features
  --   event = 'VeryLazy',
  --   config = true,
  --   -- ╭─────────────────────────────────────────────────────────╮
  --   -- │ cs'" | ds" | ysiw                                       │
  --   -- ╰─────────────────────────────────────────────────────────╯
  -- },
  {
    'echasnovski/mini.surround',
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require('lazy.core.config').spec.plugins['mini.surround']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local mappings = {
        { opts.mappings.add, desc = 'Add surrounding', mode = { 'n', 'v' } },
        { opts.mappings.delete, desc = 'Delete surrounding' },
        { opts.mappings.find, desc = 'Find right surrounding' },
        { opts.mappings.find_left, desc = 'Find left surrounding' },
        { opts.mappings.highlight, desc = 'Highlight surrounding' },
        { opts.mappings.replace, desc = 'Replace surrounding' },
        { opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = 'ys', -- Add surrounding in Normal and Visual modes
        delete = 'ds', -- Delete surrounding
        replace = 'cs', -- Replace surrounding
      },
    },
    config = function(_, opts)
      require('mini.surround').setup(opts)
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    end,
  },
  {
    'echasnovski/mini.align',
    lazy = false,
    version = '*',
    config = function()
      require('mini.align').setup()
    end,
  },
  {
    'echasnovski/mini.ai',
    lazy = false,
    version = '*',
    config = function()
      require('mini.ai').setup()
    end,
  },
  {
    'rareitems/printer.nvim',
    event = 'BufEnter',
    ft = {
      'lua',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
    },
    config = function()
      require 'plugins.printer'
    end,
  },
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Indent                                                  │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    main = 'ibl',
    config = function()
      require 'plugins.indent'
    end,
  },
  {
    'folke/noice.nvim',
    cond = EcoVim.plugins.experimental_noice.enabled,
    lazy = false,
    keys = {
      {
        '<S-Enter>',
        function()
          require('noice').redirect(vim.fn.getcmdline())
        end,
        mode = 'c',
        desc = 'Redirect Cmdline',
      },
      {
        '<leader>nl',
        function()
          require('noice').cmd 'last'
        end,
        desc = 'Noice Last Message',
      },
      {
        '<leader>nh',
        function()
          require('noice').cmd 'history'
        end,
        desc = 'Noice History',
      },
      {
        '<leader>na',
        function()
          require('noice').cmd 'all'
        end,
        desc = 'Noice All',
      },
      {
        '<leader>nd',
        function()
          require('noice').cmd 'dismiss'
        end,
        desc = 'Dismiss All',
      },
      {
        '<A-f>',
        function()
          if not require('noice.lsp').scroll(4) then
            return '<c-f>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll forward',
        mode = { 'i', 'n', 's' },
      },
      {
        '<A-b>',
        function()
          if not require('noice.lsp').scroll(-4) then
            return '<c-b>'
          end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll backward',
        mode = { 'i', 'n', 's' },
      },
    },
    config = function()
      require 'plugins.noice'
    end,
  },
  {
    'chrisgrieser/nvim-spider',
    cond = EcoVim.plugins.jump_by_subwords.enabled,
    lazy = true,
    keys = { 'w', 'e', 'b', 'ge' },
    config = function()
      vim.keymap.set({ 'n', 'o', 'x' }, 'W', 'w', { desc = 'Normal w' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
      vim.keymap.set({ 'n', 'o', 'x' }, 'ge', "<cmd>lua require('spider').motion('ge')<CR>", { desc = 'Spider-ge' })
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Snippets & Language & Syntax                            │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'chrisgrieser/nvim-scissors',
    dependencies = 'nvim-telescope/telescope.nvim', -- optional
    opts = {
      snippetDir = vim.fn.stdpath 'config' .. '/snippets',
    },
    keys = {
      '<Leader>asa',
      '<Leader>ase',
    },
    config = function()
      local present, wk = pcall(require, 'which-key')
      if not present then
        return
      end

      wk.register({
        a = {
          s = {
            name = 'Snippets',
            a = { '<cmd>lua require("scissors").addNewSnippet()<CR>', 'Add new snippet' },
            e = { '<cmd>lua require("scissors").editSnippet()<CR>', 'Edit snippet' },
          },
        },
      }, {
        mode = 'n', -- NORMAL mode
        prefix = '<leader>',
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
      })

      wk.register({
        a = {
          s = {
            name = 'Snippets',
            a = { '<cmd>lua require("scissors").addNewSnippet()<CR>', 'Add new snippet from selection' },
          },
        },
      }, {
        mode = 'x', -- VISUAL mode
        prefix = '<leader>',
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require 'plugins.autopairs'
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    enabled = true,
    ft = {
      'nix',
      'vue',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'lua',
      'scc',
      'scss',
      'typst',
      'toml',
    },
    config = function()
      require 'plugins.colorizer'
    end,
  },
  {
    'js-everts/cmp-tailwind-colors',
    config = true,
  },
  {
    'razak17/tailwind-fold.nvim',
    opts = {
      min_chars = 50,
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact' },
  },
  {
    'MaximilianLloyd/tw-values.nvim',
    keys = {
      { '<Leader>cv', '<CMD>TWValues<CR>', desc = 'Tailwind CSS values' },
    },
    opts = {
      border = EcoVim.ui.float.border or 'rounded', -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
    },
  },
  {
    'laytan/tailwind-sorter.nvim',
    cmd = {
      'TailwindSort',
      'TailwindSortOnSaveToggle',
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    build = 'cd formatter && npm i && npm run build',
    config = true,
  },
  {
    'johmsalas/text-case.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    -- Author's Note: If default keymappings fail to register (possible config issue in my local setup),
    -- verify lazy loading functionality. On failure, disable lazy load and report issue
    -- lazy = false,
    config = function()
      require('textcase').setup {
        -- Set `default_keymappings_enabled` to false if you don't want automatic keymappings to be registered.
        default_keymappings_enabled = true,
        -- `prefix` is only considered if `default_keymappings_enabled` is true. It configures the prefix
        -- of the keymappings, e.g. `gau ` executes the `current_word` method with `to_upper_case`
        -- and `gaou` executes the `operator` method with `to_upper_case`.
        prefix = 'gu',
        -- If `substitude_command_name` is not nil, an additional command with the passed in name
        -- will be created that does the same thing as "Subs" does.
        substitude_command_name = nil,
        -- By default, all methods are enabled. If you set this option with some methods omitted,
        -- these methods will not be registered in the default keymappings. The methods will still
        -- be accessible when calling the exact lua function e.g.:
        -- "<CMD>lua require('textcase').current_word('to_snake_case')<CR>"
        enabled_methods = {
          'to_upper_case',
          'to_lower_case',
          'to_snake_case',
          'to_dash_case',
          'to_title_dash_case',
          'to_constant_case',
          'to_dot_case',
          'to_phrase_case',
          'to_camel_case',
          'to_pascal_case',
          'to_title_case',
          'to_path_case',
          'to_upper_phrase_case',
          'to_lower_phrase_case',
        },
      }
      require('telescope').load_extension 'textcase'
    end,
    cmd = { 'TextCaseOpenTelescope', 'Subs' },
    keys = { 'gu' },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ AI                                                      │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'jcdickinson/codeium.nvim',
    cond = EcoVim.plugins.ai.codeium.enabled,
    event = 'InsertEnter',
    cmd = 'Codeium',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = true,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cond = EcoVim.plugins.ai.copilot.enabled,
  --   lazy = false,
  --   config = function()
  --     require("plugins.copilot")
  --   end,
  -- },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    event = 'VeryLazy',
    opts = {
      show_help = 'no',
      prompts = {
        Explain = 'Explain how it works.',
        Review = 'Review the following code and provide concise suggestions.',
        Tests = 'Briefly explain how the selected code works, then generate unit tests.',
        Refactor = 'Refactor the code to improve clarity and readability.',
      },
    },
    build = function()
      vim.defer_fn(function()
        vim.cmd 'UpdateRemotePlugins'
        vim.notify 'CopilotChat - Updated remote plugins. Please restart Neovim.'
      end, 3000)
    end,
    keys = {
      { '<leader>ccb', ':CopilotChatBuffer<cr>', desc = 'CopilotChat - Buffer' },
      { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      {
        '<leader>ccT',
        '<cmd>CopilotChatVsplitToggle<cr>',
        desc = 'CopilotChat - Toggle Vsplit', -- Toggle vertical split
      },
      {
        '<leader>ccv',
        ':CopilotChatVisual',
        mode = 'x',
        desc = 'CopilotChat - Open in vertical split',
      },
      {
        '<leader>ccc',
        ':CopilotChatInPlace<cr>',
        mode = { 'n', 'x' },
        desc = 'CopilotChat - Run in-place code',
      },
      {
        '<leader>ccf',
        '<cmd>CopilotChatFixDiagnostic<cr>', -- Get a fix for the diagnostic message under the cursor.
        desc = 'CopilotChat - Fix diagnostic',
      },
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Git                                                     │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.git.signs'
    end,
    keys = {
      { '<Leader>ghd', desc = 'diff hunk' },
      { '<Leader>ghp', desc = 'preview' },
      { '<Leader>ghR', desc = 'reset buffer' },
      { '<Leader>ghr', desc = 'reset hunk' },
      { '<Leader>ghs', desc = 'stage hunk' },
      { '<Leader>ghS', desc = 'stage buffer' },
      { '<Leader>ght', desc = 'toggle deleted' },
      { '<Leader>ghu', desc = 'undo stage' },
    },
  },
  {
    'sindrets/diffview.nvim',
    lazy = true,
    enabled = true,
    event = 'BufRead',
    config = function()
      require 'plugins.git.diffview'
    end,
    keys = {
      { '<Leader>gd', "<cmd>lua require('plugins.git.diffview').toggle_file_history()<CR>", desc = 'diff file' },
      { '<Leader>gS', "<cmd>lua require('plugins.git.diffview').toggle_status()<CR>", desc = 'status' },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    lazy = false,
    config = function()
      require 'plugins.git.conflict'
    end,
    keys = {
      { '<Leader>gcb', '<cmd>GitConflictChooseBoth<CR>', desc = 'choose both' },
      { '<Leader>gcn', '<cmd>GitConflictNextConflict<CR>', desc = 'move to next conflict' },
      { '<Leader>gcc', '<cmd>GitConflictChooseOurs<CR>', desc = 'choose current' },
      { '<Leader>gcp', '<cmd>GitConflictPrevConflict<CR>', desc = 'move to prev conflict' },
      { '<Leader>gci', '<cmd>GitConflictChooseTheirs<CR>', desc = 'choose incoming' },
    },
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    lazy = false,
    config = function()
      require 'plugins.git.worktree'
    end,
    keys = {
      { '<Leader>gww', desc = 'worktrees' },
      { '<Leader>gwc', desc = 'create worktree' },
    },
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitCurrentFile',
      'LazyGitFilterCurrentFile',
      'LazyGitFilter',
    },
    keys = {
      { '<Leader>gg', '<cmd>LazyGit<CR>', desc = 'lazygit' },
    },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 0.9
    end,
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    cmd = {
      'Octo',
    },
    config = function()
      require 'plugins.git.octo'
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Testing                                                 │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'rcarriga/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'haydenmeade/neotest-jest',
    },
    config = function()
      require 'plugins.neotest'
    end,
  },
  {
    'andythigpen/nvim-coverage',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = {
      'Coverage',
      'CoverageSummary',
      'CoverageLoad',
      'CoverageShow',
      'CoverageHide',
      'CoverageToggle',
      'CoverageClear',
    },
    config = function()
      require('coverage').setup()
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ DAP                                                     │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'mfussenegger/nvim-dap',
    config = function()
      require 'plugins.dap'
    end,
    keys = {
      '<Leader>da',
      '<Leader>db',
      '<Leader>dc',
      '<Leader>dd',
      '<Leader>dh',
      '<Leader>di',
      '<Leader>do',
      '<Leader>dO',
      '<Leader>dt',
    },
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      'mxsdev/nvim-dap-vscode-js',
    },
  },
  {
    'LiadOz/nvim-dap-repl-highlights',
    config = true,
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter',
    },
    build = function()
      if not require('nvim-treesitter.parsers').has_parser 'dap_repl' then
        vim.cmd ':TSInstall dap_repl'
      end
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Format & Lint                                           │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'plugins.formatting'
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      require 'plugins.linting'
    end,
  },
  {
    'lalitmee/browse.nvim',
    enable = true,
    dependencies = 'nvim-telescope/telescope.nvim',
    cmd = {
      'BrowseBookmarks',
      'BrowseInputSearch',
    },
    config = function()
      require 'plugins.browse'
    end,
  },
  {
    'sustech-data/wildfire.nvim',
    enabled = true,
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('wildfire').setup()
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        lazy = true,
        init = function()
          vim.api.nvim_create_autocmd('FileType', {
            desc = 'dadbod completion',
            group = vim.api.nvim_create_augroup('dadbod_cmp', { clear = true }),
            pattern = { 'sql', 'mysql', 'plsql' },
            callback = function()
              require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
            end,
          })
        end,
      },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    keys = {
      { '<leader>D', '<cmd>DBUIToggle<CR>', desc = 'Toggle DBUI' },
    },
    init = function()
      local data_path = vim.fn.stdpath 'data'

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. '/dadbod_ui'
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. '/dadbod_ui/tmp'
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = false
      vim.g.db_ui_execute_on_save = true
      vim.g.db_ui_disable_progress_bar = false
      -- Your DBUI configuration
      vim.g.db = 'mysql://se7en:921216@127.0.0.1:3306/koreandrama'
      vim.g.db_ui_confirm_exec = 0
      vim.g.db_ui_use_postgres_views = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_win_position = 'left'

      vim.g.db_ui_hide_schemas = { 'pg_toast_temp.*' }

      vim.g.db_ui_winwidth = 40
      vim.g.db_ui_notification_width = 36
      vim.g.db_ui_default_query = 'select * from "{table}" limit 10'
    end,
  },
  {
    'stevearc/oil.nvim',
    enabled = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<cmd>Oil<CR>', desc = 'Open parent directory' },
      { '<space>-', "<CMD>lua require('oil').toggle_float()<CR>" },
    },
    opts = {
      columns = { 'icon' },
      keymap = {
        ['<C-h>'] = false,
        ['<M-h>'] = 'actions.select_split',
        ['.'] = 'actions.toggle_hidden',
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        show_hidden = true,
      },
      -- Configuration for the actions floating preview window
      preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
      },
    },
  },
  {
    'kevinhwang91/nvim-hlslens',
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
    config = function()
      require('scrollbar.handlers.search').setup {
        auto_enable = true,
        calm_down = true,
      }
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap(
        'n',
        'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        'n',
        'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '<leader>no', '<Cmd>noh<CR>', kopts)
    end,
  },
  {
    'mikavilpas/yazi.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = 'VeryLazy',
    keys = {
      -- 👇 in this section, choose your own keymappings!
      -- {
      --   '<leader>sy',
      --   function()
      --     require('yazi').yazi()
      --   end,
      --   desc = 'Open the yazi file manager',
      -- },
      {
        -- Open in the current working directory
        '<leader>fy',
        function()
          require('yazi').yazi(nil, vim.fn.getcwd())
        end,
        desc = 'Open yazi',
      },
    },
    opts = {
      open_for_directories = false,
    },
  },
  {
    'rmagatti/alternate-toggler', --  NOTE: false | true
    lazy = true,
    cmd = { 'ToggleAlternate' },
    keys = {
      {
        '<leader>aa',
        '<cmd>ToggleAlternate<cr>',
        mode = { 'n' },
        desc = 'Toggle Alternate False  True',
      },
    },
  },
  {
    'stevearc/overseer.nvim',
    keys = {
      {
        '<leader>ot',
        '<cmd>OverseerToggle<cr>',
        mode = { 'n' },
        desc = 'Toggle overseer task list',
      },
      {
        '<leader>or',
        '<cmd>OverseerRun<cr>',
        mode = { 'n' },
        desc = 'List overseer run template',
      },
    },
    config = function()
      local overseer = require 'overseer'
      overseer.setup {
        dap = false,
        templates = { 'make', 'cargo', 'shell', 'user.run_script', 'user.typst_compile' },
        task_list = {
          direction = 'left',
          bindings = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<C-h>'] = false,
            ['<C-j>'] = false,
            ['<C-k>'] = false,
            ['<C-l>'] = false,
          },
        },
      }
      -- custom behavior of make templates
      overseer.add_template_hook({
        module = '^make$',
      }, function(task_defn, util)
        util.add_component(task_defn, { 'on_output_quickfix', open_on_exit = 'failure' })
        util.add_component(task_defn, { 'on_complete_notify' })
        util.add_component(task_defn, { 'display_duration', detail_level = 1 })
      end)
    end,
  },
  -- {
  -- 	"mg979/vim-visual-multi",
  -- 	keys = {
  -- 		"<C-n>",
  -- 		"<C-Up>",
  -- 		"<C-Down>",
  -- 		"<S-Up>",
  -- 		"<S-Down>",
  -- 		"<S-Left>",
  -- 		"<S-Right>",
  -- 	},
  -- 	config = function()
  -- 		vim.g.VM_theme = "codedark"
  -- 	end,
  -- },
  {
    'winter-again/wezterm-config.nvim',
    config = function()
      require('wezterm_config').setup {
        append_wezterm_to_rtp = true,
      }
    end,
  },
  {
    'chrisgrieser/nvim-recorder',
    event = 'VeryLazy',
    dependencies = { 'rcarriga/nvim-notify' },
    keys = {
      -- these must match the keys in the mapping config below
      { 'q', desc = ' Start Recording' },
      { 'Q', desc = ' Play Recording' },
    },
    config = function()
      require('recorder').setup {
        slots = { 'a', 'b' },
        mapping = {
          startStopRecording = 'q',
          playMacro = 'Q',
          switchSlot = '<C-q>',
          editMacro = 'cq',
          yankMacro = 'yq',
          addBreakPoint = '##',
        },

        -- Clears all macros-slots on startup.
        clear = false,

        -- Log level used for any notification, mostly relevant for nvim-notify.
        -- (Note that by default, nvim-notify does not show the levels trace & debug.)
        logLevel = vim.log.levels.INFO,

        -- Use nerdfont icons in the status bar components and keymap descriptions
        useNerdfontIcons = true,

        performanceOpts = {
          countThreshold = 100,
          lazyredraw = true, -- enable lazyredraw (see `:h lazyredraw`)
          noSystemClipboard = true, -- remove `+`/`*` from clipboard option
          autocmdEventsIgnore = { -- temporarily ignore these autocmd events
            'TextChangedI',
            'TextChanged',
            'InsertLeave',
            'InsertEnter',
            'InsertCharPre',
          },
        },

        -- [experimental] partially share keymaps with nvim-dap.
        -- (See README for further explanations.)
        dapSharedKeymaps = false,
      }
    end,
  },
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    cmd = { 'CodeSnap', 'CodeSnapASCII' },
    keys = {
      { '<leader>cc', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
      { '<leader>cs', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = 'Save selected code snapshot in ~/Pictures' },
    },
    opts = {
      save_path = '~/Pictures',
      has_breadcrumbs = true,
      watermark = '',
      bg_x_padding = 122,
      bg_y_padding = 82,
      bg_padding = nil,
      -- bg_theme = "bamboo",
    },
  },
  {
    'HakonHarnes/img-clip.nvim',
    keys = {
      { '<leader>ip', '<cmd>PasteImage<cr>', desc = 'Paste clipboard image' },
    },
    opts = {},
  },
  {
    'rmagatti/alternate-toggler', --  NOTE: false | true
    lazy = true,
    cmd = { 'ToggleAlternate' },
    keys = {
      {
        '<leader>af',
        '<cmd>ToggleAlternate<cr>',
        mode = { 'n' },
        desc = 'Toggle Alternate False  True',
      },
    },
  },
}
