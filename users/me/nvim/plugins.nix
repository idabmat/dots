{ pkgs, mcphub-nvim }:

with pkgs.vimPlugins;
[
  {
    plugin = codecompanion-nvim;
    type = "lua";
    config = "require('plugins/codecompanion')";
  }
  cmp-buffer
  cmp-cmdline
  cmp-path
  cmp-nvim-lsp
  cmp_luasnip
  {
    plugin = gitsigns-nvim;
    type = "lua";
    config = "require('plugins/gitsigns')";
  }
  gitsigns-nvim
  {
    plugin = hardtime-nvim;
    type = "lua";
    config = "require('plugins/hardtime')";
  }
  {
    plugin = lualine-nvim;
    type = "lua";
    config = "require('plugins/lualine-nvim')";
  }
  luasnip
  {
    plugin = mcphub-nvim.packages."${pkgs.system}".default;
    type = "lua";
    config = "require('plugins/mcphub')";
  }
  mkdir-nvim
  {
    plugin = neotest;
    type = "lua";
    config = "require('plugins/neotest')";
  }
  neotest-elixir
  {
    plugin = nvim-autopairs;
    type = "lua";
    config = "require('nvim-autopairs').setup({})";
  }
  {
    plugin = nvim-cmp;
    type = "lua";
    config = "require('plugins/cmp')";
  }
  {
    plugin = nvim-lspconfig;
    type = "lua";
    config = "require('plugins/lsp')";
  }
  {
    plugin = (
      nvim-treesitter.withPlugins (p: [
        p.bash
        p.css
        p.dockerfile
        p.elixir
        p.gitcommit
        p.gitignore
        p.gleam
        p.go
        p.hcl
        p.heex
        p.html
        p.hyprlang
        p.javascript
        p.json
        p.lua
        p.mermaid
        p.nix
        p.sql
        p.typescript
        p.yaml
        p.zig
      ])
    );
    type = "lua";
    config = "require('plugins/nvim-treesitter')";
  }
  nvim-web-devicons
  plenary-nvim
  {
    plugin = neovim-ayu;
    type = "lua";
    config = "require('plugins/theme')";
  }
  tcomment_vim
  telescope-nvim
  telescope-fzf-native-nvim
  vim-fugitive
  vim-repeat
  vim-surround
]
