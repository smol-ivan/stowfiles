vim.pack.add({
    { src = "https://github.com/lervag/vimtex" },
})

vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
    options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
    },
}
vim.g.vimtex_compiler_latexmk_engines = {
    _ = "-pdf",
}
vim.g.vimtex_view_method = "zathura"
-- vim.g.vimtex_view_method = "skim"
