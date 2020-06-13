if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
    call dein#add('https://github.com/Shougo/unite.vim')
    call dein#add('https://github.com/nathanaelkane/vim-indent-guides')
    call dein#add('https://github.com/tomasr/molokai')
    call dein#add('preservim/nerdtree')
    call dein#add('https://github.com/tpope/vim-fugitive')
    call dein#add('https://github.com/Shougo/neocomplete.vim')
    call dein#add('https://github.com/hokaccha/vim-html5validator')
    call dein#add('https://github.com/tpope/vim-surround')
    call dein#add('https://github.com/tpope/vim-obsession')
    call dein#add('https://github.com/vim-airline/vim-airline')
    call dein#add('https://github.com/vim-airline/vim-airline-themes')

    endif
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
set background=dark
colorscheme solarized 
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double
set cursorline
set backspace=indent,eol,start
set laststatus=2
set clipboard+=unnamed

set showmatch
set wildmenu
set history=5000
set hidden
set number
set smartindent
set noshowmode
set ttimeoutlen=50
set ambiwidth=double

if has('mouse')
	set mouse=a
	if has('mouse_sgr')
		set ttymouse=sgr
	elseif v:version > 703 || v:version is 703 && has('patch632')
	        set ttymouse=sgr
	else
		set ttymouse=xterm2
	endif
endif

if &term =~ "xterm"
	let &t_SI .= "\e[?2004h"
	let &t_EI .= "\e[?2004l"
	let &pastetoggle = "\e[201~"

	function XTermPasteBegin(ret)
	    set paste
	    return a:ret
	endfunction

	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

let g:dein#auto_recache = 1

let g:airline_theme = 'wombat'
set laststatus=2
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_c = '%t'
let g:airline_section_x = '%{&filetype}'
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
set guifont=Roboto\ Mono\ for\ Powerline:h11

