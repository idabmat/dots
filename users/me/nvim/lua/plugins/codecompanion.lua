require('codecompanion').setup({
  strategies = {
    chat = {
      adapter = 'my_openai',
      tools = {
        opts = {
          auto_submit_errors = true,
          auto_submit_success = true,
        },
      },
    },
    inline = {
      adapter = 'my_openai',
    },
    agent = {
      adapter = 'my_openai',
    },
    cmd = {
      adapter = 'my_openai',
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
    my_openai = function()
      return require('codecompanion.adapters').extend('openai_compatible', {
        schema = {
          model = {
            default = 'qwen3:latest',
          },
        },
      })
    end,
    opts = {
      show_model_choices = true,
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
