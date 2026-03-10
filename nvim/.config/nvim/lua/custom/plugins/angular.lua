return {
	-- Mason: install the tools we need
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			opts = opts or {}
			opts.ensure_installed = opts.ensure_installed or {}

			local extra = {
				"angular-language-server",
				"vtsls",
				"prettier",
			}

			for _, tool in ipairs(extra) do
				if not vim.tbl_contains(opts.ensure_installed, tool) then
					table.insert(opts.ensure_installed, tool)
				end
			end

			return opts
		end,
	},

	-- LSP: vtsls + angularls
	{
		"neovim/nvim-lspconfig",
		config = function()
			local mason_pkg = vim.fn.stdpath("data")
				.. "/mason/packages/angular-language-server/node_modules/@angular/language-server"

			vim.lsp.config("vtsls", {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@angular/language-server",
									location = mason_pkg,
									enableForWorkspaceTypeScriptVersions = false,
								},
							},
						},
					},
				},
			})

			vim.lsp.enable("vtsls")
			vim.lsp.enable("angularls")
		end,
	},

	-- Formatter: prettier for Angular/TS/HTML/CSS
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts = opts or {}
			opts.formatters_by_ft = opts.formatters_by_ft or {}

			local prettier_fts = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				htmlangular = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
			}

			opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, prettier_fts)
			return opts
		end,
	},

	-- Treesitter + Angular template filetype handling
	{
		"nvim-treesitter/nvim-treesitter",
		init = function()
			-- Treat Angular component/container templates as htmlangular
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				pattern = { "*.component.html", "*.container.html" },
				callback = function(args)
					vim.bo[args.buf].filetype = "htmlangular"
				end,
			})

			-- Start angular parser for htmlangular buffers
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "htmlangular",
				callback = function(args)
					pcall(vim.treesitter.start, args.buf, "angular")
				end,
			})

			-- Install parsers once Lazy is done loading
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyDone",
				once = true,
				callback = function()
					local ok, ts = pcall(require, "nvim-treesitter")
					if not ok then
						return
					end

					pcall(ts.install, {
						"angular",
						"css",
						"scss",
						"html",
						"javascript",
						"typescript",
						"tsx",
					})
				end,
			})
		end,
	},
}
