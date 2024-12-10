return {
    {
        "chriskempson/base16-vim",
        lazy = false,
        config = function()
            vimrc_background = "~/.vimrc_background"
            if vim.fn.filereadable(vimrc_background)
                then
                vim.g.base16colorspace=256
                vim.cmd('source ' .. vimrc_background)
            end
            vim.g.colors_name = "16color"
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
