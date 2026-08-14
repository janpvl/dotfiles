return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false, -- nötig, damit oil netrw beim Öffnen von Ordnern ersetzt
  opts = {
    default_file_explorer = false,
    view_options = { show_hidden = true },
    keymaps = {
      ["q"] = "actions.close",
    },
  },
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "Oil (Ordner der Datei)" },
    {
      "<leader>E",
      function()
        require("oil").open(vim.uv.cwd())
      end,
      desc = "Oil (cwd)",
    },
  },
}
