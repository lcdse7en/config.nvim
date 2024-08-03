local wk = require("which-key")

wk.setup({
	preset = "modern", -- helix
	icons = {
		mappings = false,
	},
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = false,
			nav = false,
			z = false,
			g = false,
		},
	},
	win = {
		border = "rounded",
		no_overlap = false,
		padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
		title = false,
		title_pos = "center",
		zindex = 1000,
	},
	-- ignore_missing = true,
	show_help = false,
	show_keys = false,
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
})

wk.add({
	{
		"<leader>/",
		group = "Ecovim",
	},
	{
		"<leader>a",
		group = "Actions",
	},
	{
		"<leader>as",
		group = "Snippet(json)",
	},
	{
		"<leader>aa",
		group = "Edit file",
	},
	{
		"<leader>b",
		group = "Buffer",
	},
	{
		"<leader>c",
		group = "Lsp",
	},
	{
		"<leader>d",
		group = "Debug",
	},
	{
		"<leader>f",
		group = "Format",
	},
	{
		"<leader>g",
		group = "Git",
	},
	{
		"<leader>h",
		"<cmd>nohlsearch<CR>",
		desc = "nohlsearch",
		hidden = false,
	},
	{
		"<leader>i",
		group = "img-clip",
	},
	{
		"<leader>n",
		group = "Noice",
	},

	{
		"<leader>o",
		group = "Overseer",
	},
	{
		"<leader>p",
		group = "Project",
	},
	{
		"<leader>r",
		group = "Refactor",
	},
	{
		"<leader>s",
		group = "Search",
	},
	{
		"<leader>t",
		group = "Table Mode",
	},
})
