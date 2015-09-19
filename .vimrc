"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vim script 
"Create by ChenZuopeng
"Create time 2007-10-27 1:58:37
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Copy right (c) ChenZuopeng
"Email: rlxtime.com@gmail.com chenzuopeng@gmail.com
"Authorization:any can use modify, use, reissue it.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent
set shiftwidth=4
set nobackup
set nowritebackup
set noswapfile
set cino=l1  "switch case indent

set history=100
set showcmd
set incsearch

set backupdir=~/vimtmp,.
set directory=~/vimtmp,.

syntax on
if &t_Co > 2 || has("gui_running")
    :set hlsearch
endif

filetype plugin indent on

set incsearch
set hlsearch
set fileformat=unix
set expandtab
set tabstop=4
set softtabstop=4
set go=m

if has ("gui_running")
    colorscheme desert
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set environment
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has ("win32")
    let $PATH="C:\\MinGW\\msys\\1.0\\bin;C:\\MinGW\\bin;" . $PATH
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    set guifont=Consolas:h12:cANSI
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Key maps"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Insert current time format yy-mm-dd hh:mm:ss
map <F2>  a<C-R>=strftime("%c")<CR><Esc>
"recently opened files
map <leader>lcd :cd %:p:h<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Neo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/Mark--Karkat'
NeoBundle 'kien/ctrlp.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ackprg = 'ag --vimgrep'
