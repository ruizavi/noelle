{
  lib,
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./configuration
    ./hardware-configuration.nix
  ];

  boot = {
    initrd = {
      supportedFilesystems = ["btrfs"];
      systemd.enable = true;
      kernelModules = ["amdgpu"];
    };

    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        enableCryptodisk = true;
        configurationLimit = 3;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      acpi
      cryptsetup
      libva
      libva-utils
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];
    etc."greetd/environments".text = ''
      Hyprland
    '';
  };

  hardware = {
    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  networking = {
    hostName = "noelle";
    networkmanager.enable = true;
    useDHCP = false;
  };

  services = {
    acpid.enable = true;
    btrfs.autoScrub.enable = true;
    logind.lidSwitch = "suspend";
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 1;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };

    upower.enable = true;
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "avi";
        };
        default_session = initial_session;
      };
    };

    xserver = {
      enable = true;
      libinput = {
        enable = true;
        touchpad = {naturalScrolling = true;};
      };
      desktopManager = {
        xfce.enable = true;
      };
      layout = "us";
      xkbVariant = "altgr-intl";
      videoDrivers = ["amdgpu"];
    };
  };

  system.stateVersion = "23.05";
}
