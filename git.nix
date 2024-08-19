{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Igor de Alcântara Barroso";
    userEmail = "igor@talimhq.com";
    delta = {
      enable = false;
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

  # programs.gpg = {
  #   enable = true;
  # };
  #
  # services.gpg-agent = {
  #   enable = true;
  #   enableSshSupport = true;
  #   pinentryPackage = pkgs.pinentry-tty;
  # };
}
