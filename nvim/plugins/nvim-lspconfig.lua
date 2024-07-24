local lspconfig = require('lspconfig')
local coq = require('coq')
lspconfig.bashls.setup(coq.lsp_ensure_capabilities({}))
lspconfig.elixirls.setup(coq.lsp_ensure_capabilities({ cmd = { "language_server.sh" } }))
lspconfig.erlangls.setup(coq.lsp_ensure_capabilities({}))
lspconfig.html.setup(coq.lsp_ensure_capabilities({ filetypes = { "html", "heex" } }))
lspconfig.jsonls.setup(coq.lsp_ensure_capabilities({}))
lspconfig.gleam.setup(coq.lsp_ensure_capabilities({}))
lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({
  cmd = { 'lua-language-server' },
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
}))
lspconfig.nixd.setup(coq.lsp_ensure_capabilities({}))
lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities({
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  }
}))
lspconfig.solargraph.setup(coq.lsp_ensure_capabilities({
  init_options = { formatting = false },
  settings = { solargraph = { diagnostics = false } }
}))
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }),
  callback = function()
    vim.lsp.start {
      name = "standardrb",
      cmd = { "standardrb", "--lsp" },
    }
  end
})
lspconfig.tailwindcss.setup(coq.lsp_ensure_capabilities({}))
lspconfig.terraformls.setup(coq.lsp_ensure_capabilities({}))
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({}))
lspconfig.yamlls.setup(coq.lsp_ensure_capabilities({}))
