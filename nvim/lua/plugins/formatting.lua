vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        astro = { "prettierd", "prettier", stop_after_first = true },
        -- html = { "prettier" },
        html = { "oxfmt" },
        javascript = { "oxfmt" },
        css = { "oxfmt" },
        rust = { "rustfmt" },
        tex = { "tex-fmt" },
        latex = { "tex-fmt" },
        markdown = { "oxfmt" },
        md = { "oxfmt" },
        zsh = { "beautysh" },
        dockerfile = { "dockerfmt" },
        terraform = { "terraform" },
        tf = { "terraform" },
        yaml = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "oxfmt", "prettierd", stop_after_first = true },
        typescript = { "prettierd" },
    },
    formatters = {
        oxfmt = {
            prepend_args = { "-c", vim.fn.expand("~/.oxfmt.json"), "$FILENAME" },
        },
        stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
        },
        clang_format = {
            prepend_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never, ColumnLimit: 80}" },
        },
    },
})
