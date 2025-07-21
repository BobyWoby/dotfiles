local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set("n", "<leader>w", builtin.diagnostics, { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>b", builtin.diagnostics, { desc = "Buffer Diagnostics" })

vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });


end, { desc = 'Telescope find git files' })

