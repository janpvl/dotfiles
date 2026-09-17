return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Oil (Parent-Verzeichnis)" },
    { "<leader>e", "<cmd>Oil<cr>", desc = "Explorer Oil (Datei-Verzeichnis)" },
    {
      "<leader>E",
      function()
        require("oil").open(LazyVim.root())
      end,
      desc = "Explorer Oil (root dir)",
    },
  },
}
