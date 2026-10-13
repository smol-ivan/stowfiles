vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
})

local parsers = {
    "astro",
    "bash",
    "c",
    "cpp",
    "css",
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
    "terraform",
    "dockerfile",
}

-- Main-branch nvim-treesitter ships queries under `runtime/queries/`,
-- which isn't on rtp by default. Prepend it so highlights/folds/indents
-- are visible to `vim.treesitter.start`.
local ts_init = vim.api.nvim_get_runtime_file("lua/nvim-treesitter/init.lua", false)[1]
if ts_init then
    vim.opt.runtimepath:prepend(vim.fn.fnamemodify(ts_init, ":h:h:h") .. "/runtime")
end

require("nvim-treesitter").install(parsers):wait(300000)

require("treesitter-context").setup({
    max_lines = 3,
    multiline_threshold = 1,
    min_window_height = 20,
})

vim.keymap.set("n", "[c", function()
    if vim.wo.diff then
        return "[c"
    else
        vim.schedule(function()
            require("treesitter-context").go_to_context()
        end)
        return "<Ignore>"
    end
end, { desc = "Jump to upper context", expr = true })
