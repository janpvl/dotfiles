return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	config = function()
		require("flutter-tools").setup({})

		vim.keymap.set("n", "<leader>fR", ":FlutterRun<CR>")
		vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>")
		vim.keymap.set("n", "<leader>fr", ":FlutterRestart<CR>")
		vim.keymap.set("n", "<leader>ff", ":FlutterLogToggle<CR>")
		vim.keymap.set("n", "<leader>fc", ":FlutterLogClear<CR>")

		-- which-key group
		local wk = require("which-key")
		wk.add({
			{ "<leader>f", group = "Flutter", icon = "" },
		})
	end,
}
