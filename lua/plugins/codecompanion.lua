require('codecompanion').setup({
  strategies = {
    chat = {
      adapter = 'coder',
    },
    inline = {
      adapter = 'coder',
    },
    cmd = {
      adapter = 'coder',
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
    qwen = function()
      return require('codecompanion.adapters').extend('ollama', {
        schema = {
          model = {
            default = 'qwen2.5-coder:latest',
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
