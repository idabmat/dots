{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Igor de Alcântara Barroso";
    userEmail = "igor@talimhq.com";
    delta = {
      enable = true;
      options = {
        side-by-side = true;
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
