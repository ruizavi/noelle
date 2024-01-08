{
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./environment.nix
      ./locale.nix
      ./network.nix
      ./nix.nix
      ./pkgs.nix
      ./programs.nix
      ./security.nix
      ./services.nix
      ./users.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowInsecure = true;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
}
