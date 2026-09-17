return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },

    {
      "<leader>t",
      function()
        local p = Snacks.picker.get({ source = "explorer" })[1]
        if p and not p.closed then
          p:close()
          return
        end

        local name = vim.api.nvim_buf_get_name(0)
        local path
        if name:match("^oil://") then
          local ok, oil = pcall(require, "oil")
          if ok then
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if dir and entry then
              path = dir .. entry.name
            else
              path = dir
            end
          end
        elseif name ~= "" then
          path = name
        end

        if path then
          Snacks.explorer.reveal({ file = path })
        else
          Snacks.explorer.reveal({ buf = 0 })
        end
      end,
      desc = "Explorer toggle (aktuelle Datei)",
    },
    {
      "<leader>T",
      function()
        Snacks.explorer.reveal({ buf = 0, cwd = LazyVim.root() })
      end,
      desc = "Explorer (root dir)",
    },
  },
  opts = {
    explorer = {
      replace_netrw = false,
    },
    picker = {
      sources = {
        explorer = {
          hidden = true, -- Dotfiles anzeigen
          ignored = true, -- auch gitignorte Dateien
          auto_close = false,
          watch = true,
          layout = {
            hidden = { "input" }, -- Eingabefeld des Pickers ausblenden
            layout = {
              width = 30,
            },
          },
        },
      },
    },
  },
}
