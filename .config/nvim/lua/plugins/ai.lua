return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    debounce = 75,
                    keymap = {
                        accept = "<C-j>",
                        accept_word = "<C-l>",
                        accept_line = false,
                        next = "<C-n>",
                        prev = "<C-p>",
                        dismiss = "<C-h>",
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    text = false,
                    ["."] = false,
                    sh = function ()
                        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
                            -- disable for .env files
                            return false
                        end
                        return true
                    end,
                },
            })
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = {
                        adapter = "anthropic",
                        keymaps = {
                            close = {
                                modes = { n = "<C-x>", i = "<C-x>" },
                            },
                        },
                    },
                    inline = {
                        adapter = "anthropic",
                    },
                },
                adapters = {
                    openai_o3_mini = function()
                        return require("codecompanion.adapters").extend("openai", {
                            name = "openai_o3_mini",
                            schema = {
                                model = {
                                    default = "o3-mini-2025-01-31",
                                },
                            },
                        })
                    end,
                    openai_o1_mini = function()
                        return require("codecompanion.adapters").extend("openai", {
                            name = "openai_o1_mini",
                            schema = {
                                model = {
                                    default = "o1-mini-2024-09-12",
                                },
                            },
                        })
                    end,
                },
            })
        end,
        keys = {
            { "<C-g>q", ":CodeCompanion<cr>", mode="n", },
            { "<C-g>q", ":CodeCompanion ", mode="v", },
            { "<C-g>n", ":CodeCompanionChat<cr>", mode="n", },
            { "<C-g>t", ":CodeCompanionChat Toggle<cr>", mode="n", },
            { "<C-g>t", ":CodeCompanionChat Add<cr>", mode="v", },
            { "<C-g>a", ":CodeCompanionActions<cr>", mode="n", },
            { "<C-g>c", ":CodeCompanionCmd ", mode="n", },
        },
    },
}
