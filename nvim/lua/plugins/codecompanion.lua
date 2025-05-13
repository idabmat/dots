require('codecompanion').setup({
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
    qwen3 = function()
      return require('codecompanion.adapters').extend('ollama', {
        schema = {
          model = {
            default = 'qwen3:latest',
          },
        },
      })
    end,
    coder = function()
      return require('codecompanion.adapters').extend('ollama', {
        schema = {
          model = {
            default = 'deepseek-coder-v2:latest',
          },
        },
      })
    end,
    r1 = function()
      return require('codecompanion.adapters').extend('ollama', {
        schema = {
          model = {
            default = 'deepseek-r1:latest',
          },
        },
      })
    end,
  },
  opts = {
    log_level = 'DEBUG',
  },
})
