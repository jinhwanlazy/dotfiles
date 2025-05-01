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
                    c = true,
                    cmake = true,
                    cpp = true,
                    css = true,
                    cuda = true,
                    dart = true,
                    gdb = true,
                    git = true,
                    gitattributes = true,
                    gitcommit = true,
                    gitconfig = true,
                    gitignore = true,
                    glsl = true,
                    go = true,
                    html = true,
                    javascript = true,
                    jq = true,
                    lua = true,
                    make = true,
                    markdown = true,
                    python = true,
                    ruby = true,
                    rust = true,
                    sh = true,
                    sql = true,
                    typescript = true,
                    typescriptreact = true,
                    vim = true,
                    ["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
                },
            })
        end,
    },
    {
        "frankroeder/parrot.nvim",
        dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
        opts = {},
        config = function()
            require("parrot").setup {
                -- Providers must be explicitly added to make them available.
                providers = {
                    anthropic = {
                        api_key = os.getenv "ANTHROPIC_API_KEY",
                        params = {
                            chat = {
                                max_tokens = 4096,
                                thinking = {
                                    budget_tokens = 1024,
                                    type = "enabled",
                                },
                            },
                            command = { max_tokens = 4096 },
                        },
                    },
                },
                chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
                chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
                chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
                chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },
                show_thinking_window = false,
                chat_free_cursor = true,
                hooks = {
                    Complete = function(prt, params)
                        local template = [[
                            I have the following code from {{filename}}:

                            ```{{filetype}}
                            {{selection}}
                            ```

                            Please finish the code above carefully and logically.
                            Respond just with the snippet of code that should be inserted."
                            ]]
                        local model_obj = prt.get_model "command"
                        prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
                    end,
                    CodeConsultant = function(prt, params)
                        local chat_prompt = [[
                            Your task is to analyze the provided {{filetype}} code and suggest
                            improvements to optimize its performance. Identify areas where the
                            code can be made more efficient, faster, or less resource-intensive.
                            Provide specific suggestions for optimization, along with explanations
                            of how these changes can enhance the code's performance. The optimized
                            code should maintain the same functionality as the original code while
                            demonstrating improved efficiency.

                            Here is the code
                            ```{{filetype}}
                            {{filecontent}}
                            ```
                        ]]
                        prt.ChatNew(params, chat_prompt)
                    end,
                }
            }

            local function keymapOptions(desc)
                return {
                    noremap = true,
                    silent = true,
                    nowait = true,
                    desc = "GPT prompt " .. desc,
                }
            end
            vim.keymap.set("n", "<C-g>q", "<cmd>PrtAsk<cr>", keymapOptions("Ask a question"))
            vim.keymap.set("n", "<C-g>a", "<cmd>PrtAppend<cr>", keymapOptions("Append"))

            vim.keymap.set({"n", "i"}, "<C-g>c", "<cmd>PrtChatNew<cr>", keymapOptions("New Chat"))
            vim.keymap.set({"n", "i"}, "<C-g>t", "<cmd>PrtChatToggle<cr>", keymapOptions("Toggle Chat"))
            vim.keymap.set({"n", "i"}, "<C-g>f", "<cmd>PrtChatFinder<cr>", keymapOptions("Chat Finder"))

            vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>PrtChatNew<cr>", keymapOptions("Visual Chat New"))
            vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>PrtChatPaste<cr>", keymapOptions("Visual Chat Paste"))
            vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>PrtChatToggle<cr>", keymapOptions("Visual Toggle Chat"))
            vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>PrtComplete<cr>", keymapOptions("Complete visual selection"))
            vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>PrtAppend<cr>", keymapOptions("Visual Append"))
        end,
    },
}
