{pkgs, ...}: {
  imports = [
    ./fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    alsa-lib
    alsa-plugins
    alsa-tools
    alsa-utils
    arandr
    brightnessctl
    efibootmgr
    efitools
    exfatprogs
    gammastep
    git
    iw
    neovim
    ntfs3g
    ocl-icd
    pamixer
    patchelf
    playerctl
    pciutils
    slop
    smartmontools
    unzip
    usbutils
    tree
    wget
    wirelesstools

    keepassxc

    dbus
    dconf
    ffmpeg-full
    gcc
    glib
    gnumake
    gnuplot
    gnused
    gnutls
    imagemagick
    inotify-tools
    libappindicator
    libcanberra-gtk3
    libgudev
    libnotify
    libsecret
    librsvg
    libtool
    pulseaudio
    zlib

    feh
    xfce.thunar

    pipenv
  ];
}
