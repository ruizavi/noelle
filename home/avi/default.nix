{
  lib,
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.hyprland.homeManagerModules.default
      inputs.anyrun.homeManagerModules.default
      ./shell
      ./wm
      ./gtk.nix
      ./vscode.nix
      ./spotify.nix
      ./gtklock.nix
      ./zathura.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  systemd.user.startServices = "sd-switch";

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  nix = {
    package = lib.mkForce pkgs.nixUnstable;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];

    config = {
      allowUnfree = true;
      allowInsecure = true;
      allowUnfreePredicate = _: true;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  programs.home-manager.enable = true;

  home = {
    username = "avi";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.05";

    packages = with pkgs; [
      spotify
      obsidian
    ];
  };
}
