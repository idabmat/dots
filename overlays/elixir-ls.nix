self: super: {
  elixir-ls = super.elixir-ls.overrideAttrs (oldAttrs: {
    version = "0.29.3";

    src = self.fetchFromGitHub {
      owner = "elixir-lsp";
      repo = "elixir-ls";
      rev = "v0.29.3";
      sha256 = "1jwy188p95f8q75midqf0zbvzgdi93xnri3k64llbbj3v5lp8k4a";
    };

    patches = [ ];
  });
}
