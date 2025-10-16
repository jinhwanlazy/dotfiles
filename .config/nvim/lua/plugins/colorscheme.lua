return {
    {
        "tinted-theming/tinted-vim",
        config = function() 
            vim.g.tinted_background_transparent = 1
            vim.g.tinted_colorspace = 256
            vim.g.tinted_italic = 0
            local colorscheme = vim.fn.system({ "tinty", "current" })
            vim.cmd.colorscheme(vim.trim(colorscheme))
        end
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
            require("transparent").setup({ -- Optional, you don't have to run setup.
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer',
                },
                extra_groups = {}, -- table: additional groups that should be cleared
                exclude_groups = {}, -- table: groups you don't want to clear
            })
        end
    },
}
