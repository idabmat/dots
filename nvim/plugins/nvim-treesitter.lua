local configs = require("nvim-treesitter.configs")
configs.setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true,
  }
})
