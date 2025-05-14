{ pkgs }:

pkgs.vimUtils.buildVimPlugin {
  name = "mcphub.nvim";
  src = pkgs.fetchFromGitHub {
    owner = "ravitemer";
    repo = "mcphub.nvim";
    rev = "HEAD";
    sha256 = "u7Vv73FfZQqcY6nrS1DtZ8ENwHUWnCQ28FPQ/dTwd2c=";
  };
  nvimSkipModule = [
    "mcphub"
    "mcphub.hub"
    "bundled_build"
    "mcphub.extensions.avante"
    "mcphub.extensions.codecompanion"
    "mcphub.extensions.codecompanion.xml_tool"
    "mcphub.extensions.lualine"
    "mcphub.native.neovim.lsp"
    "mcphub.native.neovim.terminal"
    "mcphub.native.neovim.files.search"
    "mcphub.native.neovim.files.write"
    "mcphub.native.neovim.files.operations"
    "mcphub.native.neovim.files.init"
    "mcphub.native.neovim.files.replace"
    "mcphub.native.neovim.init"
    "mcphub.native.neovim.prompts"
    "mcphub.native.mcphub.init"
    "mcphub.native.mcphub.guide"
  ];
}
