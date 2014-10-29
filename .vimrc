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

if has("gui")
    "set guifont=ÐÂËÎÌå:h12:cGB2312
    set guifont=Courier\ 10\ Pitch\ 11
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

"EOF"
"
"set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction
"
"set encoding=utf-8

function! ToggleLang (language)
   if a:language == "jp"
       if has ('WIN32')
           set encoding=cp932
       elseif has ('unix')
           "set encoding=sjis
           set encoding=utf-8
       else
           set encoding=utf-8
           "set encoding=latin1
       endif
       set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
       set termencoding=utf-8
       let $LANG='ja'
   endif
   if a:language == "zh-CN"
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
   endif 
   if expand("%") != ""
       :e
  endif
endfunction 

"map <F7> :call ToggleLang('jp') <CR>
"map <F8> :call ToggleLang('zh-CN') <CR>

function! GDBChanel()
    :syntax enable			        " enable syntax highlighting
    :set previewheight=12		    " set gdb window initial height
    :run macros/gdb_mappings.vim	" source key mappings listed in this
    :set asm=0				        " don't show any assembly stuff
    :set gdbprg=gdb_invocation		" set GDB invocation string (default 'gdb')
    :set gdbprg=gdb\ --args\ /mnt/fat32/development/build/unix/chanel
    :call gdb (" ")
endfunction

map <F8> :call GDBChanel () <CR>

map <leader>h :W3mHistory <CR>
map <leader>w :W3m http://www.google.com/ncr<CR>

