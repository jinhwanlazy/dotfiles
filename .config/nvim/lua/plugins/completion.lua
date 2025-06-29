return {
    {
        "SirVer/ultisnips",
        lazy=true,
        config = function() 
            vim.g.UltiSnipsSnippetDirectories = { '~/Workspace/problem_solving/.misc/snippets' }
        end,
    },
    {
        "quangnguyen30192/cmp-nvim-ultisnips",
        lazy=true,
    },
    {
        'hrsh7th/cmp-nvim-lsp',
        lazy=true,
    },
    --{
        --'hrsh7th/cmp-cmdline',
        --lazy=true,
    --},
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            "SirVer/ultisnips",
            "quangnguyen30192/cmp-nvim-ultisnips",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                         vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    --{ name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                        { name = 'buffer' },
                })
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                }, {
                        { name = 'buffer' },
                    })
            })

            ---- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            --cmp.setup.cmdline({ '/', '?' }, {
                --mapping = cmp.mapping.preset.cmdline(),
                --sources = {
                    --{ name = 'buffer' }
                --}
            --})

            -- Set up lspconfig.
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            require('lspconfig')['clangd'].setup {
                capabilities = capabilities
            }
        end
    },
}
