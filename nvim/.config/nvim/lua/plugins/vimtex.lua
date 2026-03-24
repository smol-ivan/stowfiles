return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
        -- 1. Forzar el uso de latexmk con un solo motor
        vim.g.vimtex_compiler_method = "latexmk"

        -- 2. Configuración simplificada (Evita que se dupliquen argumentos)
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

        -- 3. IMPORTANTE: Dile a VimTeX que no intente adivinar el nombre del archivo
        -- Esto evita el error de "3 filenames specified"
        vim.g.vimtex_compiler_latexmk_engines = {
            _ = "-pdf",
        }
        vim.g.vimtex_view_method = "zathura"
    end,
}
