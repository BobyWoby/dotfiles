require('mason').setup({})

local lsp = require("lsp-zero")
-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

vim.lsp.handlers["textDocument/formatting"] = vim.lsp.with(vim.lsp.handlers["textDocument/formatting"], {
    settings = {
        -- Assuming you want 4 spaces and no tabs
        tabSize = 4,
        insertSpaces = true, -- Ensures spaces instead of tabs
    },
})


-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F6>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F5>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

local util = require "lspconfig/util"
require("mason-lspconfig").setup {
    automatic_enable = true
}
-- Language Server stuff
-- require 'lspconfig'.clangd.setup {}
-- require 'lspconfig'.lua_ls.setup {}
-- require 'lspconfig'.jdtls.setup {}
-- require 'lspconfig'.rust_analyzer.setup {}
-- require 'lspconfig'.bashls.setup {}
-- require 'lspconfig'.cmake.setup {}
-- require 'lspconfig'.gopls.setup {}

-- Auto-Complete
local cmp = require('cmp')
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

            -- For `mini.snippets` users:
            -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            -- insert({ body = args.body }) -- Insert at cursor
            -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            -- require("cmp.config").set_onetime({ sources = {} })
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
    },
    mapping = cmp.mapping.preset.insert({
        -- Navigate between completion items
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),

        -- `Tab` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),

        -- Ctrl+Space to trigger completion menu
        --['<C-Space>'] = cmp.mapping.complete(),
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Scroll up and down in the completion documentation
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
    }),
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
})

vim.diagnostic.config({
    virtual_text = true,
    -- virtual_lines={current_line=true},
    virtual_lines = false,
    underline = true,
    update_in_insert = true
})

-- require("lspconfig").gopls.setup({
--     capabilities = require("cmp_nvim_lsp").default_capabilities(),
-- })
-- local cmp = require('cmp')
-- function
-- cmp.setup({
--   sources = {
--     {name = 'nvim_lsp'},
--   },
--   snippet = {
--     expand = function(args)
--       -- You need Neovim v0.10 to use vim.snippet
--       vim.snippet.expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert({}),
-- })
-- })
-- })
-- })
-- })
-- })
-- })
-- })
