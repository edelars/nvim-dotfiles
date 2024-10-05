vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Perform autoformat the code",
	group = vim.api.nvim_create_augroup("GoFormat", { clear = false }),
	pattern = "*.go",
	callback = function() --vim.cmd('silent! GoFmt')
		require("go.format").goimport()
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	desc = "Perform autoformat the code 2",
	group = vim.api.nvim_create_augroup("GoFormat2", { clear = true }),
	pattern = "*.go",
	callback = function()
		-- callback = function() vim.cmd('silent! exec ":GoFmt"')
		require("go.format").goimport()
	end,
})
