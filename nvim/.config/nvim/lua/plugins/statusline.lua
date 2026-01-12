return {
    -- "nvim-mini/mini.statusline",
    -- version = "*",
    -- config = function()
    --     require("mini.statusline").setup()
    -- end,
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup()
    end,
}
