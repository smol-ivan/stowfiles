-- lua/plugins/init.lua
-- Cargador principal y orquestador de plugins con vim.pack

local ordered_modules = {
    "plugins.themes",
    "plugins.completion",
    "plugins.lsp",
    "plugins.treesitter",
    "plugins.formatting",
    "plugins.telescope",
    "plugins.oil",
    "plugins.mini",
    "plugins.lualine",
    "plugins.trouble",
    "plugins.gitsigns",
    "plugins.toggleterm",
    "plugins.neotab",
    "plugins.vimtex",
}

local loaded = {}

-- 1. Cargar módulos en orden para respetar dependencias (ej. completion antes de lsp)
for _, mod in ipairs(ordered_modules) do
    local ok, err = pcall(require, mod)
    if not ok then
        vim.notify("Error al cargar " .. mod .. ":\n" .. tostring(err), vim.log.levels.ERROR)
    end
    loaded[mod] = true
end

-- 2. Auto-descubrimiento: carga automáticamente cualquier nuevo plugin .lua en lua/plugins/
local config_dir = vim.fn.stdpath("config")
local plugins_dir = config_dir .. "/lua/plugins"

if vim.fn.isdirectory(plugins_dir) == 1 then
    for _, file in ipairs(vim.fn.readdir(plugins_dir)) do
        if file:sub(-4) == ".lua" and file ~= "init.lua" then
            local mod_name = "plugins." .. file:sub(1, -5)
            if not loaded[mod_name] then
                local ok, err = pcall(require, mod_name)
                if not ok then
                    vim.notify("Error al cargar " .. mod_name .. ":\n" .. tostring(err), vim.log.levels.ERROR)
                end
                loaded[mod_name] = true
            end
        end
    end
end
