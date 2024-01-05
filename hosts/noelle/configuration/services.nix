{
  lib,
  pkgs,
  ...
}: {
  services = {
    blueman.enable = true;
    udisks2.enable = true;

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr];
    };

    fstrim.enable = true;
    fwupd.enable = true;

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    gvfs.enable = true;

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = lib.mkForce false;
        PermitRootLogin = lib.mkForce "no";
      };
    };

    udev.packages = [pkgs.gnome.gnome-settings-daemon];
  };

  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse = {
      path = [pkgs.pulseaudio];
      wantedBy = ["default.target"];
    };
  };
}
