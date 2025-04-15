return {
    --'ethanholz/nvim-lastplace',
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },
    { "nvim-lua/plenary.nvim", lazy = true },
    {
        "monaqa/dial.nvim",
        keys = { 
            { "<C-a>", "<Plug>(dial-increment)" },
            { "<C-x>", "<Plug>(dial-decrement)" },
        },
    },
    { "tpope/vim-surround", event = "VeryLazy", }, 
    { "tpope/vim-repeat", event = "VeryLazy", },
    { 
        "scrooloose/nerdcommenter",
        keys = { 
            { "<leader>", mode = "n" }, 
            { "<leader>", mode = "v" }, 
        }
    },
    { "f-person/git-blame.nvim", event = "VeryLazy", 
        config = function() 
            vim.g.gitblame_date_format = '%r'
        end,
    },
    {
        "jamessan/vim-gnupg",
        config = function() 
            vim.g.GPGPreferArmor = 1
        end,
    },
    {
        "tpope/vim-fugitive",
    },
    {
        'fei6409/log-highlight.nvim',
        config = function()
            require('log-highlight').setup {}
        end,
    },
    --{ 
        --'ojroques/nvim-osc52',
        --config = function()
            --require('osc52').setup {
                --max_length = 0,           -- Maximum length of selection (0 for no limit)
                --silent = false,           -- Disable message on successful copy
                --trim = false,             -- Trim surrounding whitespaces before copy
                --tmux_passthrough = false, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
            --}
        --keys = { 
            --{ "<leader>y", require('osc52').copy_visual, mode = "v" }, 
        --}
        --end,
    --},
}
