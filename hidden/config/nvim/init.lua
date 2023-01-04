vim.opt.nocompatible = true
vim.g.mapleader = '<space>'

-- No backup or temp files
vim.opt.nobackup = true
vim.opt.nowb = true
vim.opt.noswapfile = true

-- No annoying sound on errors
vim.opt.noerrorbells = true
vim.opt.novisualbell = true

vim.g.$LANG = 'en'
vim.opt.langmenu = 'en'
vim.opt.encoding = 'utf8'
vim.opt.ffs = 'unix'

vim.opt.ai = true
vim.opt.si = true
vim.opt.wrap = true

vim.opt.history=500

-- Auto install plugin manager
local install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone --depth 1 https://github.com/savq/paq-nvim.git '..install_path)
end

cmd 'packadd paq-nvim'
local Plug = require('paq-nvim').paq

vim.g.zenburn_subdued_LineNr = 1
Plug {'jnurmine/Zenburn'}
Plug {'nelstrom/vim-visual-star-search'}
Plug {'neovim/nvim-lspconfig'}

-- Auto install and clean plugins
require('paq-nvim').install()
require('paq-nvim').clean()

vim.cmd 'au ColorScheme * hi ColorColumn guibg=darkgray ctermbg=8'
vim.cmd 'au ColorScheme * set colorcolumn=80'
vim.cmd 'au ColorScheme * set cursorline'
vim.cmd 'au BufNewFile,BufRead *.yml setlocal sw=2'
vim.cmd 'au BufNewFile,BufRead *.yml setlocal ts=2'

vim.opt.background='dark'
vim.opt.t_Co=256
vim.cmd 'colorscheme zenburn'

vim.opt.sw=4
vim.opt.ts=4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.mouse='a'
vim.opt.number = true
