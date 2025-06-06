vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-d>", '<C-d>zz')
vim.keymap.set("n", "<C-u>", '<C-u>zz')
vim.keymap.set("n", "n", 'nzz')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-u>", 'yykpddj')
vim.keymap.set("v", "<C-d>", 'Ypk')


-- Insert Matching Braces
vim.keymap.set("i", '(', '()<Esc>ha')
vim.keymap.set("i", '{', '{}<Esc>ha')
vim.keymap.set("i", '[', '[]<Esc>ha')
vim.keymap.set("i", "'", "''<Esc>ha")
vim.keymap.set("i", '<leader><', '<><Esc>ha')
vim.keymap.set("i", '"', '""<Esc>ha')

vim.keymap.set("v","<F6>", vim.lsp.buf.rename)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<C-E>", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<C-q>", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set({ 'i' }, '<C-s>', function()
    vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set('i', "<C-c>", "<Esc>");



vim.keymap.set({ 'n' }, '<C-k>', function()       require('lsp_signature').toggle_float_win()
    end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set({ 'n' }, '<Leader>k', function()
    vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set('n', 'ga', function ()
    vim.lsp.buf.code_action()
end)



vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)


-- Debugging keymaps
vim.keymap.set("n", "<C-b>", function ()
   require"dap".toggle_breakpoint() 
end)
vim.keymap.set('n', '<F1>', function() require('dap').continue() end)
vim.keymap.set('n', '<F5>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F2>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F4>', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
-- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)

vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)

vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)

vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)

vim.keymap.set('n', "<space>?", function() 
    require("dapui").eval(nil, {enter = true})
end)

vim.keymap.set('n', "<Esc>", function ()
    require("dapui").close()
end)


require("dapui").setup()
