{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      bfg-repo-cleaner
      colordiff
      gist
      git-filter-repo
      pre-commit
      subversion
      ;

    inherit
      (pkgs.gitAndTools)
      git-absorb
      gitui
      git-machete
      gh
      ;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "avi";
    userEmail = "avi.ruiz@proton.me";

    delta = {
      enable = true;
      options.map-styles = "bold purple => syntax #8839ef, bold cyan => syntax #1e66f5";
    };

    extraConfig = {
      init = {defaultBranch = "main";};
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
      delta = {
        syntax-theme = "Nord";
        line-numbers = true;
      };
      credential.helper = "${pkgs.gitAndTools.gitFull}/bin/git-credential-libsecret";
    };

    aliases = {
      graph = "log --all --decorate --graph --oneline";
    };

    ignores = [
      "*~"
      "*.swp"
      "*result*"
      ".direnv"
      "node_modules"
    ];
  };
}
