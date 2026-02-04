return {
    {
        "zbirenbaum/copilot.lua",
        commit = "4725916b1e08a0cfed8fa6d9691ccd1609a347ee",
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
        "samir-roy/code-bridge.nvim",
        config = function()
            require('code-bridge').setup {
                tmux = {
                    target_mode = 'current_window',
                    process_name = 'claude',
                    switch_to_target = false,  -- don't switch to claude pane after sending
                    find_node_process = true, -- agent runs inside node.js process
                },
            }
            vim.keymap.set('n', "<C-g>p", "<cmd>CodeBridgeTmux<cr>", {noremap=true, silent=true, desc="Code Bridge: Tmux"})
            vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>CodeBridgeTmux<cr>", {noremap=true, silent=true, desc="Code Bridge: Tmux"})
        end,
    },
}
