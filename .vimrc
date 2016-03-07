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
  if has ("win32")
      set runtimepath+=$VIM\vimfiles\bundle\neobundle.vim
  else
      set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
endif

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
NeoBundle 'Shougo/unite.vim'
NeoBundle 'hewes/unite-gtags'

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
nmap <leader>be :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
nmap <Tab> :NERDTree<cr>

nmap <leader>t  :!start explorer.exe .<cr>
nnoremap <leader>gg :execute 'Unite gtags/def:'.expand('<cword>')<cr>
nnoremap <leader>gc :execute 'Unite gtags/context'<cr>
nnoremap <leader>gr :execute 'Unite gtags/ref'<cr>
"nnoremap <leader>ge :execute 'Unite gtags/grep'<cr>
"nnoremap <leader>be :execute 'Unite buffer'<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"git configure
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gl :Git! log --all --oneline --graph<cr>
nmap <leader>gb :Git! branch -a<cr>
nmap <leader>gs :Gstatus<cr>
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
"nmap <leader>gk :!start gitk.cmd<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Make netrw really behave like Nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"let g:netrw_banner = 0
"let g:netrw_list_hide = &wildignore
"augroup NetRW
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
