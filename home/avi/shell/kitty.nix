{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;
    extraConfig = ''
      # vim:ft=kitty

      ## name:     Catppuccin Mocha 🌿
      ## author:   Pocco81 (https://github.com/Pocco81)
      ## license:  MIT
      ## upstream: https://github.com/catppuccin/kitty/blob/main/mocha.conf
      ## blurb:    Soothing pastel theme for the high-spirited!



      # The basic colors
      foreground              #CDD6F4
      background              #1E1E2E
      selection_foreground    #1E1E2E
      selection_background    #F5E0DC

      # Cursor colors
      cursor                  #F5E0DC
      cursor_text_color       #1E1E2E

      # URL underline color when hovering with mouse
      url_color               #B4BEFE

      # Kitty window border colors
      active_border_color     #CBA6F7
      inactive_border_color   #8E95B3
      bell_border_color       #EBA0AC

      # OS Window titlebar colors
      wayland_titlebar_color system
      macos_titlebar_color system

      # Tab bar colors
      active_tab_foreground   #11111B
      active_tab_background   #CBA6F7
      inactive_tab_foreground #CDD6F4
      inactive_tab_background #181825
      tab_bar_background      #11111B

      # Colors for marks (marked text in the terminal)
      mark1_foreground #1E1E2E
      mark1_background #87B0F9
      mark2_foreground #1E1E2E
      mark2_background #CBA6F7
      mark3_foreground #1E1E2E
      mark3_background #74C7EC

      # The 16 terminal colors

      # black
      color0 #43465A
      color8 #43465A

      # red
      color1 #F38BA8
      color9 #F38BA8

      # green
      color2  #A6E3A1
      color10 #A6E3A1

      # yellow
      color3  #F9E2AF
      color11 #F9E2AF

      # blue
      color4  #87B0F9
      color12 #87B0F9

      # magenta
      color5  #F5C2E7
      color13 #F5C2E7

      # cyan
      color6  #94E2D5
      color14 #94E2D5

      # white
      color7  #CDD6F4
      color15 #A1A8C9

      bold_font        auto
      italic_font      auto
      bold_italic_font auto

      font_size 9.0
      window_padding_width 25
      #background_opacity 0.60
      #hide_window_decorations yes
      #confirm_os_window_close 0

      enable_audio_bell no

      include color.ini

      font_family      CaskaydiaCove Nerd Font Mono

      disable_ligatures never

      url_color #61afef

      url_style curly

      map ctrl+left neighboring_window left
      map ctrl+right neighboring_window right
      map ctrl+up neighboring_window up
      map ctrl+down neighboring_window down

      map f1 copy_to_buffer a
      map f2 paste_from_buffer a
      map f3 copy_to_buffer b
      map f4 paste_from_buffer b

      cursor_shape beam
      cursor_beam_thickness 1.8

      mouse_hide_wait 3.0
      detect_urls yes

      repaint_delay 10
      input_delay 3
      sync_to_monitor yes

      map ctrl+shift+z toggle_layout stack
      tab_bar_style powerline

      inactive_tab_background #e06c75
      inactive_tab_foreground #000000
      active_tab_background #98c379
      tar_bar_margin_color black

      map ctrl+shift+enter new_window_with_cwd
      map ctrl+shift+t new_tab_with_cwd

      background_opacity 0.95

      shell zsh
    '';
  };
}
