function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return {
    {
        "neovim/nvim-lspconfig",
        keys = {
            { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
            { "]d", diagnostic_goto(true), },
            { "[d", diagnostic_goto(false), },
            { "]e", diagnostic_goto(true, "ERROR"), },
            { "[e", diagnostic_goto(false, "ERROR"), },
            { "]w", diagnostic_goto(true, "WARNING"), },
            { "[w", diagnostic_goto(false, "WARNING"), },
            { 'gd', vim.lsp.buf.definition, },
            { 'gD', vim.lsp.buf.declaration, },
            { 'gI', vim.lsp.buf.implementation, },
            { 'gr', vim.lsp.buf.references, },
            { 'K', vim.lsp.buf.hover, },
            { 'gK', vim.lsp.buf.signature_help, },
            { '<c-k>', vim.lsp.buf.signature_help, mode= 'i', },
            { '<c-k><c-o>', ":ClangdSwitchSourceHeader<cr>", mode= 'n', },
            { '<leader>qf', vim.lsp.buf.code_action, mode = { 'n', 'v' }, },
            { "<leader>=", vim.lsp.buf.format, mode = 'n' },
            { "<leader>=", function() 
                local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
                local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
                vim.lsp.buf.format { 
                    async = true,
                    range = {
                        ["start"] = { start_row, 0 },
                        ["end"] = { end_row, 0 },
                    },
                } 
                vim.api.nvim_input "<Esc>"
            end, mode = 'v', },
        },
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { 
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "ruff",
                "pyright",
                "clang-format",
            },
        },
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    {
        "benomahony/uv.nvim",
        opts = {
            auto_activate_venv = true,
        },
    }
}
