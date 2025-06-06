return {
  {
    "ahmedkhalf/project.nvim",
    enabled = false,
    lazy = false,
    config = function()
      require("project_nvim").setup({})
    end,
    opts = {
      -- Manual mode doesn't automatically change your root directory, so you have
      -- the option to manually do so using `:ProjectRoot` command.
      manual_mode = false,

      -- Methods of detecting the root directory. **"lsp"** uses the native neovim
      -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
      -- order matters: if one is not detected, the other is used as fallback. You
      -- can also delete or rearangne the detection methods.
      detection_methods = { "lsp", "pattern" },

      -- All the patterns used to detect root dir, when **"pattern"** is in
      -- detection_methods
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

      -- Table of lsp clients to ignore by name
      -- eg: { "efm", ... }
      ignore_lsp = {},

      -- Don't calculate root dir on specific directories
      -- Ex: { "~/.cargo/*", ... }
      exclude_dirs = {
        "~/Documents/scala/event_dynamic/platform/*",
        "~/Documents/scala/event_dynamic/platform/ed-backend/*",
      },

      -- Show hidden files in telescope
      show_hidden = false,

      -- When set to false, you will get a message when project.nvim changes your
      -- directory.
      silent_chdir = true,

      -- What scope to change the directory, valid options are
      -- * global (default)
      -- * tab
      -- * win
      scope_chdir = "global",

      -- Path where project.nvim will store the project history for use in
      -- telescope
      datapath = vim.fn.stdpath("data"),
    },
    keys = {
      {
        "<F12>",
        function()
          local history = require("project_nvim.utils.history")
          local fzf_lua = require("fzf-lua")
          fzf_lua.fzf_exec(function(cb)
            local results = history.get_recent_projects()
            for _, e in ipairs(results) do
              cb(e)
            end
            cb()
          end, {
            actions = {
              ["default"] = {
                function(selected)
                  fzf_lua.files({ cwd = selected[1] })
                end,
              },
              ["ctrl-d"] = {
                function(selected)
                  history.delete_project({ value = selected[1] })
                end,
                fzf_lua.actions.resume,
              },
            },
          })
        end,
        desc = "Telescope Projects",
        mode = { "n", "v", "i" },
        noremap = true,
        silent = true,
      },
    },
  },
}
