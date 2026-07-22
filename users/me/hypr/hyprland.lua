-----------------
---- PLUGINS ----
-----------------
dofile("/home/me/.config/hypr/hyprgrass.lua")

------------------
---- MONITORS ----
------------------
hl.monitor({
  output = "eDP-1",
  mode = "2560x1600@180",
  position = "0x0",
  scale = 1,
  bitdepth = 10,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "3840x2160@60",
  position = "auto",
  scale = 1.6,
  bitdepth = 10,
})

-----------------
---- DEVICES ----
-----------------
hl.device({
  name = "elan9008:00-04f3:43c7",
  output = "eDP-1",
})

hl.device({
  name = "elan9008:00-04f3:43c7-stylus",
  output = "eDP-1",
})

----------------
---- CONFIG ----
----------------
hl.config({
  general = {
    border_size = 2,
    gaps_in = 10,
    gaps_out = 20,
    col = {
      active_border = { colors = { "0xff882ae9", "0xff34eceb" }, angle = 45 },
      inactive_border = { colors = { "0xff21242C" } },
    },
    layout = "dwindle",
  },

  decoration = {
    rounding = 20,
    rounding_power = 1,
    active_opacity = 1,
    inactive_opacity = 1,
  },

  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = "slave",
    orientation = "center",
  },

  misc = {
    disable_hyprland_logo = true,
    vrr = 2,
  },

  input = {
    touchpad = {
      natural_scroll = true,
    },
    natural_scroll = true,
  },

  ecosystem = {
    no_donation_nag = true,
    no_update_news = false,
  },

  gestures = {
    workspace_swipe_touch = true,
    workspace_swipe_cancel_ratio = 0.15,
  },
})

------------------
---- BINDINGS ----
------------------
local mainMod = "SUPER"

---- MOVING ----
for key, direction in pairs({ n = "l", e = "d", i = "u", o = "r" }) do
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "m-1" }))

---- APPS ----
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("nwg-drawer"))
hl.bind(mainMod .. " + J", hl.dsp.exec_cmd([[BEMOJI_PICKER_CMD="hyprlauncher -m" bemoji]]))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.pin({ action = "toggle" }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("grim"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | hyprlauncher -m | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + X", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("chromium --profile-directory=Work"))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("swaync-client -t"))

---- MOUSE ----
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

---- RESIZE ----
for key, resize in pairs({
  n = { x = -10, y = 0, relative = true },
  e = { x = 0, y = -10, relative = true },
  i = { x = 0, y = 10, relative = true },
  o = { x = 10, y = 0, relative = true }
}) do
  hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.resize(resize), { repeating = true })
end

---- MEDIA ----
for key, specs in pairs({
  XF86AudioLowerVolume = { cmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", opts = { locked = true, repeating = true } },
  XF86AudioRaiseVolume = { cmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+", opts = { locked = true, repeating = true } },
  XF86AudioMute = { cmd = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", opts = { locked = true } },
  XF86AudioMicMute = { cmd = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", opts = { locked = true } },
  XF86AudioPlay = { cmd = "playerctl play-pause", opts = { locked = true } },
  XF86AudioPrev = { cmd = "playerctl previous", opts = { locked = true } },
  XF86AudioNext = { cmd = "playerctl next", opts = { locked = true } },
  XF86AudioStop = { cmd = "playerctl stop", opts = { locked = true } }
}) do
  hl.bind(key, hl.dsp.exec_cmd(specs.cmd), specs.opts)
end

---- AUTOSTART ----
hl.on("hyprland.start", function()
  local apps = {
    "wl-paste --type text --watch cliphist store",
    "wl-paste --type image --watch cliphist store",
    "hyprctl setcursor BreezeX-RosePine-Linux 32",
    "iio-hyprland",
    "wvkbd-mobintl -H 350 -L 300 --hidden",
    "nwg-drawer -is 128 -spacing 24 -ovl -pblock hyprlock -pbuseicontheme -pbreboot reboot -pbpoweroff poweroff -pbexit 'uwsm stop' -pbsleep 'systemctl suspend-then-hibernate' -fm nautilus -r",
  }
  for _, app in ipairs(apps) do
    hl.exec_cmd("uwsm app -- " .. app)
  end
end)
