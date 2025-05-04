require('codecompanion').setup({
  strategies = {
    chat = {
      adapter = 'r1',
    },
    inline = {
      adapter = 'r1',
    },
    cmd = {
      adapter = 'r1',
    },
  },
  adapters = {
    r1 = function()
      return require('codecompanion.adapters').extend('ollama', {
        schema = {
          model = {
            default = 'deepseek-r1:latest',
          },
        },
      })
    end
  },
  opts = {
    log_level = 'DEBUG',
  },
})
