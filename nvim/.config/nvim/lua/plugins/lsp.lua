return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        { "j-hui/fidget.nvim", opts = {} },

        "saghen/blink.cmp",
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("chattini", { clear = true }),
            callback = function(event)
                local map_lsp = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end
                map_lsp("<leader>gn", vim.lsp.buf.rename, "[R]e[n]ame")

                map_lsp("<leader>ga", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

                map_lsp("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                map_lsp("<leader>gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                map_lsp("<leader>gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                map_lsp("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                map_lsp("<leader>gs", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

                map_lsp(
                    "<leader>gS",
                    require("telescope.builtin").lsp_dynamic_workspace_symbols,
                    "Open Workspace Symbols"
                )

                map_lsp("<leader>gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has("nvim-0.11") == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client_supports_method(
                        client,
                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                        event.buf
                    )
                then
                    local highlight_augroup = vim.api.nvim_create_augroup("chattini-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("chattini-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "chattini-highlight", buffer = event2.buf })
                        end,
                    })
                end

                if
                    client
                    and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                then
                    map_lsp("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })
        vim.diagnostic.config({
            severity_sort = true,
            float = { source = "if_many" },
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = false,
            virtual_text = {
                source = "if_many",
                spacing = 2,
                format = function(diagnostic)
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return diagnostic_message[diagnostic.severity]
                end,
            },
        })

        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local servers = {
            clangd = {},
            gopls = {},
            -- pyright = {
            --     disableOrganizeImports = true,
            --     settings = {
            --         python = {
            --             analysis = {
            --                 ignore = { "*" },
            --             },
            --         },
            --     },
            -- },

            rust_analyzer = {},
            basedpyright = {
                settings = {
                    basedpyright = {
                        disableOrganizeImports = true,
                        analysis = {
                            ignore = { "*" },
                            typeCheckingMode = "off",
                            diagnosticMode = "openFilesOnly",
                            -- useLibraryCodeForTypes = true,
                            autoSearchPaths = true,
                        },
                    },
                },
            },
            bashls = {
                filetypes = { "bash", "sh", "zsh" },
            },
            ruff = {
                init_options = {
                    settings = {
                        lint = {
                            enable = false,
                        },
                    },
                },
            },
            texlab = {},
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "clangd",
            "clang-format",
            -- "pyright",
            "lua_ls",
            "stylua",
            "basedpyright",
            "rust_analyzer",
            "ruff",
            "shfmt",
            "bashls",
            "beautysh",
            "texlab",
            "tex-fmt",
            "astro",
            -- "prettier",
            "tailwindcss",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    server.handlers = vim.tbl_deep_extend("force", {
                        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover),
                        ["textDocument/signatureHelp"] = vim.lsp.with(
                            vim.lsp.handlers.signature_help,
                            { border = "rounded" }
                        ),
                    }, server.handlers or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })
    end,
}
