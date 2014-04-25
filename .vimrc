filetype off

""" Extentions
if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

""" Bundles
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'vim-scripts/SudoEdit.vim'
" syntaxes
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'othree/html5.vim'

filetype plugin indent on
NeoBundleCheck

""" Basic setting
syntax on
colorscheme wombat256mod
set title
set laststatus=2
" indent
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab
set autoindent
set smartindent
set smarttab
" for tmux
set t_ut=

" Show cursor line only in current window.
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinLeave * set nocursorcolumn
	autocmd WinEnter,BufRead * set cursorline
	"autocmd WinEnter,BufRead * set cursorcolumn
augroup END

"leader
let mapleader = " "

""" Unite setting
nnoremap [unite] <Nop>
nmap <leader>u [unite]

nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>Unite file<CR>

" File search via unite.
" http://d.hatena.ne.jp/h1mesuke/20110918/p1
nnoremap <silent> [unite]p :<C-u>call <SID>unite_project('-start-insert')<CR>
function! s:unite_project(...)
	let opts = (a:0 ? join(a:000, ' ') : '')
	let dir = unite#util#path2project_directory(expand('%'))
	execute 'Unite' opts 'file_rec:' . dir
endfunction


