{
  pkgs,
  lib,
  config,
  ...
}: {
  xdg.configFile."waybar/style.css".text = import ./style.nix;
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        width = 55;
        spacing = 7;
        fixed-center = false;
        margin-left = null;
        margin-top = null;
        margin-bottom = null;
        margin-right = null;
        exclusive = true;
        modules-left = [
          "custom/search"
          "hyprland/workspaces"
          #"custom/weather"
        ];
        modules-center = [
        ];
        modules-right = [
          "backlight"
          "pulseaudio"
          "network"
          "battery"
          "clock"
          "custom/power"
        ];
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          active-only = false;
          format-icons = {
            "1" = "";
            "2" = "󰨞";
            "3" = "󰈹";
            "4" = "󰓇";
            "5" = "󰯉";
          };

          persistent_workspaces = {
            "*" = 5;
          };
        };
        "custom/search" = {
          format = " ";
          tooltip = false;
          on-click = "lib.getBin config.programs.anyrun.package}/anyrun";
        };
        "custom/power" = {
          tooltip = false;
          # TODO
          format = "󰐥";
        };
        clock = {
          format = ''
            {:%H
            %M}'';
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        backlight = {
          format = "{icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        cpu = {
          interval = 5;
          format = "  {}%";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "󰂄";
          format-plugged = "󰂄";
          format-alt = "{icon}";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰁿" "󰁿" "󰂁" "󰂂" "󰁹"];
        };
        network = let
          nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        in {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-alt = "󱛇";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
          on-click-right = "${nm-editor}";
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = true;
          tooltip-format = "{volume}";
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
          format = "{icon}";
          format-muted = "󰝟 ";
          format-icons = {
            default = ["" "" " "];
          };
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
      };
    };
  };
}
