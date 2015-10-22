-- [ RAM Widget ] --

-- dependencies
local wibox = require("wibox")
local awful = require("awful")
require("theme")
local beautiful = require("beautiful")

config          = awful.util.getdir("config")
menu            = config .. "/icons/menu/"
widget_display   = menu .. "/widgets/widget_display.png"
 
memorywidget            = wibox.widget.textbox()
memorywidget_icon       = wibox.widget.imagebox()
memorywidget_icon_m     = wibox.layout.margin(memorywidget_icon, 5, 0, 5, 0)
memorywidget_icon:set_image(beautiful.memoryusedwidget_icon)
memorywidget_icon:set_resize(false)

ramwidget               = wibox.widget.background()
ramwidget:set_bgimage(widget_display)

-- [Updates memory widget] --
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
  memorywidget:set_text(" RAM: " .. math.floor(100 * (mem_total - mem_free - mem_b - mem_c ) / mem_total).. "%" .. " ")
end

update_memorywidget()
memorywidgettimer = timer({ timeout = 30 })
memorywidgettimer:connect_signal("timeout", update_memorywidget)
memorywidgettimer:start()

ramwidget:set_widget(memorywidget)

