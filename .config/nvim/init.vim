set number
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set splitright
set clipboard=unnamed
set hls
set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8
set mouse=a
set cursorline
set background=dark
set noshowmode

if &term =~ "xterm"
	let &t_SI .= "\e[?2004h"
	let &t_EI .= "\e[?2004l"
	let &pastetoggle = "\e[201~"

	function XTermPasteBegin(ret)
		set paste
		return a:ret
	endfunction

	inoremap <special> <expr> <ESC>[200~ XTermPasteBegin(""))
endif

if &compatible
  set nocompatible     
endif

" Required:
set runtimepath+=/Users/tyautyau56/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/tyautyau56/.cache/dein')
call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})

call dein#end()
if dein#check_install()
  call dein#install()
endif


filetype plugin indent on
syntax enable
colorscheme iceberg

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
nnoremap <C-w> :tabc<CR>
nnoremap <F5> :term cargo run<CR>
