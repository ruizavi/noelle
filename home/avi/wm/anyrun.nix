{
  inputs,
  pkgs,
  ...
}: {
  programs.anyrun = {
    enable = true;

    config = {
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
      ];

      width.fraction = 0.3;
      hidePluginInfo = true;
      closeOnClick = true;
      y.absolute = 15;
    };

    extraCss = ''
      * {
        transition: 200ms ease-out;
        color: #cdd6f4;
        font-family: Lexend;
        font-size: 1.1rem;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      #match:selected {
        background: rgba(203, 166, 247, 1);
      }

      #match {
        padding: 3px;
        border-radius: 16px;
      }

      #entry {
        border-radius: 16px;
      }

      box#main {
        background: rgba(30, 30, 46, 1);
        border: 1px solid #28283d;
        border-radius: 24px;
        padding: 8px;
      }

      row:first-child {
        margin-top: 6px;
      }
    '';
  };
}
