return {
	name = "run script",
	condition = {
		filetype = { "sh", "python" },
	},
	builder = function()
		return {
			name = vim.fn.expand("%:t"),
			cmd = vim.bo.filetype == "sh" and "sh" or "python3",
			cwd = vim.fn.expand("%:p:h"),
			args = { vim.fn.expand("%:p") },
			conponents = {
				"task_list_on_start",
				"display_duration",
				"on_exit_set_status",
				"on_complete_notify",
			},
		}
	end,
}
