-- Format on write
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
  callback = function(args)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({ async = false, id = args.data.client_id })
      end
    })
  end,
})

vim.lsp.config('expert', {
  cmd = { '/home/me/code/expert/apps/expert/_build/prod/rel/plain/bin/start_expert', '--stdio' },
  root_markers = { 'mix.exs', '.git' },
  filetypes = { 'elixir', 'eelixir', 'heex', 'surface' }
})

vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.env.VIMRUNTIME,
      },
      diagnostics = {
        globals = {
          'vim',
        },
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
        },
      },
    })
  end,
  settings = {
    Lua = {}
  }
})

vim.lsp.config('nil_ls', {
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixfmt' },
      },
    },
  },
})

vim.lsp.enable('bashls')
vim.lsp.enable('cssls')
vim.lsp.enable('dockerls')
vim.lsp.enable('expert')
vim.lsp.enable('gleam')
vim.lsp.enable('gopls')
vim.lsp.enable('html')
vim.lsp.enable('hyprls')
vim.lsp.enable('jsonls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('marksman')
vim.lsp.enable('nil_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('taplo')
vim.lsp.enable('terraformls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('yamlls')
vim.lsp.enable('zls')
