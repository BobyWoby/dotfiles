-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local binds = require 'binds'
local restore = require 'restore'
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 18
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.color_scheme = 'Batman'
config.adjust_window_size_when_changing_font_size = false


-- Finally, return the configuration to wezterm:
config.enable_wayland = false

resurrect.state_manager.periodic_save({
    interval_seconds = 1 * 60,
    save_workspaces = true,
    save_windows = true,
    save_tabs = true,
})

wezterm.on('gui-startup', function(cmd)
    -- allow `wezterm start -- something` to affect what we spawn
    -- in our initial window
    local args = {"nvim", "." }
    if cmd then
        args = cmd.args
    end

    -- Set a workspace for coding on a current project
    -- Top pane is for the editor, bottom pane is for the build tool
    local project_dir = wezterm.home_dir .. '/dev/'
    local tab, build_pane, window = mux.spawn_window {
        workspace = 'testing',
        cwd = project_dir,
        args = {},
    }
    local editor_pane = build_pane:split{
        direction = 'Left',
        size = 0.5,
        cwd = project_dir,
    }
    -- local editor_pane = build_pane:split {
        --   direction = 'Bottom',
        --   size = 0.6,
        --   cwd = project_dir,
        -- }
        -- may as well kick off a build in that pane
        -- build_pane:send_text 'cargo build\n'

        -- A workspace for interacting with a local machine that
        -- runs some docker containers for home automation
        -- local tab, pane, window = mux.spawn_window {
        --     workspace = 'automation',
        --     args = { 'ssh', 'vault' },
        -- }
        --
        -- We want to startup in the coding workspace
        mux.set_active_workspace 'testing'
    end)
    wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)




    -- timeout_milliseconds defaults to 1000 and can be omitted
    config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
    restore.apply(config)
    binds.apply(config)
    local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
    workspace_switcher.apply_to_config({})

    wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
        window:gui_window():set_right_status(wezterm.format({
            { Attribute = { Intensity = "Bold" } },
            { Foreground = { Color = colors.colors.ansi[5] } },
            { Text = basename(path) .. "  " },
        }))
        local workspace_state = resurrect.workspace_state

        workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
            window = window,
            relative = true,
            restore_text = true,

            resize_window = false,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        })
    end)
    return config

