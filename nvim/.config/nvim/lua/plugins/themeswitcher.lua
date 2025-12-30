return {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
        require("themery").setup({
            themes = {
                "gruber-darker",
                "oxocarbon",
                "gruvbox",
                "rose-pine",
                "kanagawa-wave",
                "kanagawa-dragon",
                "nightfox",
                "duskfox",
                "carbonfox",
                "evergarden-winter",
                "evergarden-fall",
                "evergarden-spring",
                "tokyonight-night",
                "tokyonight-moon",
                "tokyonight-storm",
                "moonfly",
                "bamboo",
                "catppuccin-mocha",
            },
            livePreview = true,
        })
    end,
}
