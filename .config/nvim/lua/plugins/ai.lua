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
            })
        end,
    },
    {
        "robitx/gp.nvim",
        config = function()
            local conf = {
                providers = {
                    copilot = {
                        disable = true,  -- copilot is handled by copilot.lua plugin  
                    },
                    openai = {
                        disable = true,
                    },
                    anthropic = {
                        disable = false,
                        endpoint = "https://api.anthropic.com/v1/messages",
                        secret = os.getenv "ANTHROPIC_API_KEY",
                    },
                },
                toggle_target = "vsplit",
                chat_free_cursor = true,
                chat_user_prefix = "QUERY:",
                chat_assistant_prefix = { "AGENT:", "[{{agent}}]" },
            }
            require("gp").setup(conf)

            -- Shortcuts
            local function keymapOptions(desc)
                return {
                    noremap = true,
                    silent = true,
                    nowait = true,
                    desc = "GPT prompt " .. desc,
                }
            end

            -- Chat commands
            vim.keymap.set({"n", "i"}, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
            vim.keymap.set({"n", "i"}, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
            vim.keymap.set({"n", "i"}, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

            vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
            vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
            vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

            vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))
        end,
    },
}
