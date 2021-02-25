let g:zenburn_subdued_LineNr=1
" PLUG
call plug#begin('~/.config/nvim/plug')
Plug 'jnurmine/Zenburn'
call plug#end()
" " Autoinstall plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
" Color
set background=dark
set t_Co=256
set colorcolumn=80
set cursorline
colorscheme zenburn
" Tab
set sw=4
set ts=4
set expandtab
set smartindent
" Backup
set backupdir=~/.local/share/nvim/backup/
" Clipboard
set clipboard=unnamed

" exit terminal mode
tnoremap jk <C-\><C-n>
if !exists("autocommands_loaded")
	let autocommands_loaded = 1
	" directly go to insert mode when swtich to terminal window
	au BufEnter * if &buftype == 'terminal' | :startinsert | endif
	" show _some_ color
	au BufNewFile,BufRead *.fish set ft=sh
endif
