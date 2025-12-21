return {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
        require("themery").setup({
            themes = { "gruber-darker", "oxocarbon", "gruvbox", "rose-pine" },
            livePreview = true,
        })
    end,
}
