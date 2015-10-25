

                -- [        my theme for Awesome 3.5.5        ] --
                -- [       author: Byron Mansfield            ] --
                -- [    http://github.com/byronmansfield      ] --

local awful = require("awful")
awful.util = require("awful.util")

theme = {}

home            = os.getenv("HOME")
config          = awful.util.getdir("config")
shared          = "/usr/share/awesome"
if not awful.util.file_readable(shared .. "/icons/awesome16.png") then
  shared      = "/usr/share/local/awesome"
end
sharedicons     = shared .. "/icons"
sharedthemes    = shared .. "/themes"
themedir        = config

menu            = config .. "/icons/menu/"
icons           = config .. "/icons/newblue/"
layoutstyle     = "layout-huge-fill/"

nvidia          = config .. "/nvidia.jpg"
keyboard        = config .. "/keyboard_girl.jpg"

theme.wallpaper = keyboard

theme.font      = "sans 8"

theme.panel     = "png:" .. menu .. "/panel.png"

-- [ Menu ] --

theme.menu_height = 16
theme.menu_width  = 160

-- colors
theme.fg_normal   = "#ffffff"
theme.fg_focus    = "#000000"
theme.fg_urgent   = "#0a0a0b"
theme.fg_title    = "#66d9ef"
theme.fg_disable  = "#0a0a0b"

theme.bg_normal   = "#0a0a0b"
theme.bg_focus    = "#1692d0"
theme.bg_urgent   = "#f92671"
theme.bg_disable  = "#5e7175"
theme.bg_hover    = "#5e7175"

theme.clockgf   	= "#d5d5c3"

-- borders
theme.border_width  = "1"
theme.border_focus  = "#ffffff"
theme.border_normal = "#426797"
theme.border_marked = "#426797"

-- titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"

theme.mouse_finder_color = "#CC9393"

------------- [ Icons ] -------------

-- [ Taglist ] --
theme.taglist_bg_empty    = "png:" .. menu .. "/empty.png"
theme.taglist_bg_occupied = "png:" .. menu .. "/occupied.png"
theme.taglist_bg_urgent   = "png:" .. menu .. "/urgent.png"
theme.taglist_bg_focus    = "png:" .. menu .. "/focus.png"

-- [ Tasklist ] --
theme.tasklist_disable_icon = true
theme.tasklist_bg_normal    = "png:" .. menu .. "/tasklist/normal.png"
theme.tasklist_bg_focus     = "png:" .. menu .. "/tasklist/focus.png"
theme.tasklist_bg_urgent    = "png:" .. menu .. "/tasklist/urgent.png"
theme.tasklist_fg_focus     = "#DDDDDD"
theme.tasklist_fg_urgent    = "#EEEEEE"
theme.tasklist_fg_normal    = "#AAAAAA"

-- [ Widget ] --
theme.widget_display   = menu .. "/widgets/widget_display.png"
theme.widget_display_r = menu .. "/widgets/widget_display_r.png"
theme.widget_display_c = menu .. "/widgets/widget_display_c.png"
theme.widget_display_l = menu .. "/widgets/widget_display_l.png"

-- [ Seperators ] --
theme.spr    = menu .. "/separators/spr.png"
theme.sprtr  = menu .. "/separators/sprtr.png"
theme.spr4px = menu .. "/separators/spr4px.png"
theme.spr5px = menu .. "/separators/spr5px.png"

-- [ Volume ] --
theme.widget_volume = menu .. "/widgets/widget_speaker.png"

-- [ RAM ] --
theme.widget_ram = menu .. "/widgets/widget_ram.png"

-- [ CPU ] --
theme.widget_cpu = menu .. "/widgets/widget_cpu.png"

-- [ Uptime ] --
theme.widget_uptime = menu .. "/widgets/uptime.png"

-- [ Clock / Calendar ] --
theme.widget_clock = menu .. "/widgets/widget_clock.png"
theme.widget_cal   = menu .. "/widgets/widget_cal.png"

-- [ Net Up / Down ] --
theme.netup     = menu .. "/widgets/widget_netul.png"
theme.netdown   = menu .. "/widgets/widget_netdl.png"

-- [ misc ] --
theme.awesome_icon            = icons .. "arch-blue.png"
theme.menu_submenu_icon       = sharedthemes .. "/default/submenu.png"
theme.tasklist_floating_icon  = sharedthemes .. "/default/tasklist/floatingw.png"

-- [ Layouts ] --
theme.layout_tile               = menu .. layoutstyle .. "tile.png"
theme.layout_tileleft           = menu .. layoutstyle .. "tileleft.png"
theme.layout_tilebottom         = menu .. layoutstyle .. "tilebottom.png"
theme.layout_tiletop            = menu .. layoutstyle .. "tiletop.png"
theme.layout_fairv              = menu .. layoutstyle .. "fairv.png"
theme.layout_fairh              = menu .. layoutstyle .. "fairh.png"
theme.layout_spiral             = menu .. layoutstyle .. "spiral.png"
theme.layout_dwindle            = menu .. layoutstyle .. "dwindle.png"
theme.layout_max                = menu .. layoutstyle .. "max.png"
theme.layout_fullscreen         = menu .. layoutstyle .. "fullscreen.png"
theme.layout_magnifier          = menu .. layoutstyle .. "magnifier.png"
theme.layout_floating           = menu .. layoutstyle .. "floating.png"

-- [ Titlebar ] --
theme.titlebar_close_button_focus  = sharedthemes .. "/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = sharedthemes .. "/zenburn/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = sharedthemes .. "/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = sharedthemes .. "/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = sharedthemes .. "/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = sharedthemes .. "/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = sharedthemes .. "/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = sharedthemes .. "/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = sharedthemes .. "/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = sharedthemes .. "/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/maximized_normal_inactive.png"

return theme
