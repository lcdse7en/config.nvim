return {
	name = "Compile Typst",
	condition = {
		filetype = { "typst" },
	},
	builder = function()
		local file_dir = vim.fn.expand("%:p:h")
		local root_dir = vim.fn.fnamemodify(file_dir, ":h")
		local font_dir = root_dir .. "/fonts"
		-- local project_root = vim.fn.finddir(".git", file_dir .. ";")
		-- if project_root == "" then
		-- 	project_root = cwd
		-- else
		-- 	project_root = vim.fn.fnamemodify(project_root, ":h") .. "/init-files"
		-- end
		return {
			name = vim.fn.expand("%:t"),
			cwd = file_dir,
			cmd = { "typst" },
			args = { "compile", vim.fn.expand("%:p"), "--root", root_dir, "--font-path", font_dir },
			conponents = {
				"task_list_on_start",
				"display_duration",
				"on_exit_set_status",
				"on_complete_notify",
			},
		}
	end,
}
