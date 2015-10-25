-- [ CPU Widget ] --

-- dependencies
local wibox = require("wibox")
local awful = require("awful")
local vicious = require("vicious")
require("theme")
local beautiful = require("beautiful")

beautiful.init(os.getenv("HOME").."/.config/awesome/theme.lua")

cpuloadwidget_icon        = wibox.widget.imagebox()
cpuloadwidget             = wibox.widget.textbox()
cpuspeedwidget            = wibox.widget.textbox()
cpuwidget                 = wibox.widget.background()
cputempwidget             = wibox.widget.background()

cpuloadwidget_icon:set_image(beautiful.cpuloadwidget_icon)
cpuloadwidget_icon:set_resize(false)
cpuloadwidget_icon_m      = wibox.layout.margin(cpuloadwidget_icon, 5, 0, 5, 0)
cpuwidget:set_bgimage(beautiful.widget_display)
cputempwidget:set_bgimage(beautiful.widget_display)

widget_cpu = wibox.widget.imagebox()
widget_cpu:set_image(beautiful.widget_cpu)

-- Update CPU load
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
      cpuloadwidget:set_text(usage_percent .. "% ")
    end
  end
  f:close()
end

-- Updates CPU speed
function update_cpuspeedwidget()
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
end

update_cpuspeedwidget()
update_cpuloadwidget()

cpuloadwidgettimer = timer({ timeout = 3 })
cpuloadwidgettimer:connect_signal("timeout", update_cpuloadwidget)
cpuloadwidgettimer:start()

cpuspeedwidgettimer = timer({ timeout = 3 })
cpuspeedwidgettimer:connect_signal("timeout", update_cpuspeedwidget)
cpuspeedwidgettimer:start()

cpuwidget:set_widget(cpuloadwidget)

cputemp = wibox.widget.textbox()
vicious.register(cputemp, vicious.widgets.thermal,
  function (widget, args) 
    return args[1] * 9 / 5 + 32 .. "°F"
  end,37,"thermal_zone0")

cputempwidget:set_widget(cputemp)

