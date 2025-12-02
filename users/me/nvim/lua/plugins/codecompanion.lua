require('codecompanion').setup({
  ignore_warnings = true,
  strategies = {
    chat = {
      adapter = 'qwen3',
      tools = {
        opts = {
          auto_submit_errors = true,
          auto_submit_success = true,
        },
      },
    },
    inline = {
      adapter = 'qwen3',
    },
    agent = {
      adapter = 'qwen3',
    },
    cmd = {
      adapter = 'qwen3',
    },
  },
  extensions = {
    mcphub = {
      callback = 'mcphub.extensions.codecompanion',
      opts = {
        show_result_in_chat = true,
        make_vars = true,
        make_slash_commands = true,
      },
    },
  },
  adapters = {
    http = {
      qwen3 = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'qwen3',
          schema = {
            model = {
              default = 'qwen3-coder:latest',
            },
          },
        })
      end,
      opts = {
        show_model_choices = true,
      },

    }
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
