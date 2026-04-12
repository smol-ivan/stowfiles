return {
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        -- branch = "master",
        build = ":TSUpdate",
        -- main = "nvim-treesitter.configs", -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "vim",
                "vimdoc",
                "go",
                "rust",
                "python",
                "toml",
                "latex",
                "typescript",
                "css",
                "astro",
            },
            auto_install = true,
        },
    },
}
