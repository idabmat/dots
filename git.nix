{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Igor de Alcântara Barroso";
    userEmail = "igor@talimhq.com";
    signing = {
      key = "7D1685987BD2D2FEC9C5D95E794A41BA3DBE9931";
      signByDefault = true;
    };
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        syntax-theme = "gruvbox-dark";
      };
    };
    extraConfig = {
      github = {
        user = "idabmat";
      };
      pull = {
        rebase = false;
      };
      merge = {
        confictstyle = "diff3";
      };
      init = {
        defaultBranch = "main";
      };
      pager = {
        diff = "delta";
        log = "delta";
        reflog = "delta";
        show = "delta";
      };
    };
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
  };
}
