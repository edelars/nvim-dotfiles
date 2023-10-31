vim.g.mapleader = " "

-- Navigation
-- vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
-- vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
-- vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
-- vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<leader>/', ':CommentToggle<CR>')

--MOVE IN INSERT
vim.api.nvim_set_keymap('i', '<c-h>', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<c-j>', '<C-o>gj', { noremap = true })
vim.api.nvim_set_keymap('i', '<c-k>', '<C-o>gk', { noremap = true })
vim.api.nvim_set_keymap('i', '<c-l>', '<Right>', { noremap = true })

--F LINE
vim.keymap.set('n', '<F4>', ':wa <CR>')
vim.keymap.set('n', '<F6>', ':wa <cr> :GoTest <cr>')
vim.keymap.set('n', '<F7>', '<cmd>ToggleTerm<cr>')
vim.keymap.set('n', '§', ':GoFillStruct <cr>')

vim.keymap.set({ 'n' }, '<Leader>k', function()
     vim.lsp.buf.signature_help()
    end, { silent = true, noremap = true, desc = 'toggle signature' })



vim.keymap.set('n', '<leader>p', function() require("lazy").home() end,{desc = "Lazy"})
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


