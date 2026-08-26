require("colors")
local colors = require("colors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "DP-1",
    mode = "2560x1440@99.95",
    position = "0x0",
    scale = "1.25",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60.00",
    position = "auto-right",
    scale = "1.25",
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.workspace_rule({ workspace = "1", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1", persistent = true })

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "alacritty"
local fileManager = "thunar"
local menu = "pkill rofi || .config/rofi/launchers/type-1/launcher.sh"

local clipboard =
    "cliphist list | rofi -dmenu -display-columns 2 -p 'Clipboard' -theme .config/rofi/launchers/type-1/style-3.rasi | cliphist decode | wl-copy"
local waybar = "killall -9 waybar || waybar &"
local da_script = "/home/cherry/.local/bin/change_wallpaper"
local llogout = "wlogout -n -P 1"
local da_ss = "bash -c \"grim -g '$(slurp)' /home/cherry/Pictures/$(date +'%Y-%m-%d_%H-%M-%S').png\""
local kanata = "/home/cherry/.local/bin/da_layout"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprctl setcursor miku_theme 32")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_THEME", "miku_theme")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 6,

        border_size = 2,

        col = {
            active_border = colors.primary,
            inactive_border = colors.outline,
        },

        resize_on_border = false,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 0,
        rounding_power = 1,

        -- Change transparency of focused and unfocused windows
        active_opacity = 0.97,
        inactive_opacity = 0.93,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },
})

hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "colemak_dh_wide",

        follow_mouse = 0,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- OPEN TERMINAL
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
-- CLOSE APP
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- KANATA INIT
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd(kanata))
-- lock session
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
-- logout
hl.bind(mainMod .. " + L",  hl.dsp.exit())
-- ROTATE WALLPAPER
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(da_script))
-- RESTART WAYBAR
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(waybar))
-- CLIPBOARD
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipboard))
-- FILE MANAGER
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
-- FULLSCREEN
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
-- Screenshot
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(da_ss))

-- MENU
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(
    mainMod .. " + XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("hyprctl hyprsunset gamma +10"),
    { repeating = true, locked = true }
)
hl.bind(
    mainMod .. " + XF86AudioLowerVolume",
    hl.dsp.exec_cmd("hyprctl hyprsunset gamma -10"),
    { repeating = true, locked = true }
)
hl.bind(
    mainMod .. " + SHIFT + XF86AudioRaiseVolume ",
    hl.dsp.exec_cmd("hyprctl hyprsunset temperature +500"),
    { repeating = true, locked = true }
)
hl.bind(
    mainMod .. " + SHIFT + XF86AudioLowerVolume",
    hl.dsp.exec_cmd("hyprctl hyprsunset temperature -500"),
    { repeating = true, locked = true }
)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move = "20 monitor_h-120",
    float = true,
})
