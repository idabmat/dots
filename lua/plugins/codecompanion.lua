require('codecompanion').setup({
  strategies = {
    chat = {
      adapter = 'r1',
    },
    inline = {
      adapter = 'coder',
    },
    cmd = {
      adapter = 'coder',
    },
  },
  adapters = {
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
