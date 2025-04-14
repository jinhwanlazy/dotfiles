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
    --{
        --"robitx/gp.nvim",
        --config = function()
            --local conf = {
                --providers = {
                    --copilot = {
                        --disable = true,  -- copilot is handled by copilot.lua plugin  
                    --},
                    --openai = {
                        --disable = true,
                    --},
                    --anthropic = {
                        --disable = false,
                        --endpoint = "https://api.anthropic.com/v1/messages",
                        --secret = os.getenv "ANTHROPIC_API_KEY",
                    --},
                --},
                  --agents = { 
                    --{ 
                        --provider = "anthropic", 
                        --name = "ChatClaude-3-5-Sonnet", 
                        --chat = true, 
                        --command = false, 
                        ---- string with model name or table with model name and parameters 
                        --model = { model = "claude-3-5-sonnet-20241022", temperature = 0, top_p = 0.5 }, 
                        ---- system prompt (use this to specify the persona/role of the AI) 
                        --system_prompt = require("gp.defaults").chat_system_prompt, 
                    --},
                --},

                --toggle_target = "vsplit",
                --chat_free_cursor = true,
                --chat_user_prefix = "QUERY:",
                --chat_assistant_prefix = { "AGENT:", "[{{agent}}]" },
            --}
            --require("gp").setup(conf)

            ---- Shortcuts
            --local function keymapOptions(desc)
                --return {
                    --noremap = true,
                    --silent = true,
                    --nowait = true,
                    --desc = "GPT prompt " .. desc,
                --}
            --end

            ---- Chat commands
            --vim.keymap.set({"n", "i"}, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
            --vim.keymap.set({"n", "i"}, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
            --vim.keymap.set({"n", "i"}, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

            --vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
            --vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
            --vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

            --vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))
        --end,
    --},
}
