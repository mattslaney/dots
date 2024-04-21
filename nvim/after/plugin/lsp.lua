---
-- LSP setup
---
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

local mason_exists, mason = pcall(require, 'mason')
if mason_exists then
    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = {'lua_ls', 'clangd'},
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end,
        },
        rust_analyzer = lsp_zero.noop,
    })
else
    print("Not loading mason")
    require('lspconfig').clangd.setup({})
end

vim.g.rustaceanvim = {
    server = {
        capabilities = require('lsp-zero').get_capabilities()
    },
}

---
-- Autocompletion config
---
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- Navigate completion menu
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),

        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})

