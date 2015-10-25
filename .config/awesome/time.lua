-- [ Time / Date Widget ] --

-- dependencies
local wibox = require("wibox")
local awful = require("awful")
require("theme")
local beautiful = require("beautiful")

beautiful.init(os.getenv("HOME").."/.config/awesome/theme.lua")

mytextclock       = awful.widget.textclock(" %I:%M", 60)
mytextcalendar    = awful.widget.textclock("%a %b %d")

widget_clock      = wibox.widget.imagebox()
widget_clock:set_image(beautiful.widget_clock)

clockwidget       = wibox.widget.background()
clockwidget:set_widget(mytextclock)
clockwidget:set_bgimage(beautiful.widget_display)

widget_cal = wibox.widget.imagebox()
widget_cal:set_image(beautiful.widget_cal)

calwidget = wibox.widget.background()
calwidget:set_widget(mytextcalendar)
calwidget:set_bgimage(beautiful.widget_display)

