return {
  {
    "phaazon/hop.nvim",
    lazy = true,
    opts = function(_, opts)
      require("hop").setup({})
    end,
    keys = {
      {
        "f",
        "<cmd>lua require'hop'.hint_char1()<cr>",
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "t",
        "<cmd>HopPattern<CR>",
        mode = "n",
        noremap = true,
        silent = true,
      },
    },
  },
}
