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
    :execute "vimgrep /" . expand("<cword>") . "/j *.cc"
    :copen
endfunction

map <leader>g :call CGrepR()<CR>


