
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Perform autoformat the code",
  group = vim.api.nvim_create_augroup("GoFormat", { clear = false }),
    pattern = "*.go",
  callback = function() require('go.format').goimport() end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "Perform autoformat the code",
  group = vim.api.nvim_create_augroup("GoFormat2", { clear = false }),
    pattern = "*.go",
  callback = function() require('go.format').goimport() end,
})

