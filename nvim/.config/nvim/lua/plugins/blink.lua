return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
        keymap = {
            preset = "default",
            ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
            ["<C-k>"] = { "fallback" },
        },

        signature = {
            enabled = true,
            window = { border = "rounded" },
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = { menu = { border = "rounded" }, documentation = { auto_show = false } },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
