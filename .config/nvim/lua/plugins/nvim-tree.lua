return {
    {
        "nvim-tree/nvim-web-devicons",
        --lazy = true ,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            -- disable netrw at the very start of your init.lua
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            -- set termguicolors to enable highlight groups
            --vim.opt.termguicolors = true
            require("nvim-tree").setup(
            )
        end,
        keys = {
            { "<F2>", ":NvimTreeToggle<CR>", desc = "Toggle tree" },
        }
    },
}
