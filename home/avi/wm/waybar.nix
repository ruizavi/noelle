# {
#   pkgs,
#   lib,
#   config,
#   ...
# }: let
#   formatIcons = color: text: "<span color='${color}' font_size='13pt'>${text}</span>";
# in {
#   xdg.configFile."waybar/style.css".text = import ./style.nix;
#   programs.waybar = {
#     enable = true;
#     package = pkgs.waybar;
#     settings = {
#       mainBar = {
#         layer = "top";
#         position = "left";
#         width = 55;
#         spacing = 7;
#         fixed-center = false;
#         margin-left = null;
#         margin-top = null;
#         margin-bottom = null;
#         margin-right = null;
#         exclusive = true;
#         modules-left = [
#           "custom/search"
#           "hyprland/workspaces"
#           "custom/weather"
#         ];
#         modules-center = [
#         ];
#         modules-right = [
#           "backlight"
#           "pulseaudio"
#           "network"
#           "battery"
#           "clock"
#           "group/group-power"
#         ];
#         "hyprland/workspaces" = {
#           on-click = "activate";
#           format = "{icon}";
#           active-only = false;
#           format-icons = {
#             "1" = "";
#             "2" = "󰨞";
#             "3" = "󰈹";
#             "4" = "󰓇";
#             "5" = "󰯉";
#           };
#           persistent_workspaces = {
#             "*" = 5;
#           };
#         };
#         "custom/search" = {
#           format = " ";
#           tooltip = false;
#           on-click = "${lib.getBin config.programs.anyrun.package}/anyrun}";
#         };
#         # "custom/power" = {
#         #   tooltip = false;
#         #   # TODO
#         #   format = "󰐥";
#         # };
#         clock = {
#           format = ''
#             {:%H
#             %M}'';
#           tooltip-format = ''
#             <big>{:%Y %B}</big>
#             <tt><small>{calendar}</small></tt>'';
#         };
#         backlight = {
#           format = "{icon}";
#           format-icons = ["" "" "" "" "" "" "" "" ""];
#         };
#         cpu = {
#           interval = 5;
#           format = "  {}%";
#         };
#         battery = {
#           states = {
#             warning = 30;
#             critical = 15;
#           };
#           format = "{icon}";
#           format-charging = "󰂄";
#           format-plugged = "󰂄";
#           format-alt = "{icon}";
#           format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰁿" "󰁿" "󰂁" "󰂂" "󰁹"];
#         };
#         network = let
#           nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
#         in {
#           format-wifi = "󰤨";
#           format-ethernet = "󰈀";
#           format-alt = "󱛇";
#           format-disconnected = "󰤭";
#           tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
#           on-click-right = "${nm-editor}";
#         };
#         pulseaudio = {
#           scroll-step = 5;
#           tooltip = true;
#           tooltip-format = "{volume}";
#           on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
#           format = "{icon}";
#           format-muted = "󰝟 ";
#           format-icons = {
#             default = ["" "" " "];
#           };
#         };
#         "group/group-power" = {
#           orientation = "inherit";
#           drawer = {
#             transition-duration = 300;
#             transition-left-to-right = false;
#             children-class = "power-child";
#           };
#           modules = [
#             "custom/power"
#             "custom/quit"
#             "custom/lock"
#             "custom/suspend"
#             "custom/reboot"
#           ];
#         };
#         "custom/quit" = {
#           format = formatIcons "#B48EADCC" "󰍃";
#           onclick = "loginctl terminate-user $USER";
#           tooltip = false;
#         };
#         "custom/lock" = {
#           format = formatIcons "#81A1C1CC" "󰌾";
#           onclick = "loginctl lock-session";
#           tooltip = false;
#         };
#         "custom/suspend" = {
#           format = formatIcons "#A3BE8CCC" "󰒲";
#           onclick = "systemctl suspend";
#           tooltip = false;
#         };
#         "custom/reboot" = {
#           format = formatIcons "#EBCB8BCC" "󰜉";
#           on-click = "systemctl reboot";
#           tooltip = false;
#         };
#         "custom/power" = {
#           format = formatIcons "#BF616ACC" "󰐥";
#           on-click = "systemctl poweroff";
#           tooltip = false;
#         };
#         "custom/weather" = let
#           weather = pkgs.stdenv.mkDerivation {
#             name = "waybar-wttr";
#             buildInputs = [
#               (pkgs.python39.withPackages
#                 (pythonPackages: with pythonPackages; [requests pyquery]))
#             ];
#             unpackPhase = "true";
#             installPhase = ''
#               mkdir -p $out/bin
#               cp ${./weather.py} $out/bin/weather
#               chmod +x $out/bin/weather
#             '';
#           };
#         in {
#           format = "{}";
#           tooltip = true;
#           interval = 30;
#           exec = "${weather}/bin/weather";
#           return-type = "json";
#         };
#       };
#     };
#   };
# }
{
  lib,
  pkgs,
  config,
  ...
}: let
  _ = lib.getExe;
  inherit (pkgs) brightnessctl pamixer;

  formatIcons = color: text: "<span color='${color}' font_size='13pt'>${text}</span>";

  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg";
    sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
  };
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        exclusive = true;
        passthrough = false;
        fixed-center = true;
        gtk-layer-shell = true;
        width = 42;

        spacing = 0;
        margin-top = 0;
        margin-right = 0;
        margin-bottom = 0;
        margin-left = 0;
        modules-left = [
          "custom/search"
          "custom/weather"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "group/group-pulseaudio"
          "group/group-backlight"
          "battery"
          "network"
          "clock"
          "group/group-power"
        ];
        "hyprland/window" = {
          format = "{}";
          separate-outputs = false;
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹";
            "(.*)Mozilla Firefox" = "󰈹";
            "(.*) - Visual Studio Code" = "󰨞";
            "(.*)Visual Studio Code" = "󰨞";
            "(.*) — Thunar" = "󰉋";
            "(.*)Spotify" = "󰓇";
            "(${config.home.username}@noelle):(.*)" = "";
          };
          "max-length" = 1;
        };
        "custom/search" = {
          format = " ";
          tooltip = false;
          on-click = "sh -c 'anyrun'";
        };
        "custom/weather" = let
          weather = pkgs.stdenv.mkDerivation {
            name = "waybar-wttr";
            buildInputs = [
              (pkgs.python39.withPackages
                (pythonPackages: with pythonPackages; [requests pyquery]))
            ];
            unpackPhase = "true";
            installPhase = ''
              mkdir -p $out/bin
              cp ${./weather.py} $out/bin/weather
              chmod +x $out/bin/weather
            '';
          };
        in {
          format = "{}";
          tooltip = true;
          interval = 30;
          exec = "${weather}/bin/weather";
          return-type = "json";
        };
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = false;
          disable-scroll = true;
          on-click = "activate";
          format = "{name}";
        };
        network = {
          format-wifi = formatIcons "#B48EADCC" "󰖩";
          format-ethernet = formatIcons "#B48EADCC" "󰈀";
          format-disconnected = formatIcons "#BF616ACC" "󰖪";
          tooltip-format = ''
            󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}
            {ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)'';
        };
        "group/group-pulseaudio" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "pulseaudio-child";
            transition-left-to-right = false;
          };
          modules = [
            "pulseaudio"
            "pulseaudio/slider"
          ];
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
        };
        pulseaudio = {
          tooltip = false;
          format = formatIcons "#94e2d5CC" "{icon}";
          format-muted = formatIcons "#BF616ACC" "󰖁";
          format-icons = {default = ["󰕿" "󰖀" "󰕾"];};
          on-click = "${_ pamixer} -t";
          on-scroll-up = "${_ pamixer} -d 1";
          on-scroll-down = "${_ pamixer} -i 1";
        };
        "group/group-backlight" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "backlight-child";
            transition-left-to-right = false;
          };
          modules = [
            "backlight"
            "backlight/slider"
          ];
        };
        "backlight/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
        };
        backlight = {
          tooltip = false;
          format = formatIcons "#f9e2afCC" "{icon}";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
          on-scroll-up = "${_ brightnessctl} -q s 1%-";
          on-scroll-down = "${_ brightnessctl} -q s +1%";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          tooltip-format = "{timeTo}, {capacity}%";
          format = formatIcons "#a6e3a1CC" "{icon}";
          format-charging = formatIcons "#A3BE8CCC" "󰂄";
          format-plugged = formatIcons "#A3BE8CCC" "󰚥";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        clock = {
          format = ''
            {:%H
            %M}'';
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "clock#date" = {
          format = formatIcons "#88C0D0CC" "󰃶" + " {:%a %d %b}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        "group/group-power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            transition-left-to-right = false;
            children-class = "power-child";
          };
          modules = [
            "custom/power"
            "custom/suspend"
            "custom/reboot"
          ];
        };
        "custom/quit" = {
          format = formatIcons "#B48EADCC" "󰍃";
          onclick = "loginctl terminate-user $USER";
          tooltip = false;
        };
        "custom/lock" = {
          format = formatIcons "#81A1C1CC" "󰌾";
          onclick = "loginctl lock-session";
          tooltip = false;
        };
        "custom/suspend" = {
          format = formatIcons "#A3BE8CCC" "󰒲";
          onclick = "systemctl suspend";
          tooltip = false;
        };
        "custom/reboot" = {
          format = formatIcons "#EBCB8BCC" "󰜉";
          on-click = "systemctl reboot";
          tooltip = false;
        };
        "custom/power" = {
          format = formatIcons "#BF616ACC" "󰐥";
          on-click = "systemctl poweroff";
          tooltip = false;
        };
      };
    };

    style = ''
                @define-color Background #000000;
                @define-color Foreground #ffffff;
                @define-color Accent #88C0D0;
                @define-color Error #BF616A;
                @define-color Warning #EBCB8B;

                * {
                  all: initial;
                  border: none;
                  border-radius: 0;
                  min-height: 0;
                  min-width: 0;
                  font-family: "Material Design Icons" ,monospace;
                  font-size: 1rem;
                }

                window#waybar {
                  background-color: alpha(@Background, 0.2);
                }

                #custom-search {
                  background-image: url("${snowflake}");
                  background-size: 65%;
                  margin-top: 35px;
                  padding-top: 25px;
                  margin: 5px;
                  margin-bottom: 0;
                  background-position: center;
                  background-repeat: no-repeat;
                }

                #workspaces {
                  background-color: alpha(@Background, 0.2);
                  border-radius: 4px;
                  margin: 0.41em 0.21em;
                  padding: 0.41em 0;
              box-shadow: inset 0 -3px transparent;
              transition: all 400ms cubic-bezier(0.250, 0.250, 0.555, 1.425);
                }

                #workspaces button {
                  margin: 0 0.82em;
                }

                #workspaces button:hover {
                  box-shadow: inherit;
                  text-shadow: inherit;
                }

                #workspaces button label {
                  color: alpha(@Foreground, 0.8);
                }

                #workspaces button.empty label {
                  color: alpha(@Foreground, 0.4);
                }

                #workspaces button.urgent label {
                  color: alpha(@Error, 0.8);
                }

                #workspaces button.special label {
                  color: alpha(@Warning, 0.8);
                  text-shadow:
                    0 0 0.14em @Warning,
                    0 0 0.27em @Warning,
                    0 0 0.41em @Warning,
                    0 0 0.55em @Warning,
                    0 0 0.68em @Warning;
                }

                #user,
                #workspaces button.active label {
                  color: alpha(@Accent, 0.8);
                  text-shadow:
                    0 0 0.14em @Accent,
                    0 0 0.27em @Accent,
                    0 0 0.41em @Accent,
                    0 0 0.55em @Accent,
                    0 0 0.68em @Accent;
                }

                  #clock {
        font-weight: 700;
        font-family: "Iosevka Term";
        padding: 5px 0px 5px 0px;
      }

                #backlight,
                #backlight-slider,
                #battery,
                #clock,
                #clock.date,
                #window,
                #custom-lock,
                #custom-power,
                #custom-reboot,
                #custom-suspend,
                #custom-weather,
                #custom-quit,
                #network,
                #pulseaudio,
                #pulseaudio-slider,
                #pulseaudio.microphone,
                #tray,
                #user {
                  color: alpha(@Foreground, 0.8);
                  background-color: alpha(@Background, 0.2);
                  border-radius: 4px;
                  margin: 0.31em 0.21em;
                  padding: 0.41em 0.82em;
                }

                #backlight-slider slider,
                #pulseaudio-slider slider {
                  min-height: 0px;
                  min-width: 0px;
                  opacity: 0;
                  background-image: none;
                  border: none;
                  box-shadow: none;
                  margin: 0 0.68em;
                }

                #backlight-slider trough,
                #pulseaudio-slider trough {
                  min-height: 5.2em;
                  border-radius: 8px;
                  background-color: alpha(@Background, 0.2);
                }

                #backlight-slider highlight {
                  min-width: 0.68em;
                  border-radius: 8px;
                  background-color: alpha(#f9e2af, 0.8);
                  box-shadow:
                    0 0 0.14em #f9e2af,
                    0 0 0.27em #f9e2af,
                    0 0 0.41em #f9e2af,
                    0 0 0.55em #f9e2af;
                }

                #pulseaudio-slider highlight {
                  min-width: 0.68em;
                  border-radius: 8px;
                  background-color: alpha(#94e2d5, 0.8);
                  box-shadow:
                    0 0 0.14em #94e2d5,
                    0 0 0.27em #94e2d5,
                    0 0 0.41em #94e2d5,
                    0 0 0.55em #94e2d5;
                }


          #battery.warning {
            color: #fab387;
          }

          #battery.critical:not(.charging) {
            color: #f38ba8;
          }

                tooltip {
                  color: alpha(@Foreground, 0.8);
                  background-color: alpha(@Background, 0.9);
                  font-family: "Dosis", sans-serif;
                  border-radius: 8px;
                  padding: 1.37em;
                  margin: 2.05em;
                }

                tooltip label {
                  font-family: "Dosis", sans-serif;
                  padding: 1.37em;
                }
    '';
  };
}
