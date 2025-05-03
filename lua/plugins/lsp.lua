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

vim.lsp.config('elixirls', {
  cmd = { 'elixir-ls' },
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

vim.lsp.config('tailwindss', {
  cmd = { 'taiwindcss-language-server', '--stdio' },
  filetypes = { 'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'htmlangular', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss', 'stylus', 'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte', 'templ' },
  settings = {
    tailwindCSS = {
      classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
      includeLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        htmlangular = 'html',
        templ = 'html'
      },
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidConfigPath = 'error',
        invalidScreen = 'error',
        invalidTailwindDirective = 'error',
        invalidVariant = 'error',
        recommendedVariantOrder = 'warning'
      },
      validate = true
    }
  }
})

vim.lsp.config('zls', {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'zls.json', 'build.zig', '.git' },
  workspace_required = false,
})

vim.lsp.enable('bashls')
vim.lsp.enable('cssls')
vim.lsp.enable('dockerls')
vim.lsp.enable('elixirls')
vim.lsp.enable('gopls')
vim.lsp.enable('html')
vim.lsp.enable('jsonls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('marksman')
vim.lsp.enable('nil_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('taplo')
vim.lsp.enable('ts_ls')
vim.lsp.enable('yamlls')
vim.lsp.enable('zls')
