{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      package = (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; });
      name = "Caskaydia Cove NFM";
      size = 14.0;
    };
    shellIntegration.enableZshIntegration = true;
    settings = {
      enabled_layouts = "tall, fat, grid, vertical, horizontal";
      background_opacity = "0.8";
      allow_remote_control = "yes";
      listen_on = "unix:@mykitty";
      open_url_with = "default";
    };
    theme = "Gruvbox Dark";
    keybindings = {
      "ctrl+enter" = "launch";
      "ctrl+j" = "kitten pass_keys.py bottom ctrl+j";
      "ctrl+k" = "kitten pass_keys.py top ctrl+k";
      "ctrl+h" = "kitten pass_keys.py left ctrl+h";
      "ctrl+l" = "kitten pass_keys.py right ctrl+l";
    };
  };
}
