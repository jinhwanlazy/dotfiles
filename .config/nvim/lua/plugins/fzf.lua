return {
    { 
        "junegunn/fzf",
        dir = "~/.fzf",
        build = "./install --all" ,
        lazy = true,
    },
    {
        'junegunn/fzf.vim',
        dependencies = { 
            "junegunn/fzf",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
        end,
        keys = {
            { "<C-p>", ":Files<cr>" },
            { "<F1>", ":Commands<cr>" },
            { "<C-,>", ":Lines<cr>" },
            --{ "<C-g>", ":Ag<cr>" },
            { "<C-m>", ":Marks<cr>" },
            { "<C-t>", ":Tags<cr>" },
        },
    }
}
