vim.g['test#strategy'] = 'kitty'
vim.keymap.set('n', '<leader>t', ':TestFile<CR>', {})
vim.keymap.set('n', '<leader>s', ':TestNearest<CR>', {})
vim.keymap.set('n', '<leader>l', ':TestLast<CR>', {})
vim.keymap.set('n', '<leader>a', ':TestSuite<CR>', {})
vim.keymap.set('n', '<leader>gt', ':TestVisit<CR>', {})
