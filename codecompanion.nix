{ pkgs }:

pkgs.vimUtils.buildVimPlugin {
  name = "codecompanion.nvim";
  src = pkgs.fetchFromGitHub {
    owner = "olimorris";
    repo = "codecompanion.nvim";
    rev = "HEAD";
    sha256 = "8ltbsXcYbOu6mKcI9MsV8JSYKUJEKD89GsCLps+ak6k=";
  };
  nvimSkipModule = [
    "codecompanion.adapters.ollama"
    "codecompanion.adapters.githubmodels"
    "codecompanion.adapters.azure_openai"
    "codecompanion.adapters.deepseek"
    "codecompanion.adapters.anthropic"
    "codecompanion.adapters.mistral"
    "codecompanion.adapters.gemini"
    "codecompanion.adapters.huggingface"
    "codecompanion.adapters.openai"
    "codecompanion.adapters.novita"
    "codecompanion.adapters.xai"
    "codecompanion.adapters.copilot"
    "codecompanion.adapters.openai_compatible"
    "codecompanion.http"
    "codecompanion.strategies.inline.init"
    "codecompanion.strategies.cmd"
    "codecompanion.strategies.chat.slash_commands.file"
    "codecompanion.strategies.chat.slash_commands.help"
    "codecompanion.strategies.chat.slash_commands.buffer"
    "codecompanion.strategies.chat.slash_commands.symbols"
    "codecompanion.strategies.chat.slash_commands.fetch"
    "codecompanion.strategies.chat.agents.tools.files"
    "codecompanion.strategies.chat.agents.executor.cmd"
    "codecompanion.strategies.chat.agents.executor.init"
    "codecompanion.strategies.chat.agents.init"
    "codecompanion.strategies.chat.init"
    "codecompanion.strategies.chat.keymaps"
    "codecompanion.providers.slash_commands.default"
    "codecompanion.providers.actions.telescope"
    "codecompanion.providers.actions.snacks"
    "codecompanion.providers.actions.mini_pick"
    "codecompanion.utils.adapters"
    "minimal"
  ];
}
