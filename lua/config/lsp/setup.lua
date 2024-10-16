-- Setup installer & lsp configs
local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
local ufo_config_handler = require("plugins.nvim-ufo").handler
local mason_tool_installer = require("mason-tool-installer")

if not mason_ok or not mason_lsp_ok then
	return
end

mason.setup({
	ui = {
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = EcoVim.ui.float.border or "rounded",
	},
})

-- ╭─────────────────────────────────────────────────────────╮
-- │ LSP                                                     │
-- ╰─────────────────────────────────────────────────────────╯
mason_lsp.setup({
	-- A list of servers to automatically install if they're not already installed
	ensure_installed = {
		-- "bashls",
    -- 'html',
		-- "cssls",
		-- "eslint",
		-- "graphql",
		-- "jsonls",
		-- "lua_ls", -- sudo pacman -S lua-language-server
		"pyright",
    -- "clangd",
		-- "tinymist", -- typst LSP
		-- "prismals",
		-- "tailwindcss",
		-- "tsserver"
    -- 'rust_analyzer',
	},
	-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Servers are not automatically installed.
	--   - true: All servers set up via lspconfig are automatically installed.
	--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
	automatic_installation = true,
})

-- ╭─────────────────────────────────────────────────────────╮
-- │ Formatter                                               │
-- ╰─────────────────────────────────────────────────────────╯
mason_tool_installer.setup({
	ensure_installed = {
		"shfmt", -- shell formatter
		"taplo", -- toml formatter
		"black",
		"isort",
    -- "typstyle",
		-- "ruff",
		-- 'shellcheck',
		-- "prettier", -- prettier formatter
		-- "prettierd", -- prettierd formatter
		"clang-format", -- c | cpp formatter
		-- 'gofumpt',
		-- "goimports",
		"jq",
		-- "bibtex-tidy",
		-- "luacheck",
		-- 'stylua', -- lua formatter
		--  NOTE: Lint
	},
})

local lspconfig = require("lspconfig")

-- local handlers = {
--   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--     silent = true,
--     border = EcoVim.ui.float.border,
--   }),
--   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = EcoVim.ui.float.border }),
-- }

-- ╭────────────────────╮
-- │ TOGGLE INLAY HINTS │
-- ╰────────────────────╯
if vim.lsp.inlay_hint then
  vim.keymap.set('n', '<Space>ih', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = 'Toggle Inlay Hints' })
end

local border = {
  { '┌', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '┐', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '┘', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '└', 'FloatBorder' },
  { '│', 'FloatBorder' },
}
local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { silent = true, border = border }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local function on_attach(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- ╭─────────────╮
-- │ RUST SERVER │
-- ╰─────────────╯
-- lspconfig.rust_analyzer.setup({
--   handlers = handlers,
-- })

require("mason-lspconfig").setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
		})
	end,

  ["vtsls"] = function()
    require("lspconfig.configs").vtsls = require("vtsls").lspconfig

    lspconfig.vtsls.setup({
      capabilities = capabilities,
      handlers = require("config.lsp.servers.tsserver").handlers,
      on_attach =require("config.lsp.servers.tsserver").on_attach,
      settings = require("config.lsp.servers.tsserver").settings,
    })
  end,

	-- ["tsserver"] = function()
		-- Skip since we use typescript-tools.nvim
	-- end,

	["tailwindcss"] = function()
		lspconfig.tailwindcss.setup({
			capabilities = require("config.lsp.servers.tailwindcss").capabilities,
			filetypes = require("config.lsp.servers.tailwindcss").filetypes,
			handlers = handlers,
			init_options = require("config.lsp.servers.tailwindcss").init_options,
			on_attach = require("config.lsp.servers.tailwindcss").on_attach,
			settings = require("config.lsp.servers.tailwindcss").settings,
		})
	end,

	["cssls"] = function()
		lspconfig.cssls.setup({
			capabilities = capabilities,
			handlers = handlers,
			on_attach = require("config.lsp.servers.cssls").on_attach,
			settings = require("config.lsp.servers.cssls").settings,
		})
	end,

	["eslint"] = function()
		lspconfig.eslint.setup({
			capabilities = capabilities,
			handlers = handlers,
			on_attach = require("config.lsp.servers.eslint").on_attach,
			settings = require("config.lsp.servers.eslint").settings,
		})
	end,

	["jsonls"] = function()
		lspconfig.jsonls.setup({
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
			settings = require("config.lsp.servers.jsonls").settings,
		})
	end,

	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
			settings = require("config.lsp.servers.lua_ls").settings,
		})
	end,

	["pyright"] = function()
		lspconfig.pyright.setup({
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
			settings = require("config.lsp.servers.pyright").settings,
		})
	end,

	["clangd"] = function()
		lspconfig.clangd.setup({
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
			settings = require("config.lsp.servers.clangd").settings,
		})
	end,

	["tinymist"] = function()
		lspconfig.tinymist.setup({
			filetypes = require("config.lsp.servers.tinymist").filetypes,
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
      offset_encoding = "utf-8",
			settings = require("config.lsp.servers.tinymist").settings,
		})
	end,

	["vuels"] = function()
		lspconfig.vuels.setup({
			filetypes = require("config.lsp.servers.vuels").filetypes,
			handlers = handlers,
			init_options = require("config.lsp.servers.vuels").init_options,
			on_attach = require("config.lsp.servers.vuels").on_attach,
			settings = require("config.lsp.servers.vuels").settings,
		})
	end
}

require("ufo").setup({
	fold_virt_text_handler = ufo_config_handler,
  close_fold_kinds_for_ft = { default = { "imports" } },
})
