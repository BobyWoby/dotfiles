local wezterm = require("wezterm")
local projects = require 'projects'
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local binds = {}

-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
function binds.apply(config)
    resurrect.state_manager.periodic_save({
        interval_seconds = 15 * 60,
        save_workspaces = true,
        save_windows = true,
        save_tabs = true,
    })

    config.keys = {
        {
            key = '=',
            mods = 'ALT',
            action = wezterm.action.IncreaseFontSize,
        },
        {
            key = '-',
            mods = 'ALT',
            action = wezterm.action.DecreaseFontSize,
        },
        {
            key = 'p',
            mods = 'ALT',
            -- Present in to our project picker
            action = projects.choose_project(),
        },
        {
            key = 'f',
            mods = 'ALT',
            -- Present a list of existing workspaces
            action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
        },
        {
            key = ',',
            mods = 'ALT',
            action = wezterm.action.SpawnCommandInNewTab {
                cwd = "~/.config/",
                args = { 'nvim', wezterm.config_file },
            },
        },
        {
            key = 't',
            mods = 'ALT',
            action = wezterm.action.SpawnTab("CurrentPaneDomain")
        },
        {
            key = 'h',
            mods = 'ALT|SHIFT',
            action = wezterm.action.ActivateTabRelative(-1)
        },
        {
            key = 'l',
            mods = 'ALT|SHIFT',
            action = wezterm.action.ActivateTabRelative(1)
        },
        {
            key = '|',
            mods = 'LEADER|SHIFT',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        -- Bind ALT to swap tabs
        {
            key = '1',
            mods = 'ALT',
            action = wezterm.action.ActivateTab(0)
        },
        {
            key = '2',
            mods = 'ALT',
            action = wezterm.action.ActivateTab(1)
        },
        {
            key = '3',
            mods = 'ALT',
            action = wezterm.action.ActivateTab(2)
        },
        {
            key = '4',
            mods = 'ALT',
            action = wezterm.action.ActivateTab(3)
        },
        {
            key = '5',
            mods = 'ALT',
            action = wezterm.action.ActivateTab(4)
        },
        {
            key = '6',
            mods = 'ALT',
            action = wezterm.action.ActivateTab(5)
        },
        {
            key = '7',
            mods = 'ALT',
            action = wezterm.action.ActivateTab(6)
        },
        {
            key = '8',
            mods = 'ALT',
            action = wezterm.action.ActivateTab(7)
        },
        {
            key = '9',
            mods = 'ALT',
            action = wezterm.action.ActivateTab(-1)
        },
        {
            key = 'v',
            mods = 'ALT',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = 's',
            mods = 'ALT',
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
            key = 'w',
            mods = 'ALT',
            action = wezterm.action.CloseCurrentPane { confirm = false },
        },
        {
            key = 'h',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection("Left"),
        },
        {
            key = 'j',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection("Down"),
        },
        {
            key = 'k',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection("Up"),
        },
        {
            key = 'l',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection("Right"),
        },
        {
            key = 't',
            mods = 'ALT|SHIFT',
            action = wezterm.action.SwitchToWorkspace{
                name='testing'
            },
        },
        { key = 'n', mods = 'ALT|SHIFT', action = wezterm.action.SwitchWorkspaceRelative(1) },
        { key = 'p', mods = 'ALT|SHIFT', action = wezterm.action.SwitchWorkspaceRelative(-1) },
        {
            key = "s",
            mods = "ALT|SHIFT",
            action = wezterm.action_callback(function(win, pane)
                resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
                resurrect.window_state.save_window_action()
            end),
        },
        {
            key = "r",
            mods = "ALT",
            action = wezterm.action_callback(function(win, pane)
                resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
                    local type = string.match(id, "^([^/]+)") -- match before '/'
                    id = string.match(id, "([^/]+)$") -- match after '/'
                    id = string.match(id, "(.+)%..+$") -- remove file extention
                    local opts = {
                        close_open_tabs = true,
                        window = pane:window(),
                        spawn_in_workspace = true,
                        pane = pane,
                        relative = true,
                        restore_text = true,
                        on_pane_restore = resurrect.tab_state.default_on_pane_restore,
                    }
                    if type == "workspace" then
                        local state = resurrect.state_manager.load_state(id, "workspace")
                        resurrect.window_state.restore_window(pane:window(), state, opts)
                    elseif type == "window" then
                        local state = resurrect.state_manager.load_state(id, "window")
                        resurrect.window_state.restore_window(pane:window(), state, opts)
                    elseif type == "tab" then
                        local state = resurrect.state_manager.load_state(id, "tab")
                        resurrect.tab_state.restore_tab(pane:tab(), state, opts)
                    end
                end)
            end),
        },

    }

end

-- return our module table
return binds
