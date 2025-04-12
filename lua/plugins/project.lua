return {
  {
    "ahmedkhalf/project.nvim",
    lazy = true,
    -- vim.keymap.set("n", "<F12>", ":Telescope projects<cr>", { desc = "Telescope Projects" })

    keys = {
      {
        "<F12>",
        ":Telescope projects<cr>",
        desc = "Telescope Projects",
        mode = { "n", "v", "i" },
        noremap = true,
        silent = true,
      },
    },
    opts = function(_, opts)
      require("project_nvim").setup({
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })

      require("telescope").load_extension("projects")
    end,
  },
}
