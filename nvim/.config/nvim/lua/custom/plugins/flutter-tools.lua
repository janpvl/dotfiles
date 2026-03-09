return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	config = function()
		require("flutter-tools").setup({})

		local keymap = vim.keymap.set

		keymap("n", "<leader>ar", ":FlutterRestart<CR>")
		keymap("n", "<leader>all", ":FlutterLogToggle<CR>")
		keymap("n", "<leader>alc", ":FlutterLogClear<CR>")
	end,
}
