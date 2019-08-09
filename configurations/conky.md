# Conky 

## Config

```text tangle:~/.config/conky/conky.conf
conky.config = {
  alignment = 'top_right',
  background = false,
  draw_shades = false,
  use_xft = true,
  font = 'DejaVu Sans Mono:size=12',
  gap_x = 30,
  minimum_width = 500,
  own_window = true,
  own_window_type = 'override',
  own_window_argb_visual = true,
  own_window_transparent = true,
  update_interval = 5,
  color0 = "#dadcdb",
  color1 = "grey",
  color2 = "#828282",
  color3 = "#ce8907",
  color4 = "#00ff00",
  color5 = "#ce8907"
}

conky.text = [[
${font sans-serif:bold:size=21}${color0}${time %d.%m.%y}, ${time %H:%M} ${hr 7}${font}

${font sans-serif:bold:size=11}${color0}SYSTEM ${hr 4}${font}
${color1}  System:${color2}       ${sysname} ${kernel} ${machine}
${color1}  Uptime:${color2}       ${uptime}
${if_match "charging" >= "${exec upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state:' | cut -b26-}"}\
${color1}  Battery:${color4}      ${battery_percent}% (charging)
${else}\
${if_match ${battery_percent}<20}\
${color1}  Battery:${color5}      ${battery_percent}%
${else}\
${color1}  Battery:${color2}      ${battery_percent}%
${endif}\
${endif}\
${color1}  Disk usage:${color2}   ${fs_used_perc}% of ${fs_size}
${color1}  Wireless:${color2}     ${wireless_essid}

${font sans-serif:bold:size=11}${color0}MONITORING ${hr 4}${font}
${color1}  RAM Usage:${color2}    ${memperc}% of ${memmax}
${color1}  Disk I/O:${color2}     ${diskio /dev/sda}
${color1}  CPU Usage:${color2}    ${cpu}% ${cpubar 10,150}
${color1}  Frequency:${color2}    ${freq} MHz (${freq_g} GHz)
${color1}  Temperature:${color2}  ${acpitemp}°C
${color1}  Processes:${color2}    ${processes} (active: ${running_processes})

${color1}  Name          $alignr PID   CPU%   MEM%   
${color2}  ${top name 1} $alignr ${top pid 1} ${top cpu 1} ${top mem 1}   
${color2}  ${top name 2} $alignr ${top pid 2} ${top cpu 2} ${top mem 2}   
${color2}  ${top name 3} $alignr ${top pid 3} ${top cpu 3} ${top mem 3}   
${color2}  ${top name 4} $alignr ${top pid 4} ${top cpu 4} ${top mem 4}   
${color2}  ${top name 5} $alignr ${top pid 5} ${top cpu 5} ${top mem 5}   

${font sans-serif:bold:size=11}${color0}PROCESSORS ${hr 4}${font}
${color1}  1:  ${color2}${cpu cpu1}%$alignr ${cpubar cpu1 6,360}   
${color1}  2:  ${color2}${cpu cpu2}%$alignr ${cpubar cpu2 6,360}   
${color1}  3:  ${color2}${cpu cpu3}%$alignr ${cpubar cpu3 6,360}   
${color1}  4:  ${color2}${cpu cpu4}%$alignr ${cpubar cpu4 6,360}   
${color1}  5:  ${color2}${cpu cpu5}%$alignr ${cpubar cpu5 6,360}   
${color1}  6:  ${color2}${cpu cpu6}%$alignr ${cpubar cpu6 6,360}   
${color1}  7:  ${color2}${cpu cpu7}%$alignr ${cpubar cpu7 6,360}   
${color1}  8:  ${color2}${cpu cpu8}%$alignr ${cpubar cpu8 6,360}   
]]
```

## Variables

${acpitemp}
${apcupsd_loadbar}
${apcupsd_loadgauge}
${apcupsd_loadgraph}
${battery}
${battery_bar}
${battery_percent}
${battery_short}
${battery_time}
${buffers}
${cached}
${conky_build_arch}
${conky_build_date}
${conky_version}
${cpu}
${cpubar}
${cpugauge}
${cpugraph}
${desktop}
${desktop_name}
${desktop_number}
${diskio}
${diskio_read}
${diskio_write}
${diskiograph}
${diskiograph_read}
${diskiograph_write}
${downspeed}
${downspeedf}
${downspeedgraph}
${entropy_avail}
${entropy_bar}
${entropy_perc}
${entropy_poolsize}
${freq}
${freq_g}
${fs_bar}
${fs_bar_free}
${fs_free}
${fs_free_perc}
${fs_size}
${fs_type}
${fs_used}
${fs_used_perc}
${gw_iface}
${gw_ip}
${i8k_ac_status}
${i8k_bios}
${i8k_cpu_temp}
${i8k_left_fan_rpm}
${i8k_left_fan_status}
${i8k_right_fan_rpm}
${i8k_right_fan_status}
${i8k_serial}
${i8k_version}
${kernel} // kernel
${laptop_mode}
${loadavg}
${loadgraph}
${machine}
${mem}
${membar}
${memeasyfree}
${memfree}
${memgauge}
${memgraph}
${memmax}
${memperc}
${monitor}
${monitor_number}
${nameserver}
${nodename} // PC name
${nodename_short} // PC name
${processes} // processes
${running_processes} // active processes
${running_threads} // active threads
${swap}
${swapbar}
${swapfree}
${swapmax}
${swapperc}
${sysname}
${threads}
${time}
${totaldown}
${totalup}
${trashed_mails}
${tztime}
${updates}
${upspeed}
${upspeedf}
${upspeedgraph}
${uptime} // uptime
${uptime_short} // uptime
${user_names} // user name
${user_number}
${user_terms}
${user_times} // uptime
${utime}
${wireless_essid} // wireless name
