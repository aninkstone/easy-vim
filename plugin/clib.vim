" Name:     clib.vim (command library)
" Brief:    
" Version:  4.5.0
" Date:     2011/06/10 12:55:57
" Author:   Chen Zuopeng (EN: Daniel Chen)
" Email:    thatways.com@gmail.com
"
" License:  Public domain, no restrictions whatsoever
"
"
function! CGrepR ()
    :silent "vimgrep /" . expand("<cword>") . "/j **/*.cc **/*.h **/*.cpp **/*.c **/*.xml"
    :copen
endfunction

map <leader>g :call CGrepR()<CR>

function! SetEnvironmentUTF8 ()
    :set encoding=utf-8
    :set langmenu=zh_CN.UTF-8
    :language message zh_CN.UTF-8
endfunction

function! SetEnvironmentJapanese ()
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
endfunction

function! SetEnvironmentChinese ()
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

