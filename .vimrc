"
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
set ff=unix

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
"set default encoding to utf-8 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has ('win32')
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=chinese
    set fileencodings=ucs-bom,utf-8,chinese
    set langmenu=zh_CN.utf-8
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_cn.utf-8
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    "set guifont=Consolas:h12:cANSI
    "set guifont=Courier\ New\ 12
    if has('win32')
        "set guifont=Inconsolata-g_for_Powerline:h12:cANSI
        set guifont=Droid_Sans_Mono_Dotted_for_Powe:h12:cANSI
    else
        set guifont=Inconsolata-g\ for\ Powerline\ Medium\ 12
    endif
else
    set t_Co=256
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
  if has ("win32")
      set runtimepath+=$VIM\vimfiles\bundle\neobundle.vim
  else
      set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gtags_VerticalWindow    open windows vitically
"let Gtags_VerticalWindow = 1 
" Gtags_Auto_Map          use a suggested key-mapping
" let Gtags_Auto_Map = 1
" Gtags_Auto_Update       keep tag files up-to-date automatically
let Gtags_Auto_Update = 1
" Gtags_No_Auto_Jump      don't jump to the first tag at the time of search
let Gtags_No_Auto_Jump = 1

:nmap <leader>gc :cclose<CR>
:nmap <leader>gt :Gtags<SPACE>
:nmap <leader>gf :Gtags -f %<CR>
:nmap <leader>gg :GtagsCursor<CR>
:nmap <C-n> :cn<CR>
:nmap <C-p> :cp<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:nmap <F4> :MRU<cr>

" Required:
if has ("win32")
    call neobundle#begin(expand('$VIM\vimfiles\bundle\'))
else 
    call neobundle#begin(expand('~/.vim/bundle/'))
endif

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/Mark--Karkat'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'vim-scripts/DrawIt'
NeoBundle 'vim-scripts/EasyGrep'
NeoBundle 'chrisbra/csv.vim'
NeoBundle 'aceofall/gtags.vim'
NeoBundle 'vim-scripts/mru.vim'
NeoBundle 'gregsexton/gitv'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'

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
"Ack
let g:ackprg = 'ag --vimgrep'

"Ctrl-P
" Setup some default ignores
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
            \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
            \}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
"nmap <leader>be :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
"nmap <leader>bs :CtrlPMRU<cr>
nmap <leader>bb :CtrlPBookmarkDir<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"git configure
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gl :Git! log --all --oneline --graph<cr>
nmap <leader>gb :Git! branch -a<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gk :Gitv<cr>
nmap <tab> :NERDTree<cr>

"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

if !has("gui_running")
    let NERDTreeDirArrows = 0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Areline config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    let g:airline_theme="luna" 
else
    let g:airline_theme="zenburn"
    let g:airline_theme="solarized"
endif
let g:airline_powerline_fonts = 1   

if has ('win32')
    let g:airline_symbols = {}
    "airline symbols
    let g:airline_left_sep = '«ó'
    let g:airline_left_alt_sep = '«ô'
    "let g:airline_right_sep = '«õ'
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = '«ö'
    let g:airline_symbols.branch = '«ã'
    let g:airline_symbols.readonly = '«å'
    let g:airline_symbols.linenr = '«ä'
endif 
"set laststatus=2
