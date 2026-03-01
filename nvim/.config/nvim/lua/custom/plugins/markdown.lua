return {
	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",

		opts = {
			preview = {
				enable = true,
			},
		},

		config = function(_, opts)
			-- markview starten
			require("markview").setup(opts)

			-- conceal aktivieren (sehr wichtig)
			vim.opt.conceallevel = 2

			-- Highlights definieren
			vim.api.nvim_set_hl(0, "MarkviewHeading1", { fg = "#ff6b6b", bold = true })
			vim.api.nvim_set_hl(0, "MarkviewHeading2", { fg = "#feca57", bold = true })
			vim.api.nvim_set_hl(0, "MarkviewHeading3", { fg = "#48dbfb", bold = true })
			vim.api.nvim_set_hl(0, "MarkviewHeading4", { fg = "#1dd1a1", bold = true })
			vim.api.nvim_set_hl(0, "MarkviewHeading5", { fg = "#5f27cd", bold = true })
			vim.api.nvim_set_hl(0, "MarkviewHeading6", { fg = "#ff9ff3", bold = true })
			vim.api.nvim_set_hl(0, "@markup.list.checked.markdown", {
				fg = "#a6e3a1",
			})

			vim.api.nvim_set_hl(0, "@markup.list.unchecked.markdown", {
				fg = "#f38ba8",
			})
		end,
	},
}
