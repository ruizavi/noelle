{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      cantarell-fonts
      fira
      lato
      maple-mono
      maple-mono-NF
      maple-mono-SC-NF
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto-slab
      material-symbols
      material-icons
      material-design-icons
      roboto
      iosevka-bin
      (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono" "Monaspace"];})
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "full";
      };

      subpixel.lcdfilter = "default";

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["Maple Mono NF"];
        sansSerif = ["Lato"];
        serif = ["Roboto Slab"];
      };
    };
  };
}
