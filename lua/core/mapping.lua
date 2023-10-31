vim.g.mapleader = " "

-- Navigation
-- vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
-- vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
-- vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
-- vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<leader>/', ':CommentToggle<CR>')


--F LINE
vim.keymap.set('n', '<F4>', ':wa <CR>')
vim.keymap.set('n', '<F6>', ':wa <cr> :GoTest <cr>')
vim.keymap.set('n', '<F7>', '<cmd>ToggleTerm<cr>')
vim.keymap.set('n', '§', ':GoFillStruct <cr>')

vim.keymap.set({ 'n' }, '<Leader>k', function()
     vim.lsp.buf.signature_help()
    end, { silent = true, noremap = true, desc = 'toggle signature' })



vim.keymap.set('n', '<leader>q', '<cmd>confirm q<cr>>',{desc = "Quit"})
vim.keymap.set('n', '<leader>n', '<cmd>enew<cr>',{desc = "New file"})
vim.keymap.set('n', '<leader>c', ':bw<cr>',{desc = "Close"})
-- Tabs
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>')

-- NeoTree
  vim.keymap.set({'n'},'<leader>i', function()
      if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd "p"
      else
        vim.cmd.Neotree "focus"
      end
    end,
    { desc = "Toggle Explorer Focus",
})
-- NeoTree
vim.keymap.set('n', '<leader>o', ':Neotree float toggle<CR>')
vim.keymap.set('n', '<leader>e', ':Neotree left toggle<CR>')
vim.keymap.set('n', '<leader>g', ':Neotree float git_status<CR>')




-- Plugin Manager
-- maps.n["<leader>p"] = sections.p
-- maps.n["<leader>pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
-- maps.n["<leader>ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
-- maps.n["<leader>pS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
-- maps.n["<leader>pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
-- maps.n["<leader>pU"] = { function() require("lazy").update() end, desc = "Plugins Update" }


