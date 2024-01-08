{
  config,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.avi = {
    description = "Victor Ruiz";
    initialPassword = "nixos";
    isNormalUser = true;
    uid = 1000;
    shell =
      if config.services.greetd.enable
      then pkgs.zsh
      else pkgs.bash;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
        "input"
      ]
      ++ ifTheyExist [
        "network"
        "networkmanager"
        "mysql"
        "git"
        "vboxusers"
      ];

    packages = [pkgs.home-manager];
  };

  home-manager.users.avi = import ../../../home/avi;
}
