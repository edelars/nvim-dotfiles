return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      local bufline = require("catppuccin.groups.integrations.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
    keys = {
      {
        "<Tab>",
        ":BufferLineCycleNext<CR>",
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "<S-Tab>",
        ":BufferLineCyclePrev<CR>",
        mode = "n",
        noremap = true,
        silent = true,
      },
    },
    --     vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
    -- vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")

    opts = {
      options = {
        always_show_bufferline = true,
        buffer_close_icon = "",
        mode = "buffers",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            separator = true,
            padding = 1,
          },
        },
        diagnostics = "nvim_lsp",
        indicator = {
          icon = "  ", -- this should be omitted if indicator style is not 'icon'
          style = "icon",
        },
        -- separator_style = "slope"
      },
    },
  },
}
