return {
    {
        "mhinz/vim-signify",
        config = function() 
            vim.g.signify_line_highlight = 0  
            vim.g.signify_sign_add       = '┃'  
            vim.g.signify_sign_delete    = '┃'    
            vim.g.signify_sign_change    = '┃'
        end
    },
    {
        "chentoast/marks.nvim",
        init = function()
            require("marks").setup {
                -- whether to map keybinds or not. default true
                default_mappings = true,
                -- which builtin marks to show. default {}
                builtin_marks = {},
            }
        end,
    },
    {
        "SmiteshP/nvim-navic",
        lazy = false,
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.g.navic_silence = true
            require("lspconfig").clangd.setup {
                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentSymbolProvider then
                        require("nvim-navic").attach(client, bufnr)
                    end
                end
            }
        end,
    },
    { 
        "nvim-lualine/lualine.nvim", 
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "chriskempson/base16-vim",
        },
        opts = function()
            --local icons = require("lazyvim.config").icons
            --local Util = require("lazyvim.util")
            base16_theme = nil
            if vim.g.base16_gui00 then
                base16_theme = {
                    normal = {
                        a = { fg = vim.g.base16_gui01, bg = vim.g.base16_gui04, gui = 'bold' },
                        b = { fg = vim.g.base16_gui05, bg = vim.g.base16_gui02 },
                        c = { fg = vim.g.base16_gui05, },
                    },
                    insert = {
                        a = { fg = vim.g.base16_gui01, bg = vim.g.base16_gui0B, gui = 'bold' },
                        b = { fg = vim.g.base16_gui05, bg = vim.g.base16_gui02 },
                    },
                    replace = {
                        a = { fg = vim.g.base16_gui01, bg = vim.g.base16_gui09, gui = 'bold' },
                        b = { fg = vim.g.base16_gui05, bg = vim.g.base16_gui02 },
                    },
                    visual = {
                        a = { fg = vim.g.base16_gui01, bg = vim.g.base16_gui0E, gui = 'bold' },
                        b = { fg = vim.g.base16_gui05, bg = vim.g.base16_gui02 },
                    },
                    inactive = {
                        a = { fg = vim.g.base16_gui03, bg = vim.g.base16_gui01, gui = 'bold' },
                        b = { fg = vim.g.base16_gui03, bg = vim.g.base16_gui01 },
                        c = { fg = vim.g.base16_gui03, bg = vim.g.base16_gui01 },
                    },
                }
                base16_theme.command = base16_theme.replace
                base16_theme.terminal = base16_theme.insert
            end
            return {
                options = {
                    theme = base16_theme or "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                    section_separators = { left = '', right = '', },
                    component_separators = '|'
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 4, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                        -- stylua: ignore
                        {
                            function() 
                                return require("nvim-navic").get_location() 
                            end,
                            cond = function()
                                return package.loaded["nvim-navic"] and require("nvim-navic").is_available() 
                            end,
                        },
                    },
                    lualine_x = {
                        -- stylua: ignore
                        {
                            function() 
                                return require("noice").api.status.command.get() 
                            end,
                            cond = function()
                                return package.loaded["noice"] and require("noice").api.status.command.has() 
                            end,
                            --color = Util.fg("Statement"),
                        },
                        -- stylua: ignore
                        {
                            function()
                                return require("noice").api.status.mode.get() 
                            end,
                            cond = function()
                                return package.loaded["noice"] and require("noice").api.status.mode.has() 
                            end,
                            --color = Util.fg("Constant"),
                        },
                        -- stylua: ignore
                        {
                            function() 
                                return "  " .. require("dap").status()
                            end,
                            cond = function() 
                                return package.loaded["dap"] and require("dap").status() ~= "" 
                            end,
                            --color = Util.fg("Debug"),
                        },
                        { 
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            --color = Util.fg("Special") 
                        },
                        {
                            "diff",
                            symbols = {
                                added = "+",
                                modified = "~",
                                removed = "-",
                            },
                        },
                        {
                            "diagnostics",
                            symbols = {
                                error = " ",
                                warn = " ",
                                info = " ",
                                hint = " ",
                            },
                        },
                    },
                    lualine_y = {
                        "encoding",
                        "filesize",
                        "fileformat",
                    },
                    lualine_z = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                },
                --extensions = { "neo-tree", "lazy" },
            }
        end,
    },
    --{
        --"lukas-reineke/indent-blankline.nvim",
        --event = "VeryLazy",
        --opts = {
            --indent = {
                --char = "¦",
                --tab_char = "¦",
            --},
            --scope = { enabled = false },
            --exclude = {
                --filetypes = {
                    --"help",
                    --"alpha",
                    --"dashboard",
                    --"neo-tree",
                    --"Trouble",
                    --"lazy",
                    --"mason",
                    --"notify",
                    --"toggleterm",
                    --"lazyterm",
                --},
            --},
        --},
        --main = "ibl",
    --},
}
