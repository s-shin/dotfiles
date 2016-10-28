filetype off

""" Extentions
if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

""" dein.vim
" Install dein.vim if not exists
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" Load plugin settings
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" Install plugins
if has('vim_starting') && dein#check_install()
  call dein#install()
endif


filetype plugin indent on

""" Basic setting
syntax on
colorscheme wombat256mod
set title
set laststatus=2
set incsearch
set hlsearch
" http://qiita.com/omega999/items/23aec6a7f6d6735d033f
set backspace=indent,eol,start
" indent
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
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


