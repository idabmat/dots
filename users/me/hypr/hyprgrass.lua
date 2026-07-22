hl.plugin.load("/etc/profiles/per-user/me/lib/libhyprgrass.so")

hl.config({
  plugin = {
    hyprgrass = {
      sensitivity = 1.0,
      long_press_delay = 400,
      resize_on_border_long_press = true,
      edge_margin = 10,
    }
  }
})

hl.plugin.hyprgrass.bind {
  pattern = { kind = "edge", origin = "u", direction = "d" },
  action = hl.dsp.exec_cmd("nwg-drawer"),
}

hl.plugin.hyprgrass.bind {
  pattern = { kind = "edge", origin = "d", direction = "u" },
  action = hl.dsp.exec_cmd("pkill -SIGRTMIN wvkbd-mobintl"),
}
