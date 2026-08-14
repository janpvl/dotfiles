return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },
    { "<leader>t", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
    { "<leader>T", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
  },
  opts = {
    explorer = {
      replace_netrw = true,
    },
    picker = {
      sources = {
        explorer = {
          layout = {
            hidden = { "input" }, -- hier, eine Ebene höher
            layout = {
              width = 30,
            },
          },
        },
      },
    },
  },
}
