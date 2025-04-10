vim.g.mapleader = " "

--neoclip
vim.api.nvim_set_keymap("i", "<c-o>", "<cmd>:Telescope neoclip<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>p", ":Telescope neoclip<CR>", { noremap = true,desc = "Clipboard manager"  })

-- Navigation
local before = require("before")
vim.keymap.set("n", "<C-h>", before.jump_to_last_edit, {})
vim.keymap.set("n", "<C-l>", before.jump_to_next_edit, {})
-- vim.api.nvim_set_keymap('n', '<C-k>', '<PageUp>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-j>', '<PageDown>', { noremap = true })
-- vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
-- vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
-- vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
-- vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set("n", "<leader>/", ":CommentToggle<CR>")
vim.keymap.set("v", "<leader>/", ":CommentToggl<CR>")

--F LINE
vim.keymap.set("n", "<F4>", ":wa <CR>", { desc = "Save all" })
-- vim.keymap.set('n', '<F6>', ':wa <cr> :GoTest <cr>',{desc = "Run test"})
vim.keymap.set("n", "<F7>", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })
-- vim.keymap.set('n', '§', ':GoFillStruct <cr>')
vim.keymap.set("n", "<F12>", ":Telescope projects<cr>", { desc = "Telescope Projects" })

vim.keymap.set({ "n" }, "<Leader>k", function()
	vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = "toggle signature" })

vim.keymap.set("n", "<leader>w", ":wa <CR>", { desc = "Save all" })

vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })

vim.keymap.set("n", "<leader>v", function()
	require("lazy").home()
end, { desc = "Lazy" })
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>>", { desc = "Quit" })
vim.keymap.set("n", "<leader>n", "<cmd>enew<cr>", { desc = "New file" })
vim.keymap.set("n", "<leader>c", ":bw<cr>", { desc = "Close" })
-- Tabs
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")

-- NeoTree
vim.keymap.set({ "n" }, "<leader>i", function()
	if vim.bo.filetype == "neo-tree" then
		vim.cmd.wincmd("p")
	else
		vim.cmd.Neotree("focus")
	end
end, { desc = "Toggle Explorer Focus" })
-- NeoTree
vim.keymap.set("n", "<leader>o", ":Neotree float toggle<CR>")
vim.keymap.set("n", "<leader>e", ":Neotree left toggle<CR>")
vim.keymap.set("n", "<leader>gm", ":Neotree float git_status<CR>")

-- vim.keymap.set('n', '<leader>g', {desc = "asdasd"})
vim.keymap.set("n", "<leader>b", ":Format<CR>", { desc = "Format lines" })
