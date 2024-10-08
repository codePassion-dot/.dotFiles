# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import psutil
import os
import subprocess

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy
from themes.tokyonight import colors


mod = "mod4"
terminal = "kitty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Warp focus to screen n
    Key([mod], "comma", lazy.to_screen(0), desc="Keyboard focus to monitor 1"),
    Key([mod], "period", lazy.to_screen(1), desc="Keyboard focus to monitor 2"),
    Key(
        [mod, "shift"],
        "period",
        lazy.window.toscreen(1),
        desc="Keyboard focus to monitor 2",
    ),
    Key(
        [mod, "shift"],
        "comma",
        lazy.window.toscreen(0),
        lazy.to_screen(0),
        desc="Keyboard focus to monitor 1",
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "escape", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod, "shift"], "escape", lazy.group["scratchpad"].dropdown_toggle("updates")),
]

groups = [Group(i) for i in "123456789"]


for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

options = {
    "x": 0.15,
    "y": 0.20,
    "width": 0.7,
    "height": 0.6,
    "opacity": 1.0,
    "on_focus_lost_hide": False,
}

groups.append(
    ScratchPad(
        "scratchpad",
        [
            # kitty term
            DropDown("term", "kitty", **options),
            DropDown(
                "updates",
                "kitty --hold sh -c '/home/jacobo/.local/bin/update_packages'",
                **options,
            ),
        ],
    )
)

colors = colors["night"]

layout_theme = {
    "border_width": 2,
    "margin": 10,
    "border_focus": colors["magenta"],
    "border_normal": colors["black"],
}

layouts = [
    layout.Columns(**layout_theme, border_focus_stack=colors["red"]),
    layout.Max(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


def is_laptop():
    try:
        # Check if there is any battery present on the system
        battery = psutil.sensors_battery()
        if battery is not None:
            return True
        else:
            return False
    except Exception as e:
        return f"Error: {str(e)}"


def get_cpu_sensor_label():
    try:
        sensors = psutil.sensors_temperatures()
        cpu_sensors = sensors.get("coretemp", []) or sensors.get("k10temp", [])
        if len(cpu_sensors) > 0:
            return cpu_sensors[0].label
        else:
            return "No label"
    except Exception as e:
        return f"Error: {str(e)}"


def get_interface(type):
    try:
        interfaces = psutil.net_if_addrs()
        ethernet_interfaces = [
            x for x in interfaces if x.startswith(type == "wired" and "en" or "wlp")
        ]
        if len(ethernet_interfaces) == 0:
            return "No interface"
        return ethernet_interfaces[0]
    except Exception as e:
        return f"Error: {str(e)}"


widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


common_widgets = {
    "groups": widget.GroupBox(
        active=colors["magenta"],  # not current active font color
        inactive=colors["fg"],
        borderwidth=1,
        rounded=False,
        disable_drag=True,
        highlight_color=colors["red"],
        this_current_screen_border=colors[
            "magenta"
        ],  # current active font color - MAIN
        this_screen_border=colors["magenta"],
        other_current_screen_border=colors["bg"],
        other_screen_border=colors["bg"],
        urgent_border=colors["red"],
        urgent_text=colors["red"],
        # foreground = colors["fg"],
        # background = colors["red"],
        # hide_unused=True,
    ),
    "key_chord": widget.Chord(
        chords_colors={
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),
    "clock": widget.Clock(format="%R - %d-%m"),
    "spacer": widget.Spacer(length=bar.STRETCH),
    "current_layout_icon": widget.CurrentLayoutIcon(
        padding=0,
        scale=0.7,
    ),
    "current_layout_name": widget.CurrentLayout(),
}


screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.CurrentLayout(),
                common_widgets["groups"],
                widget.Prompt(),
                common_widgets["current_layout_icon"],
                common_widgets["current_layout_name"],
                # widget.WindowName(),
                common_widgets["spacer"],
                common_widgets["key_chord"],
                # widget.TextBox("this is not default       ", name="default"),
                # widget.Sep(),
                widget.CheckUpdates(
                    distro="Debian",
                    update_interval=1800,
                    display_format="Updates: {updates}",
                    foreground=colors["blue"],
                    background=colors["bg"],
                    no_update_string="No updates",
                    colour_have_updates=colors["red"],
                    colour_no_updates=colors["blue"],
                    mouse_callbacks={
                        "Button1": lazy.group["scratchpad"].dropdown_toggle("updates"),
                    },
                ),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.TextBox(
                #    text="",
                #    foreground = colors["red"],
                #    ),
                widget.Wttr(
                    location={"5.0810923,-75.6995723": "Farm"}, format="%C, %t"
                ),
                # widget.TextBox(
                #    text='',
                #    foreground = colors["red"],
                #    ),
                # widget.Sep(),
                widget.TextBox(
                    text="",
                    foreground=colors["red"],
                ),
                widget.Net(
                    use_bits=True,
                    prefix="M",
                    format="↓ {down} ↑ {up}",
                    interface=is_laptop()
                    and get_interface("wifi")
                    or get_interface("wired"),
                ),
                # widget.TextBox(
                #    text='',
                #    foreground = colors["red"],
                #    ),
                # widget.Sep(),
                widget.TextBox(
                    text="",
                    foreground=colors["red"],
                ),
                widget.CPU(format="  {load_percent}%"),
                # widget.TextBox(
                #    text='',
                #    foreground = colors["red"],
                #    ),
                widget.TextBox(
                    text="",
                    foreground=colors["red"],
                ),
                # widget.Sep(),
                widget.ThermalSensor(
                    format=" {temp:.0f}{unit}",
                    tag_sensor=get_cpu_sensor_label(),
                    threshold=60,
                    foreground_alert=colors["red"],
                    foreground=colors["fg"],
                ),
                # widget.Sep(),
                # widget.TextBox(
                #    text='',
                #    foreground = colors["red"],
                #    ),
                widget.TextBox(
                    text="",
                    foreground=colors["red"],
                ),
                widget.Memory(
                    format="RAM:{MemUsed: .0f}{mm}",
                    measure_mem="G",
                    update_interval=5,
                ),
                widget.TextBox(
                    # text='',
                    text="",
                    foreground=colors["red"],
                ),
                (is_laptop() and widget.Battery(format="{percent: 2.0%}"))
                or widget.TextBox(""),
                (is_laptop() and widget.BatteryIcon()) or widget.TextBox(""),
                (
                    is_laptop()
                    and widget.TextBox(
                        text="",
                        foreground=colors["red"],
                    )
                )
                or widget.TextBox(""),
                (is_laptop() and widget.Systray()) or widget.TextBox(""),
                (
                    is_laptop()
                    and widget.TextBox(
                        text="",
                        foreground=colors["red"],
                    )
                )
                or widget.TextBox(""),
                # widget.Sep(),
                common_widgets["clock"],
                # widget.QuickExit(),
            ],
            25,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            margin=[
                3,
                10,
                0,
                10,
            ],  # Draw top and bottom borders   [ top, right, bottom, left ]
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
    Screen(
        top=bar.Bar(
            [
                common_widgets["groups"],
                common_widgets["current_layout_icon"],
                common_widgets["current_layout_name"],
                common_widgets["spacer"],
                common_widgets["key_chord"],
                widget.Systray(),
                common_widgets["clock"],
                widget.QuickExit(),
            ],
            25,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            margin=[
                3,
                10,
                0,
                10,
            ],  # Draw top and bottom borders   [ top, right, bottom, left ]
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([home])


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
