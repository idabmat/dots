{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = (builtins.readFile ./init.lua);
    plugins = [
      pkgs.vimPlugins.coq-artifacts
      pkgs.vimPlugins.coq-thirdparty
      {
        plugin = pkgs.vimPlugins.coq_nvim;
        type = "lua";
        config = (builtins.readFile ./plugins/coq_nvim.lua);
      }
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
        type = "lua";
        config = (builtins.readFile ./plugins/nvim-lspconfig.lua);
      }
      pkgs.vimPlugins.vim-kitty-navigator
      pkgs.vimPlugins.vim-gitgutter
      pkgs.vimPlugins.mkdir-nvim
      pkgs.vimPlugins.vim-fugitive
      pkgs.vimPlugins.vim-projectionist
      pkgs.vimPlugins.vim-repeat
      pkgs.vimPlugins.vim-surround
      pkgs.vimPlugins.tcomment_vim
      {
        plugin = pkgs.vimPlugins.nvim-autopairs;
        type = "lua";
        config = (builtins.readFile ./plugins/nvim-autopairs.lua);
      }
      pkgs.vimPlugins.vim-rails
      pkgs.vimPlugins.nvim-web-devicons
      {
        plugin = pkgs.vimPlugins.lualine-nvim;
        type = "lua";
        config = (builtins.readFile ./plugins/lualine-nvim.lua);
      }
      pkgs.vimPlugins.plenary-nvim
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        type = "lua";
        config = (builtins.readFile ./plugins/telescope-nvim.lua);
      }
      pkgs.vimPlugins.telescope-fzf-native-nvim
      {
        plugin = pkgs.vimPlugins.gruvbox-nvim;
        type = "lua";
        config = (builtins.readFile ./plugins/gruvbox-nvim.lua);
      }
      {
        plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
          p.bash
          p.cmake
          p.css
          p.dart
          p.diff
          p.dockerfile
          p.dot
          p.ebnf
          p.eex
          p.elixir
          p.embedded_template
          p.erlang
          p.git_config
          p.git_rebase
          p.gitattributes
          p.gitcommit
          p.gitignore
          p.gleam
          p.gpg
          p.hcl
          p.heex
          p.html
          p.hyprlang
          p.ini
          p.javascript
          p.jq
          p.json
          p.lua
          p.make
          p.markdown
          p.markdown_inline
          p.mermaid
          p.nix
          p.python
          p.rasi
          p.rbs
          p.regex
          p.requirements
          p.ruby
          p.rust
          p.scss
          p.sql
          p.ssh_config
          p.surface
          p.terraform
          p.todotxt
          p.toml
          p.vim
          p.yaml
          p.yuck
          p.zathurarc
        ]);
        type = "lua";
        config = (builtins.readFile ./plugins/nvim-treesitter.lua);
      }
      {
        plugin = pkgs.vimPlugins.vimwiki;
        type = "lua";
        config = (builtins.readFile ./plugins/vimwiki.lua);
      }
      {
        plugin = pkgs.vimPlugins.vim-test;
        type = "lua";
        config = (builtins.readFile ./plugins/vim-test.lua);
      }
    ];
  };
}
