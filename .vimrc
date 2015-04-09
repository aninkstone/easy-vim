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

set incsearch
set hlsearch
filetype plugin indent on
set fileformat=unix
set expandtab
set tabstop=4
set softtabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set color scheme
":if has("gui")
"    :colorscheme lucius
":else
"    :colorscheme desert
":endif
colorscheme desert
"colorscheme zenburn

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif


let $HTTP_PROXY="https://localhost:3000/"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Initial ctags
if $TAGS_PATH != ""
    set tags=$TAGS_PATH
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Key maps"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Insert current time format yy-mm-dd hh:mm:ss
map <F2> a<C-R>=strftime("%c")<CR><Esc>
"List the recently opened files
"Need MRU plugin [http://www.vim.org/scripts/script.php?script_id=521]
map <F4> :MRU<cr>
"TlistToggle
"Need taglist plugin [http://www.vim.org/scripts/script.php?script_id=273]
map <F6> :TlistToggle<cr>

if has ("gui")
    set go=
endif

function! JapaneseEncoding ()
    if has ('WIN32')
        set encoding=cp932
    elseif has ('unix')
        set encoding=utf-8
    else
        set encoding=utf-8
    endif
    set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
    set termencoding=utf-8
    let $LANG='ja'
endfunction

function! ChineseEncoding ()
    if has ('WIN32')
        set encoding=cp936
    elseif has ('unix')
        set encoding=euc-cn
    else
        set encoding=latin1
    endif
    set fileencodings=utf-8,gb2312,gbk,gb18030
    set termencoding=utf-8
    let $LANG='zh-CN'
endfunction

function! StartGDB()
    :syntax enable			        " enable syntax highlighting
    :set previewheight=12		    " set gdb window initial height
    :run macros/gdb_mappings.vim	" source key mappings listed in this
    :set asm=0				        " don't show any assembly stuff
    :set gdbprg=gdb_invocation		" set GDB invocation string (default 'gdb')
    :set gdbprg=gdb\ --args\ a.exe
    :call gdb (" ")
endfunction

map <F8> :call StartGDB () <CR>

map lcd :cd %:p:h<CR>

