return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    opts = {
        -- notify_on_error = false,
        log_level = vim.log.levels.DEBUG,
        format_on_save = function(bufnr)
            return {
                timeout_ms = 500,
                lsp_format = "fallback",
            }
        end,
        formatters_by_ft = {
            lua = { "stylua" },
            python = {
                "ruff_fix",
                "ruff_format",
                "ruff_organize_imports",
            },
            c = { "clang_format" },
            cpp = { "clang_format" },
            zsh = { "beautysh" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            latex = { "tex-fmt" },
            tex = { "tex-fmt" },
            astro = { "prettier" },
        },
        formatters = {
            prettier = {},
            tex_fmt = {},
            beautysh = {},
            shfmt = {},
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
            ruff = {},
            clang_format = {
                -- prepend_args = { "-style={BasedOnStyle: Linux, IndentWidth: 4, UseTab: Never, ColumnLimit:80}" },
                prepend_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never, ColumnLimit: 80}" },
            },
        },
    },
}
