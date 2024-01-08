{
  lib,
  pkgs,
  ...
}: {
  environment = with pkgs; {
    binsh = lib.getExe bash;
    shells = [zsh];
    pathsToLink = ["/share/zsh"];

    loginShellInit = ''
      dbus-update-activation-environment --all
      eval $(gnome-keyring-daemon --start --daemonize --components=pkcs11,secrets,ssh)
      eval $(ssh-agent)
    '';
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
