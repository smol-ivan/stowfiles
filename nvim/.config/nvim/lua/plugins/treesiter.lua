return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)

        -- Make sure that the following are installed:
        require("nvim-treesitter").install({
            "bash",
            "c",
            "cpp",
            "fish",
            "gitcommit",
            "go",
            "graphql",
            "html",
            "hyprlang",
            "java",
            "javascript",
            "json",
            "json5",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "rasi",
            "regex",
            "rust",
            "scss",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        })
    end,
}
