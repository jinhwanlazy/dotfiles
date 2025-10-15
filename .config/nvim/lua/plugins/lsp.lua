function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        lazy = true, 
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                "clangd",
                "clang-format",
                "ruff",
                "rust-analyzer",
                "lua-language-server",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 8,
                    source = "if_many",
                    prefix = "●",
                    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                    --prefix = "icons",
                },
                severity_sort = true,
            },
            inlay_hints = { enabled = false, },
            servers = {
                clangd = {},
                jsonls = {},
                lua_ls = {},
            },
        },
        config = function(_, opts)
            require("mason").setup()
            vim.lsp.config("clangd", {})
            vim.lsp.config("ruff", {})
            vim.lsp.config("terraformls", {})
            vim.lsp.config("pyright", {})
            vim.lsp.config("svelte", {})
            vim.lsp.config("ts_ls", {})
            vim.lsp.config("tailwindcss", {})
        end,
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
        "benomahony/uv.nvim",
        opts = {
            auto_activate_venv = true,
        },
    }
}
