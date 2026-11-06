require('codecompanion').setup({
  ignore_warnings = false,
  interactions = {
    chat = {
      adapter = {
        name = "opencode",
        model = "openai/GPT-6 Astra",
      },
      tools = {
        opts = {
          auto_submit_errors = true,
          auto_submit_success = true,
        },
      },
      opts = {
        completion = "cmp",
      },
    },
  },
  opts = {
    log_level = 'DEBUG',
  },
  display = {
    action_palette = {
      prompt = 'Prompt',
      provider = 'telescope',
      opts = {
        show_default_actions = true,
        show_default_prompt_library = true,
      },
    },
    chat = {
      show_settings = false,
    },
  },
})
