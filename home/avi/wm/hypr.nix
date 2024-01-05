{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
with lib; let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
in {
  services.swayosd.enable = true;
  systemd.user.services = {
    swaybg = mkService {
      Unit.Description = "Wallpaper chooser";
      Service = {
        ExecStart = "${lib.getExe pkgs.swaybg} -i ${./wall.png}";
        Restart = "always";
      };
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      monitor=,preferred,auto,1


      exec-once = waybar

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = XCURSOR_SIZE,24

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant = altgr-intl

          follow_mouse = 1

          touchpad {
              natural_scroll = false
          }

          sensitivity = 0
      }

      general {
          gaps_in = 6
          gaps_out = 11
          border_size = 3
          col.active_border = rgb(89b4fa) rgb(cba67f) 270deg

          layout = dwindle

          allow_tearing = false
      }

      decoration {
          rounding = 7

          blur {
              enabled = true
              size = 3
              passes = 3
              ignore_opacity = false
              new_optimizations = 1
              xray = true
              contrast = 0.7
              brightness = 0.8
          }

          drop_shadow = true
          shadow_range = 20
          shadow_render_power = 5
          col.shadow = rgba(292c3cee)
      }

      animations {
          enabled = true

          bezier = smoothOut, 0.36, 0, 0.66, -0.56
          bezier = smoothIn, 0.25, 1, 0.5, 1
          bezier = overshot, 0.4, 0.8, 0.2, 1.2

          animation = windows, 1, 4, overshot, slide
          animation = windowsOut, 1, 4, smoothOut, slide
          animation = border, 1, 10, default

          animation = fade, 1, 10, smoothIn
          animation = fadeDim, 1, 10, smoothIn
          animation = workspaces, 1, 4, overshot, slidevert
      }

      dwindle {
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

      master {
          new_is_master = true
      }

      gestures {
          workspace_swipe = false
          workspace_swipe_forever = true
      }

      misc {
          force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
      }

      device:epic-mouse-v1 {
          sensitivity = -0.5
      }

      windowrulev2 = nomaximizerequest, class:.* # You'll probably like this.

      $mod = SUPER

      bind = $mod, return, exec, kitty
      bind = $mod, space, exec, anyrun

      bind = $mod, Q, killactive,
      bind = $mod, space, exec, wofi --show drun
      bind = $mod, P, pseudo, # dwindle
      bind = $mod, V, togglefloating,
      bind = $mod, J, togglesplit, # dwindle

      bind = $mod, delete, exit,

      bind = $mod, left, movefocus, l
      bind = $mod, right, movefocus, r
      bind = $mod, up, movefocus, u
      bind = $mod, down, movefocus, d

      bind = $mod SHIFT, right, resizeactive, 10 0
      bind = $mod SHIFT, left, resizeactive, -10 0
      bind = $mod SHIFT, up, resizeactive, 0 -10
      bind = $mod SHIFT, down, resizeactive, 0 10

      #bind = XF86AudioRaiseVolume, exec, swayosd --output-volume raise
      #bind = XF86AudioLowerVolume, exec, swayosd --output-volume lower
      #bind = XF86AudioMute, exec, swayosd --output-volume mute-toggle

      #bind = XF86MonBrightnessUp,exec,swayosd --brightness raise
      #bind = XF86MonBrightnessDownn,exec,swayosd --brightness lower

      bind = $mod, 1, workspace, 1
      bind = $mod, 2, workspace, 2
      bind = $mod, 3, workspace, 3
      bind = $mod, 4, workspace, 4
      bind = $mod, 5, workspace, 5

      bind = $mod SHIFT, 1, movetoworkspace, 1
      bind = $mod SHIFT, 2, movetoworkspace, 2
      bind = $mod SHIFT, 3, movetoworkspace, 3
      bind = $mod SHIFT, 4, movetoworkspace, 4
      bind = $mod SHIFT, 5, movetoworkspace, 5

      bind = $mod, S, togglespecialworkspace, magic
      bind = $mod SHIFT, S, movetoworkspace, special:magic

      bind = $mod, mouse_down, workspace, e+1
      bind = $mod, mouse_up, workspace, e-1

      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow
    '';
  };
}
