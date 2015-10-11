
                -- [          my rc for Awesome 3.5.5         ] --
                -- [       author: Byron Mansfield            ] --
                -- [    http://github.com/byronmansfield      ] --

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
require("volume")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")

-- error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

beautiful.init(os.getenv("HOME").."/.config/awesome/theme.lua")

-- [ Variable Definitions ] --
terminal 				= "urxvt"
editor 					= "vim"
editor_cmd 			= terminal .. " -e " .. editor
modkey 					= "Mod4"
browser         = "google-chrome-unstable"
iconsmenu 			= "~/.config/awesome/icons/menu/"
exec            = awful.util.spawn
sexec           = awful.util.spawn_with_shell

-- [ Layouts ] --
local layouts =
{
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier
}

-- [ Wallpaper ] --
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- [ Tags ] --
tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag({ "    ", "    ", "    ", "    ", "    ", "    ", "    ", "    ", "    " }, s, layouts[1])
end

-- [ Menu ] --
myawesomemenu = {
	{ "Manual", terminal .. " -e man awesome" },
	{ "Edit config", editor_cmd .. " " .. awesome.conffile },
	{ "Edit rc.lua", function () sexec(editor .. "~/.config/awesome/rc.lua") end},
	{ "Edit theme.lua", function () sexec(editor ..  "~/.config/awesome/theme.lua") end },
	{ "Restart", awesome.restart },
	{ "Quit", awesome.quit }
}

mysystemmenu = {
  { "Suspend", terminal .. "sudo pm-suspend"},
  { "Hibernate", terminal .. "sudo pm-hibernate"},
  { "Lock", function () sexec("xscreensaver-command --lock") end},
  { " ", function () awful.menu.hide(instance) end, nil},
  { "Reboot", "sudo reboot"},
  { "Shutdown", "sudo shutdown -h now"}
}

mymainmenu = awful.menu({ items = {
  { "Awesome", myawesomemenu, beautiful.awesome_icon },
  { "Terminal", terminal },
  { "Chrome", function () sexec(browser) end},
  { "System", mysystemmenu }
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- [ Menubar configuration ] --
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- [ Widgets ] --
clockgf = beautiful.clockgf

spr = wibox.widget.imagebox()
spr:set_image(beautiful.spr)
spr4px = wibox.widget.imagebox()
spr4px:set_image(beautiful.spr4px)
spr5px = wibox.widget.imagebox()
spr5px:set_image(beautiful.spr5px)

widget_display = wibox.widget.imagebox()
widget_display:set_image(beautiful.widget_display)
widget_display_r = wibox.widget.imagebox()
widget_display_r:set_image(beautiful.widget_display_r)
widget_display_l = wibox.widget.imagebox()
widget_display_l:set_image(beautiful.widget_display_l)
widget_display_c = wibox.widget.imagebox()
widget_display_c:set_image(beautiful.widget_display_c)

-- [ Clock / Calendar ] --
mytextclock = awful.widget.textclock(" %I:%M", 60)
mytextcalendar = awful.widget.textclock("%a %b %d")

widget_clock = wibox.widget.imagebox()
widget_clock:set_image(beautiful.widget_clock)

clockwidget = wibox.widget.background()
clockwidget:set_widget(mytextclock)
clockwidget:set_bgimage(beautiful.widget_display)

local index = 1
local loop_widgets = { mytextclock }
local loop_widgets_icons = { beautiful.widget_clock, beautiful.widget_cal }

clockwidget:buttons(awful.util.table.join(awful.button({}, 1,
	function ()
		index = index % #loop_widgets + 1
		clockwidget:set_widget(loop_widgets[index])
		widget_clock:set_image(loop_widgets_icons[index])
	end)))

widget_cal = wibox.widget.imagebox()
widget_cal:set_image(beautiful.widget_clock)

calwidget = wibox.widget.background()
calwidget:set_widget(mytextcalendar)
calwidget:set_bgimage(beautiful.widget_display)

calwidget:buttons(awful.util.table.join(awful.button({}, 1,
	function ()
		index = index % #loop_widgets + 1
		calwidget:set_widget(loop_widgets[index])
		widget_cal:set_image(loop_widgets_icons[index])
	end)))

-- [ Wireless ] --
wirelesswidgets_icon       = wibox.widget.imagebox()
wirelesswidgets_icon:set_image(beautiful.wirelesswidgets_icon)
wirelesswidgets_icon:set_resize(false)
wirelesswidgets_icon_m = wibox.layout.margin(wirelesswidgets_icon, 5, 0, 5, 0)
wireless_dev = "eth0"
ratewidget = wibox.widget.textbox()
essidwidget = wibox.widget.textbox()
lqwidget = wibox.widget.textbox()
function update_wirelesswidgets() --{{{ returns wireless or ethernet connection info

    essid   = "Not Connected"
    bitrate = " "
    quality = "0"

    if wireless_dev ~= "" then
        local f = io.popen("iwconfig " .. wireless_dev)
        if f then
            local iwOut = f:read('*a')
            f:close()
            linkq1,linkq2 = string.match(iwOut, 'Link Quality[=:](%d+)/(%d+)')
            essid   = string.match(iwOut, '.*ESSID[=:]"(.*)" ')
            if essid then
                essidwidget:set_text(" " .. essid .. " ")
                if linkq1 then
                    quality = math.floor(100*linkq1/linkq2)
                    lqwidget:set_text(quality .."%" .. " ")
                end
                if linkq1 then
                    bitrate = string.gsub(string.match(iwOut, 'Bit Rate[=:]([%s%w%.]*%/%a+)'), "%s", "")
                    ratewidget:set_text(bitrate .. " ")
                end
            end
        end
    end
end --}}}
update_wirelesswidgets()
wirelesswidgettimer = timer({ timeout = 30 })
wirelesswidgettimer:connect_signal("timeout", update_wirelesswidgets)
wirelesswidgettimer:start()

netupwidget_icon       = wibox.widget.imagebox()
netupwidget_icon:set_image(beautiful.networkupwidget_icon)
netupwidget_icon:set_resize(false)
netupwidget_icon_m = wibox.layout.margin(netupwidget_icon, 5, 0, 5, 0)
netupwidget = wibox.widget.textbox()
netdownwidget_icon       = wibox.widget.imagebox()
netdownwidget_icon:set_image(beautiful.networkdownwidget_icon)
netdownwidget_icon:set_resize(false)
netdownwidget_icon_m = wibox.layout.margin(netdownwidget_icon, 5, 0, 5, 0)
netdownwidget = wibox.widget.textbox()
function update_netspeedwidgets()
    local curr_bytes_down = 0
    local curr_bytes_up = 0
    local net_up
    local net_down
    for line in io.lines('/proc/net/dev') do
        local device,bytes_down,bytes_up = line:match('^[%s]?[%s]?[%s]?[%s]?([%w]+):[%s]?([%d]+)[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+([%d]+)[%s]')
        if device then
            curr_bytes_down = curr_bytes_down + bytes_down
            curr_bytes_up = curr_bytes_up + bytes_up
        end
    end
    if (total_bytes_down == nil) then
        total_bytes_down = curr_bytes_down
    end
    if (total_bytes_up == nil) then
        total_bytes_up = curr_bytes_up
    end
    net_down = math.floor((((curr_bytes_down - total_bytes_down) / 1048576) * 10^2) + 0.5) / (10^2)
    net_up = math.floor((((curr_bytes_up - total_bytes_up) / 1048576) * 10^2) + 0.5) / (10^2)
    total_bytes_down = curr_bytes_down
    total_bytes_up = curr_bytes_up
    netdownwidget:set_text(" " .. net_down .. " ")
    netupwidget:set_text(" " .. net_up .. " ")
end
update_netspeedwidgets()
netspeedwidgetstimer = timer({ timeout = 3 })
netspeedwidgetstimer:connect_signal("timeout", update_netspeedwidgets)
netspeedwidgetstimer:start()


ipwidget_icon       = wibox.widget.imagebox()
ipwidget_icon:set_image(beautiful.ipwidget_icon)
ipwidget_icon:set_resize(false)
ipwidget_icon_m = wibox.layout.margin(ipwidget_icon, 5, 0, 5, 0)
ipwidget = wibox.widget.textbox()
function update_ipwidget()
    local f = io.popen("/sbin/ifconfig eth0")
    if f then
        local ifOut = f:read('*a')
        f:close()
        ip = string.match(ifOut, 'inet (.+) netmask')
        if ip then
            ipwidget:set_text(" " .. ip)
        else
            ipwidget:set_text("  " .. "no-ip")
        end
    end
end
update_ipwidget()
ipwidgettimer = timer({ timeout = 30 })
ipwidgettimer:connect_signal("timeout", update_ipwidget)
ipwidgettimer:start()


batterywidget_icon       = wibox.widget.imagebox()
batterywidget_icon:set_image(beautiful.batterywidget_icon)
batterywidget_icon:set_resize(false)
batterywidget_icon_m = wibox.layout.margin(batterywidget_icon, 5, 0, 5, 0)
batterywidget = wibox.widget.textbox()
battery="0"
function update_batterywidget() --{{{ updates batterywidget with current battery charge level
    local a = io.popen("cat /sys/class/power_supply/BAT"..battery.."/energy_full")
    if a then
        for line in a:lines() do
            full = line
        end
    end
    a:close()
    local b = io.popen("cat /sys/class/power_supply/BAT"..battery.."/energy_now")
    if b then
        for line in b:lines() do
            now = line
        end
    end
    b:close()
    if now and full then
        batterywidget:set_text(" " .. math.floor(now*100/full).."%" .. " ")
    end
end --}}}
update_batterywidget()
batterywidgettimer = timer({ timeout = 30 })
batterywidgettimer:connect_signal("timeout", update_batterywidget)
batterywidgettimer:start()

memorywidget_icon       = wibox.widget.imagebox()
memorywidget_icon:set_image(beautiful.memoryusedwidget_icon)
memorywidget_icon:set_resize(false)
memorywidget_icon_m = wibox.layout.margin(memorywidget_icon, 5, 0, 5, 0)
memorywidget = wibox.widget.textbox()
function update_memorywidget()
    local mem_free, mem_total, mem_c, mem_b
    local mem_percent, swap_percent, line, f, count
    count = 0
    f = io.open("/proc/meminfo")
    line = f:read()
    while line and count < 4 do
        if line:match("MemFree:") then
            mem_free = string.match(line, "%d+")
            count = count + 1;
        elseif line:match("MemTotal:") then
            mem_total = string.match(line, "%d+")
            count = count + 1;
        elseif line:match("Cached:") then
            mem_c = string.match(line, "%d+")
            count = count + 1;
        elseif line:match("Buffers:") then
            mem_b = string.match(line, "%d+")
            count = count + 1;
        end
        line = f:read()
    end
    io.close(f)
    memorywidget:set_text(" " .. math.floor(100 * (mem_total - mem_free - mem_b - mem_c ) / mem_total).. "%" .. " ")
end
update_memorywidget()
memorywidgettimer = timer({ timeout = 30 })
memorywidgettimer:connect_signal("timeout", update_memorywidget)
memorywidgettimer:start()

cpuloadwidget_icon       = wibox.widget.imagebox()
cpuloadwidget_icon:set_image(beautiful.cpuloadwidget_icon)
cpuloadwidget_icon:set_resize(false)
cpuloadwidget_icon_m = wibox.layout.margin(cpuloadwidget_icon, 5, 0, 5, 0)
cpuloadwidget = wibox.widget.textbox()
cpuspeedwidget = wibox.widget.textbox()
function update_cpuloadwidget()
    if cpu0_total == null then
        cpu0_total  = 0
        cpu0_active = 0
    end
    local f = io.open('/proc/stat')
    for l in f:lines() do
        values = {}
        start = 1
        splitstart, splitend = string.find(l, ' ', start)
        while splitstart do
            m = string.sub(l, start, splitstart-1)
            if m:gsub(' ','') ~= '' then
                table.insert(values, m)
            end
            start = splitend+1
            splitstart, splitend = string.find(l, ' ', start)
        end
        m = string.sub(l, start)
        if m:gsub(' ','') ~= '' then
            table.insert(values, m)
        end
        cpu_usage = values
        if cpu_usage[1] == "cpu0" then
            total_new     = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]+cpu_usage[5]
            active_new    = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]
            diff_total    = total_new-cpu0_total
            diff_active   = active_new-cpu0_active
            usage_percent = math.floor(diff_active/diff_total*100)
            cpu0_total    = total_new
            cpu0_active   = active_new
            cpuloadwidget:set_text(" " .. usage_percent .. "% /")
        end
    end
    f:close()
end
function update_cpuspeedwidget() --{{{ returns current cpu frequency
    local f = io.open("/proc/cpuinfo")
    local line = f:read()
    while line do
        if line:match("cpu MHz") then
            ghz = math.floor(((string.match(line, "%d+") / 1000) * 10^1) + 0.5) / (10^1)
        end
        line = f:read()
    end
    io.close(f)
    cpuspeedwidget:set_text(" " .. ghz .. "Ghz" .. " ")
end --}}}

update_cpuspeedwidget()
update_cpuloadwidget()
cpuloadwidgettimer = timer({ timeout = 3 })
cpuloadwidgettimer:connect_signal("timeout", update_cpuloadwidget)
cpuloadwidgettimer:start()
cpuspeedwidgettimer = timer({ timeout = 3 })
cpuspeedwidgettimer:connect_signal("timeout", update_cpuspeedwidget)
cpuspeedwidgettimer:start()

datewidget_icon       = wibox.widget.imagebox()
datewidget_icon:set_image(beautiful.datewidget_icon)
datewidget_icon:set_resize(false)
datewidget_icon_m = wibox.layout.margin(datewidget_icon, 5, 0, 5, 0)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "22" })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(wirelesswidgets_icon_m)
    right_layout:add(essidwidget)
    right_layout:add(lqwidget)
    right_layout:add(ratewidget)
    right_layout:add(netupwidget_icon_m)
    right_layout:add(netupwidget)
    right_layout:add(netdownwidget_icon_m)
    right_layout:add(netdownwidget)
    right_layout:add(ipwidget_icon_m)
    right_layout:add(ipwidget)
    right_layout:add(memorywidget_icon_m)
    right_layout:add(memorywidget)
    right_layout:add(cpuloadwidget_icon_m)
    right_layout:add(cpuloadwidget)
    right_layout:add(cpuspeedwidget)
    right_layout:add(batterywidget_icon_m)
    right_layout:add(batterywidget)
    right_layout:add(datewidget_icon_m)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(volume_widget)

		right_layout:add(spr)

		right_layout:add(widget_cal)
    right_layout:add(widget_display_l)
    right_layout:add(calwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)
 
		right_layout:add(spr)

		right_layout:add(widget_clock)
    right_layout:add(widget_display_l)
    right_layout:add(clockwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)
    
		right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_bg(beautiful.panel)
    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Lock
    awful.key({ modkey, "Shift"    }, "l", function () awful.util.spawn_with_shell("xscreensaver-command -lock") end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    -- Caputre Screen Area
    awful.key({ modkey, "Control" }, "p", function() awful.util.spawn("sh bin/capscr.sh") end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),
    awful.key({ }, "XF86AudioRaiseVolume", function ()
      awful.util.spawn("amixer set Master 9%+") end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
      awful.util.spawn("amixer set Master 9%-") end),
    awful.key({ }, "XF86AudioMute", function ()
      awful.util.spawn("amixer sset Master toggle") end)

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    -- awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
		-- switch focused client a screen to the left
		awful.key({ modkey,           }, "o",      function(c) awful.client.movetoscreen(c,c.screen-1) end                        ),
		-- switch focused client a screen to the right
		awful.key({ modkey,           }, "i",      function(c) awful.client.movetoscreen(c,c.screen+1) end                        ),
		-- switch focused monitor to the left most one
		awful.key({ modkey,           }, "F1",      function(c) awful.screen.focus(2) end                        ),
		-- switch focused monitor to the center
		awful.key({ modkey,           }, "F2",      function(c) awful.screen.focus(1) end                        ),
		-- switch focused monitor to the right most one
		awful.key({ modkey,           }, "F3",      function(c) awful.screen.focus(3) end                        ),


    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
