---@diagnostic disable:undefined-global
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set('n', '<leader><leader>', '<c-^>', {})
vim.opt["grepprg"] = "ag --nogroup --nocolor"
vim["$FZF_DEFAULT_COMMAND"] = 'ag --literal --files-with-matches --nocolor --hidden -g ""'
vim.g.html_indent_tags = "li|p"

local options = {
  number = true,                  -- Line numbers are good
  ruler = true,                   -- show current line,column
  cursorline = true,              -- highlight current line
  cursorcolumn = true,            -- highlight current column
  backspace = "indent,eol,start", -- Allow backpace in insert mode
  history = 1000,                 -- Store lots of :cmdline history
  lazyredraw = true,
  showcmd = true,                 -- Show incomplete cmds down the bottom
  showmode = true,                -- Show current mode down the bottom
  visualbell = true,              -- No sounds
  autoread = true,                -- Reload fils changed outside vim
  autowrite = true,               -- Automatically :write before running commands
  clipboard = "unnamedplus",
  hidden = true,                  -- Make vim act like other editors, buffers in the background
  ttyfast = true,
  autoindent = true,
  smartindent = true,
  smarttab = true,
  shiftwidth = 2,
  softtabstop = 2,
  tabstop = 2,
  expandtab = true,
  textwidth = 100,
  colorcolumn = "+1",
  wrap = true,      -- Wrap lines visually
  linebreak = true, -- Wrap lines at convenient points
  list = true,      -- show invisible non-space whitespace
  wrapmargin = 0,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  backup = false,
  wb = false,
  fdm = 'syntax',
  foldnestmax = 10,
  foldmethod = 'expr',
  foldenable = false,
  incsearch = true,  -- Find the next match as we type the search
  hlsearch = true,   -- Highlight searches by default
  ignorecase = true, -- Ignore case when searching...
  smartcase = true,  -- ...unless we type a capital
  laststatus = 2,
  spellfile = "$HOME/.vim-spell-en.utf-8.add",
  background = 'dark',
  termguicolors = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.formatoptions:remove({ 't' })
vim.opt.complete:append({ kspell = true })  -- Autocomplete with dictionary words when spell check is on
vim.opt.diffopt:append({ vertical = true }) -- Always use vertical diffs

-- Persistent Undo
vim.cmd [[silent !mkdir ~/.local/share/nvim/backups > /dev/null 2>&1]]
vim.opt.undodir = vim.fn.stdpath("data") .. "/backups"
vim.opt.undofile = true

vim.opt.listchars = {
  tab = "»·",
  trail = "·",
  nbsp = "·",
}

vim.cmd [[
  set foldexpr=nvim_treesitter#foldexpr()
]]

vim.g.is_posix = 1

vim.cmd [[
  filetype on
  filetype plugin indent on
  syntax on
]]

vim.cmd [[
  autocmd BufNewFile,BufRead *.slint setfiletype slint
]]

vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end
})

vim.keymap.set('n', '<leader>h', vim.lsp.buf.signature_help, {})
vim.keymap.set('n', '<leader>hh', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, {})
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files)
vim.keymap.set('n', '<leader>fg', telescope.live_grep)
vim.keymap.set('n', '<leader>fb', telescope.buffers)
vim.keymap.set('n', '<leader>fh', telescope.help_tags)
vim.keymap.set('n', '<leader>r', telescope.lsp_references)
vim.keymap.set('n', '<leader>i', telescope.lsp_implementations)
vim.keymap.set('n', '<leader>d', telescope.lsp_definitions)
vim.keymap.set('n', '<leader>td', telescope.lsp_type_definitions)
vim.keymap.set('n', '<leader>dd', telescope.diagnostics)
vim.keymap.set('n', '<leader>gb', telescope.git_branches)
vim.keymap.set('n', '<leader>gs', telescope.git_status)
vim.keymap.set('n', '<leader>gss', telescope.git_stash)
vim.keymap.set('n', '<leader>tt', telescope.treesitter)

vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'vert'
vim.keymap.set('n', '<leader>t', ':TestFile<CR>')
vim.keymap.set('n', '<leader>s', ':TestNearest<CR>')
vim.keymap.set('n', '<leader>l', ':TestLast<CR>')
vim.keymap.set('n', '<leader>a', ':TestSuite<CR>')

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormatting", {}),
  callback = function()
    vim.lsp.buf.format()
  end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig")["elixirls"].setup({
  capabilities = capabilities,
  cmd = { "elixir-ls" },
})
