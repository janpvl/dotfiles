vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.winborder = "rounded"
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.opt.hidden = true

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/numtostr/comment.nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{
		src = "https://github.com/JavaHello/spring-boot.nvim",
		version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
	},
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/nvim-java/nvim-java" },
	{ src = "https://github.com/OXY2DEV/markview.nvim" },
})

vim.cmd.colorscheme("gruvbox")
vim.g.mapleader = " "

-- lsp
require("java").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
		"gopls",
		"clangd",
	},
})

---- fix 'Undefined global vim' error in config file
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.keymap.set({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format current buffer" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "grd", vim.lsp.buf.definition, {
	desc = "[G]oto [D]efinition",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/completion") then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}
			for i = 32, 126 do
				table.insert(chars, string.char(i))
			end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

vim.cmd([[set completeopt+=menuone,noselect,popup]])

-- split window
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d<CR>')

-- clear highlights on esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- oil
require("mini.icons").setup()
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")

-- markview markdown
require("markview").setup()
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
