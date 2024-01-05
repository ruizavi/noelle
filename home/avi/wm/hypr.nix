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

      # █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
      # █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄

      # See https://wiki.hyprland.org/Configuring/Monitors/

      # monitor = DP-1, 2560x1080@144, 0x0, 1
      monitor = ,preferred,auto,1

      # █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
      # █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      # Execute your favorite apps at launch

      exec-once = waybar
      exec-once = blueman-applet # systray app for BT
      exec-once = nm-applet --indicator # systray app for Network/Wifi
      exec-once = dunst # start notification demon
      exec-once = ~/.config/hypr/scripts/batterynotify.sh # battery notification

      # █▀▀ █▄░█ █░█
      # ██▄ █░▀█ ▀▄▀

      # Some default env vars.

      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = GDK_BACKEND,wayland
      env = QT_QPA_PLATFORM,wayland
      #env = QT_STYLE_OVERRIDE,kvantum
      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = MOZ_ENABLE_WAYLAND,1

      # █ █▄░█ █▀█ █░█ ▀█▀
      # █ █░▀█ █▀▀ █▄█ ░█░

      input {
          kb_layout = us
          kb_variant = altgr-intl

          follow_mouse = 1

          touchpad {
              natural_scroll = false
          }

          sensitivity = 0
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more

      device:epic mouse V1 {
          sensitivity = -0.5
      }

      # See https://wiki.hyprland.org/Configuring/Variables/ for more

      gestures {
          workspace_swipe = true
          workspace_swipe_fingers = 3
      }

      # █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
      # █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more

      dwindle {
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more

      master {
          new_is_master = true
      }

      # █▀▄▀█ █ █▀ █▀▀
      # █░▀░█ █ ▄█ █▄▄

      # See https://wiki.hyprland.org/Configuring/Variables/ for more

      misc {
          vrr = 0
      }


      # ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
      # █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█


      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      animations {
          enabled = yes
          bezier = wind, 0.05, 0.9, 0.1, 1.05
          bezier = winIn, 0.1, 1.1, 0.1, 1.1
          bezier = winOut, 0.3, -0.3, 0, 1
          bezier = liner, 1, 1, 1, 1
          animation = windows, 1, 6, wind, slide
          animation = windowsIn, 1, 6, winIn, slide
          animation = windowsOut, 1, 5, winOut, slide
          animation = windowsMove, 1, 5, wind, slide
          animation = border, 1, 1, liner
          animation = borderangle, 1, 30, liner, loop
          animation = fade, 1, 10, default
          animation = workspaces, 1, 5, wind
      }

      general {
          gaps_in = 3
          gaps_out = 8
          border_size = 2
          col.active_border = rgba(ca9ee6ff) rgba(f2d5cfff) 45deg
          col.inactive_border = rgba(b4befecc) rgba(6c7086cc) 45deg
          layout = dwindle
          resize_on_border = true
      }

      decoration {
          rounding = 10
          drop_shadow = false

          blur {
              enabled = yes
              size = 6
              passes = 3
              new_optimizations = on
              ignore_opacity = on
              xray = false
          }
      }

      blurls = waybar

      # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
      # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█


      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

      windowrulev2 = opacity 0.90 0.90,class:^(firefox)$
      windowrulev2 = opacity 0.80 0.80,class:^(Steam)$
      windowrulev2 = opacity 0.80 0.80,class:^(steam)$
      windowrulev2 = opacity 0.80 0.80,class:^(steamwebhelper)$
      windowrulev2 = opacity 0.80 0.80,class:^(Spotify)$
      windowrulev2 = opacity 0.80 0.80,class:^(Code)$
      windowrulev2 = opacity 0.80 0.80,class:^(code-url-handler)$
      windowrulev2 = opacity 0.80 0.80,class:^(kitty)$
      windowrulev2 = opacity 0.80 0.80,class:^(org.kde.dolphin)$
      windowrulev2 = opacity 0.80 0.80,class:^(org.kde.ark)$
      windowrulev2 = opacity 0.80 0.80,class:^(nwg-look)$
      windowrulev2 = opacity 0.80 0.80,class:^(qt5ct)$

      windowrulev2 = opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$ #Clapper-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$ #Flatseal-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$ #Cartridges-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(com.obsproject.Studio)$ #Obs-Qt
      windowrulev2 = opacity 0.80 0.80,class:^(gnome-boxes)$ #Boxes-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(discord)$ #Discord-Electron
      windowrulev2 = opacity 0.80 0.80,class:^(WebCord)$ #WebCord-Electron
      windowrulev2 = opacity 0.80 0.80,class:^(app.drey.Warp)$ #Warp-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$ #ProtonUp-Qt
      windowrulev2 = opacity 0.80 0.80,class:^(yad)$ #Protontricks-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(Signal)$ #Signal-Gtk
      windowrulev2 = opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$ #Upscaler-Gtk

      windowrulev2 = opacity 0.80 0.70,class:^(pavucontrol)$
      windowrulev2 = opacity 0.80 0.70,class:^(blueman-manager)$
      windowrulev2 = opacity 0.80 0.70,class:^(nm-applet)$
      windowrulev2 = opacity 0.80 0.70,class:^(nm-connection-editor)$
      windowrulev2 = opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$

      windowrulev2 = float,class:^(qt5ct)$
      windowrulev2 = float,class:^(nwg-look)$
      windowrulev2 = float,class:^(org.kde.ark)$
      windowrulev2 = float,class:^(Signal)$ #Signal-Gtk
      windowrulev2 = float,class:^(com.github.rafostar.Clapper)$ #Clapper-Gtk
      windowrulev2 = float,class:^(app.drey.Warp)$ #Warp-Gtk
      windowrulev2 = float,class:^(net.davidotek.pupgui2)$ #ProtonUp-Qt
      windowrulev2 = float,class:^(yad)$ #Protontricks-Gtk
      windowrulev2 = float,class:^(eog)$ #Imageviewer-Gtk
      windowrulev2 = float,class:^(io.gitlab.theevilskeleton.Upscaler)$ #Upscaler-Gtk
      windowrulev2 = float,class:^(pavucontrol)$
      windowrulev2 = float,class:^(blueman-manager)$
      windowrulev2 = float,class:^(nm-applet)$
      windowrulev2 = float,class:^(nm-connection-editor)$
      windowrulev2 = float,class:^(org.kde.polkit-kde-authentication-agent-1)$



      # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
      # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█

      # apps
      $term = kitty
      $editor = code
      $file = thunar
      $browser = brave



      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

      # Main modifier
      $mainMod = SUPER # windows key

      # Window/Session actions
      bind = $mainMod, Q, exec, ~/.config/hypr/scripts/dontkillsteam.sh # killactive, kill the window on focus
      bind = ALT, F4, exec, ~/.config/hypr/scripts/dontkillsteam.sh # killactive, kill the window on focus
      bind = $mainMod, delete, exit, # kill hyperland session
      bind = $mainMod, W, togglefloating, # toggle the window on focus to float
      bind = $mainMod, G, togglegroup, # toggle the window on focus to float
      bind = ALT, return, fullscreen, # toggle the window on focus to fullscreen
      # bind = $mainMod, L, exec, swaylock # lock screen
      bind = $mainMod, backspace, exec, ~/.config/hypr/scripts/logoutlaunch.sh 1 # logout menu

      # Application shortcuts
      bind = $mainMod, return, exec, $term  # open terminal
      bind = $mainMod, E, exec, $file # open file manager
      bind = $mainMod, C, exec, $editor # open vscode
      bind = $mainMod, F, exec, $browser # open browser

      # Rofi is toggled on/off if you repeat the key presses
      bind = $mainMod, space, exec, pkill anyrun || anyrun

      # Audio control
      bind  = , F10, exec, ~/.config/hypr/scripts/volumecontrol.sh -o m # toggle audio mute
      binde = , F11, exec, ~/.config/hypr/scripts/volumecontrol.sh -o d # decrease volume
      binde = , F12, exec, ~/.config/hypr/scripts/volumecontrol.sh -o i # increase volume
      bind  = , XF86AudioMute, exec, ~/.config/hypr/scripts/volumecontrol.sh -o m # toggle audio mute
      bind  = , XF86AudioMicMute, exec, ~/.config/hypr/scripts/volumecontrol.sh -i m # toggle microphone mute
      binde = , XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/volumecontrol.sh -o d # decrease volume
      binde = , XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/volumecontrol.sh -o i # increase volume
      bind  = , XF86AudioPlay, exec, ${pkgs.playerctl} play-pause
      bind  = , XF86AudioPause, exec, ${pkgs.playerctl} play-pause
      bind  = , XF86AudioNext, exec, ${pkgs.playerctl} next
      bind  = , XF86AudioPrev, exec, ${pkgs.playerctl} previous

      # Brightness control
      binde = , XF86MonBrightnessUp, exec, ~/.config/hypr/scripts/brightnesscontrol.sh i # increase brightness
      binde = , XF86MonBrightnessDown, exec, ~/.config/hypr/scripts/brightnesscontrol.sh d # decrease brightness

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bind = ALT, Tab, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Resize windows
      binde = $mainMod SHIFT, right, resizeactive, 10 0
      binde = $mainMod SHIFT, left, resizeactive, -10 0
      binde = $mainMod SHIFT, up, resizeactive, 0 -10
      binde = $mainMod SHIFT, down, resizeactive, 0 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/Resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Special workspaces (scratchpad)
      bind = $mainMod ALT, S, movetoworkspacesilent, special
      bind = $mainMod, S, togglespecialworkspace,

      # Toggle Layout
      bind = $mainMod, J, togglesplit, # dwindle

      # Move window to workspace Super + Alt + [0-9]
      bind = $mainMod ALT, 1, movetoworkspacesilent, 1
      bind = $mainMod ALT, 2, movetoworkspacesilent, 2
      bind = $mainMod ALT, 3, movetoworkspacesilent, 3
      bind = $mainMod ALT, 4, movetoworkspacesilent, 4
      bind = $mainMod ALT, 5, movetoworkspacesilent, 5
      bind = $mainMod ALT, 6, movetoworkspacesilent, 6
      bind = $mainMod ALT, 7, movetoworkspacesilent, 7
      bind = $mainMod ALT, 8, movetoworkspacesilent, 8
      bind = $mainMod ALT, 9, movetoworkspacesilent, 9
      bind = $mainMod ALT, 0, movetoworkspacesilent, 10

      # Trigger when the switch is turning off
      # bindl= , switch:on:Lid Switch, exec, swaylock && systemctl suspend

      # Night light // Install hyprshade for blue light feature
      bind = $mainMod ALT, XF86MonBrightnessDown, exec, ${pkgs.hyprshade} on blue-light-filter
      bind = $mainMod ALT, XF86MonBrightnessUp, exec, ${pkgs.hyprshade} off
    '';
  };

  home = {
    file = {
      ".config/hypr/scripts/batterynotify.sh" = {
        executable = true;
        text = ''
          #!/bin/bash

          # Check if the system is a laptop
          is_laptop() {
              if [ -d /sys/class/power_supply/ ]; then
                  for supply in /sys/class/power_supply/*; do
                      if [ -e "$supply/type" ]; then
                          type=$(cat "$supply/type")
                          if [ "$type" == "Battery" ]; then
                              return 0  # It's a laptop
                          fi
                      fi
                  done
              fi
              return 1  # It's not a laptop
          }

          if is_laptop; then

          while true; do
              battery_status=$(cat /sys/class/power_supply/BAT0/status)
              battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

              if [ "$battery_status" == "Discharging" ] && [ "$battery_percentage" -le 20 ]; then
                  dunstify -u CRITICAL "Battery Low" "Battery is at $battery_percentage%. Connect the charger."
              fi

              if [ "$battery_status" == "Charging" ] && [ "$battery_percentage" -ge 80 ]; then
                  dunstify -u NORMAL "Battery Charged" "Battery is at $battery_percentage%. You can unplug the charger."
              fi

              sleep 300  # Sleep for 5 minutes before checking again
            done

          fi
        '';
      };
      ".config/hypr/scripts/brightnesscontrol.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash

          gtkMode=`gsettings get org.gnome.desktop.interface color-scheme | sed "s/'//g" | awk -F '-' '{print $2}'`
          ncolor="-h string:bgcolor:#191724 -h string:fgcolor:#faf4ed -h string:frcolor:#56526e"

          if [ "$\{gtkMode}" == "light" ] ; then
            ncolor="-h string:bgcolor:#f4ede8 -h string:fgcolor:#9893a5 -h string:frcolor:#908caa"
          fi

          function send_notification {
            brightness=`brightnessctl info | grep -oP "(?<=\()\d+(?=%)" | cat`
            brightinfo=$(brightnessctl info | awk -F"'" '/Device/ {print $2}')

            angle="$(((($brightness + 2) / 5) * 5))"
            ico="~/.config/dunst/icons/vol/vol-$\{angle}.svg"
            bar=$(seq -s "." $(($brightness / 15)) | sed 's/[0-9]//g')

            if [ $brightness -ne 0 ]; then
              dunstify $ncolor "brightctl $brightness%" "Device: $brightinfo" -r 91190 -t 800

            else
              dunstify "Brightness: $\{brightness}%" -a "$brightinfo" -u low -r 91190 -t 800
            fi

          }

          function get_brightness {
            brightnessctl -m | grep -o '[0-9]\+%' | head -c-2
          }

          case $1 in
          i)
            # increase the backlight by 5%
            brightnessctl set +5%
            send_notification
            ;;
          d)
            if [[ $(get_brightness) -lt 5 ]]; then
              # avoid 0% brightness
              brightnessctl set 1%
            else
              # decrease the backlight by 5%
              brightnessctl set 5%-
            fi
            send_notification
            ;;
          esac
        '';
      };
      ".config/hypr/scripts/volumecontrol.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env sh

          # define functions

          function print_error
          {
          cat << "EOF"
              ./volumecontrol.sh -[device] <action>
              ...valid device are...
                  i -- [i]nput decive
                  o -- [o]utput device
              ...valid actions are...
                  i -- <i>ncrease volume [+5]
                  d -- <d>ecrease volume [-5]
                  m -- <m>ute [x]
          EOF
          exit 1
          }

          function notify_vol
          {
              vol=`pamixer $srce --get-volume | cat`
              angle="$(( (($vol+2)/5) * 5 ))"
              bar=$(seq -s "." $(($vol / 15)) | sed 's/[0-9]//g')
              dunstify $ncolor "volctl" -a "$vol%" "$nsink" -r 91190 -t 800
          }

          function notify_mute
          {
              mute=`pamixer $srce --get-mute | cat`
              if [ "$mute" == "true" ] ; then
                  dunstify $ncolor "volctl" -a "muted" "$nsink" -r 91190 -t 800
              else
                  dunstify $ncolor "volctl" -a "unmuted" "$nsink" -r 91190 -t 800
              fi
          }

          # set device source

          while getopts io SetSrc
          do
              case $SetSrc in
              i) nsink=$(pamixer --list-sources | grep "_input." | head -1 | awk -F '" "' '{print $NF}' | sed 's/"//')
                  srce="--default-source"
                  dvce="mic" ;;
              o) nsink=$(pamixer --get-default-sink | grep "_output." | awk -F '" "' '{print $NF}' | sed 's/"//')
                  srce=""
                  dvce="speaker" ;;
              esac
          done

          if [ $OPTIND -eq 1 ] ; then
              print_error
          fi

          # set device action

          shift $((OPTIND -1))
          step="5"
          icodir="~/.config/dunst/icons/vol"

          gtkMode=`gsettings get org.gnome.desktop.interface color-scheme | sed "s/'//g" | awk -F '-' '{print $2}'`
          ncolor="-h string:bgcolor:#191724 -h string:fgcolor:#faf4ed -h string:frcolor:#56526e"

          if [ "$\{gtkMode}" == "light" ] ; then
              ncolor="-h string:bgcolor:#f4ede8 -h string:fgcolor:#9893a5 -h string:frcolor:#908caa"
          fi

          case $1 in
              i) pamixer $srce -i $step
                  notify_vol ;;
              d) pamixer $srce -d $step
                  notify_vol ;;
              m) pamixer $srce -t
                  notify_mute ;;
              *) print_error ;;
          esac
        '';
      };
      ".config/hypr/scripts/dontkillsteam.sh" = {
        executable = true;
        text = ''
          if [[ $(hyprctl activewindow -j | jq -r ".class") == "Steam" ]]; then
              xdotool windowunmap $(xdotool getactivewindow)
          else
              hyprctl dispatch killactive ""
          fi
        '';
      };
    };
  };
}
