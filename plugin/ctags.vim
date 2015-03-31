" Name:     ctags.vim (ctags vim extends script)
" Brief:    Usefull tools reading code or coding
" Version:  4.5.0
" Date:     2011/06/10 12:55:57
" Author:   Chen Zuopeng (EN: Daniel Chen)
" Email:    thatways.c@gmail.com
"
" License:  Public domain, no restrictions whatsoever
"
" Copyright:Copyright (C) 2009-2010 Chen Zuopeng {{{
"           Permission is hereby granted to use and distribute this code,
"           with or without modifications, provided that this copyright
"           notice is copied with it. Like anything else that's free,
"           ctags.vim is provided *as is* and comes with no
"           warranty of any kind, either expressed or implied. In no
"           event will the copyright holder be liable for any damages
"           resulting from the use of this software. 
"           }}}
" Todo:     Auto generate ctags database, and easy to use {{{
"           }}}
" Usage:    This file should reside in the plugin directory and be {{{
"           automatically sourced.
"           You may use the default keymappings of
"
"             <Leader>sy         - Auto synchronize files from current directory recursively.
"             <Leader>sc         - Opens config window
"
"           }}}
" UPDATE:   
"           1.0.0 
"             Rewrite ctags & remove cscope support, since creating cscope
"             database cost too much time 
"           }}}
"-------------------------------------------CCVEXT-----------------------------------------
"
"
" Check for Vim version 700 or greater {{{
"if exists("g:ctags_version")
"    finish
"endif
let g:ctags_version = "1.0.0"

if v:version < 700
    echo "Sorry, ctags" . g:ctags_version. "\nONLY runs with Vim 7.0 and greater."
    finish
endif

"}}}
"Global value declears {{{
let s:functions = {'_command':{}}
"let s:symbs_dir_name = '.symbs'
"}}}
"Initialization local variable platform independence {{{
let s:platform_inde = {
            \'win32':{
                \'slash':'\', 'HOME':'\.symbs', 'list_f':'\.symbs\.list', 'env_f':'\.symbs\.env'
                \},
            \'unix':{
                \'slash':'/', 'HOME':$HOME . '/.symbs', 'list_f':$HOME . '/.symbs/.l', 'env_f':$HOME . '/.symbs/.evn'
                \},
            \'setting':{
                \'tags_l':['./tags']
                \},
            \'tmp_variable':0
            \}
"}}}
"Platform check {{{
if has ('win32')
    let s:platform = 'win32'
else
    let s:platform = 'unix'
endif
"}}}
"support postfix list {{{
let s:postfix = ['"*.java"', '"*.h"', '"*.c"', '"*.hpp"', '"*.cpp"', '"*.cc"', '"*.cs"', '"*.js"']
"}}}
"Check software environment {{{
if !executable ('ctags')
    echomsg 'Taglist: Exuberant ctags (http://ctags.sf.net) ' .
            \ 'not found in PATH. Plugin is not full loaded.'
endif

if !executable ('ctags')
    finish
endif
"}}}
"
"Add symbs to environment {{{
function! AddSymbs (symbs)
    if a:symbs == ""
        return 'false'
    endif
    "get directory name
    let l:name  = substitute(a:symbs, '^.*' . s:platform_inde[s:platform]['slash'], '', 'g')
    let l:cmp_s = ""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "tags setting
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

   "tags full path
    let l:symbs_t = s:platform_inde[s:platform]['HOME'] . s:platform_inde[s:platform]['slash'] . l:name . s:platform_inde[s:platform]['slash'] . 'tags'
    "echo l:symbs_t

    if filereadable (l:symbs_t) == 0
        echomsg 'Tags not found'
    else
        "if tags database path already set, do nothing
        for l:idx in s:platform_inde['setting']['tags_l']
            "get dir name:
            "eg: 
            "   l:idx = '/home/user/.symbs/boost/tags'
            "   l:cmp_s = boost
            "remove '/tags'
            let l:cmp_s = substitute(l:idx, '\' . s:platform_inde[s:platform]['slash'] . 'tags', '', 'g')
            "remove '/home/user/.symbs/'
            let l:cmp_s = substitute(l:cmp_s, '^.*' . s:platform_inde[s:platform]['slash'], '', 'g')
            if l:cmp_s == l:name
                "tags name alread set
                break
            endif
        endfor
        "tags name not set
        if l:cmp_s != l:name
            call add (s:platform_inde['setting']['tags_l'], l:symbs_t)
        else
        endif

        let $TAGS_PATH = ''
        for l:idx in s:platform_inde['setting']['tags_l']
            let $TAGS_PATH = $TAGS_PATH . l:idx . ','
        endfor
        echo ':set tags=' . $TAGS_PATH
        :set tags=$TAGS_PATH 
    endif
endfunction
"}}}
"Delete symbs from environment {{{
function! DelSymbs (symbs, rm)
    if a:symbs == ""
        return 'false'
    endif
    "get directory name
    let l:name  = substitute(a:symbs, '^.*' . s:platform_inde[s:platform]['slash'], '', 'g')

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "tags setting
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let l:cmp_s = ""

    "tags full path
    let l:symbs_t = s:platform_inde[s:platform]['HOME'] . s:platform_inde[s:platform]['slash'] . l:name . s:platform_inde[s:platform]['slash'] . 'tags'

    "if tags database path already set, do nothing
    let l:loopIdx = 0
    for l:idx in s:platform_inde['setting']['tags_l']
        "get dir name:
        "eg: 
        "   l:idx = '/home/user/.symbs/boost/tags'
        "   l:cmp_s = boost

        "remove '/tags'
        let l:cmp_s = substitute(l:idx, '\' . s:platform_inde[s:platform]['slash'] . 'tags', '', 'g')
        "remove '/home/user/.symbs/'
        let l:cmp_s = substitute(l:cmp_s, '^.*' . s:platform_inde[s:platform]['slash'], '', 'g')

        if l:cmp_s == l:name
            "if tags name exist remove it
            unlet s:platform_inde['setting']['tags_l'][l:loopIdx]
            break
        endif
        let l:loopIdx = l:loopIdx + 1
    endfor
    "tags name not set
    if l:cmp_s != l:name
        echomsg 'Tags ' . l:symbs_t . ' not set'
    endif

    let $TAGS_PATH = ''
    for l:idx in s:platform_inde['setting']['tags_l']
        let $TAGS_PATH = $TAGS_PATH . l:idx . ','
    endfor
    echo ':set tags=' . $TAGS_PATH
    :set tags=$TAGS_PATH 

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "remove directory
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let l:cmp_s = ""
    if a:rm == 'true'
        let l:l = LoadConfigData(s:platform_inde[s:platform]['env_f'])
        let l:loopIdx = 0
        for l:idx in l:l
            let l:cmp_s = substitute(l:idx, '^.*' . s:platform_inde[s:platform]['slash'], '', 'g')
            if l:cmp_s == l:name
                unlet l:l[l:loopIdx]
                break
            endif
            let l:loopIdx = l:loopIdx + 1
        endfor
        call writefile (l:l, s:platform_inde[s:platform]['env_f'])
        if has ('win32')
            echo system('rd /S /Q ' . s:platform_inde[s:platform]['HOME'] . s:platform_inde[s:platform]['slash'] . l:name)
        else
            echo system('rm -rf ' . s:platform_inde[s:platform]['HOME'] . s:platform_inde[s:platform]['slash'] . l:name)
        endif
        :close!
        call OpenConfigWnd (LoadConfigData(s:platform_inde[s:platform]['env_f']))
    endif
endfunction
"}}}
"Generate tags files {{{
function! ExecCtags (list)
    if (!executable ('ctags'))
        return 'false'
    endif
    let l:cmd = 'ctags -f ' 
                \. s:platform_inde[s:platform]['HOME'] 
                \. s:platform_inde[s:platform]['slash'] 
                \. substitute(getcwd (), '^.*' . s:platform_inde[s:platform]['slash'], '', 'g') 
                \. s:platform_inde[s:platform]['slash'] . 'tags ' 
                \. '-R --c++-kinds=+p --fields=+aiS --extra=+q --tag-relative=no' 
                \. ' -L ' 
                \. s:platform_inde[s:platform]['list_f']

    if 'false' == MakeDirP(s:platform_inde[s:platform]['HOME'] . s:platform_inde[s:platform]['slash'] . substitute(getcwd (), '^.*' . s:platform_inde[s:platform]['slash'], '', 'g'))
        echomsg 'Failed to create directory ' . s:platform_inde[s:platform]['HOME'] . '/' . substitute (getcwd (), '^.*' . s:platform_inde[s:platform]['slash'], '', 'g') . (MakeDirP returned false)'
        return 'false'
    endif
    echo l:cmd
    echo system (l:cmd)
    return 'true'
endfunction
"}}}
"Generate file list {{{
function! MakeList (dir)
    if 'true' == MakeDirP (s:platform_inde[s:platform]['HOME'])
        let l:cmd = s:functions._command[s:platform](a:dir)
        echomsg l:cmd
        let l:list = system (l:cmd)
        call writefile (split(l:list), s:platform_inde[s:platform]['list_f'])
        "redir @a | silent! echo l:list | redir END
        if input ('System Prompt: Do you want to view file list?  Press [y] yes [any key to continue] no : ') == "y"
            "echo @a
            echo l:list
        else
            echo " "
        endif
    endif
    return l:list
endfunction
"}}}
"Generate shell command {{{
function! s:functions._command['win32'] (dir) dict
    let l:cmd = 'dir'
    let l:cmd = l:cmd . ' ' . getcwd () . '\' . s:postfix[1]
    for l:idx in s:postfix
        let l:cmd = l:cmd . ' ' . getcwd () . '\' . l:idx
    endfor
    "remove all '"'
    let l:cmd = substitute(l:cmd, '"', '', 'g')
    let l:cmd = l:cmd . ' /b /s'
    return l:cmd
endfunction
function! s:functions._command['unix'] (dir) dict
    "let l:cmd = '!' . 'find'
    let l:cmd = 'find'
    let l:cmd = l:cmd . ' ' . a:dir . ' ' . '-name'. ' ' . s:postfix[1]
    for l:idx in s:postfix
        let l:cmd = l:cmd . ' ' . '-o -name' . ' ' . l:idx
    endfor
    return l:cmd
endfunction
"}}}
"Create directory {{{
function! MakeDirP (path)
    if !isdirectory (a:path)
        "vim feature exam 
        if !exists ('*mkdir')
            echomsg 'mkdir: this version vim is not support mkdir, ' . 
                        \'please recompile vim or create director yourself: ' . 
                        \a:path 
            return 'false'
        endif
        if mkdir (a:path, 'p') != 0
        "if mkdir (a:path) != 0
            return 'true'
        else
            return 'false'
        endif
    endif
    return 'true'
endfunction
"}}}
"Read records from record file and remove invalid data {{{
function! LoadConfigData (env_f)
    let l:l = []
    if !filereadable (a:env_f)
        return l:l
    endif

    let l:l = readfile (a:env_f)
	let l:returned = []
    if filereadable (a:env_f)
        if !empty (l:l)
            for i in l:l
                "Current directory name
				let l:name  = substitute(i, '^.*' . s:platform_inde[s:platform]['slash'], '', 'g')
                if !filereadable (s:platform_inde[s:platform]['HOME'] . '/' . l:name . '/tags')
                    "Remove record from record_list
					"echo s:platform_inde[s:platform]['HOME'] . '/' . l:name . '/tags'. " file not exist."
                    "call filter (l:l, 'v:val !~ ' . '"' . i . '"')
				else
					call add (l:returned, i)
                endif
            endfor
        endif
        "Write record back
        call writefile (l:returned , a:env_f)
    else
        echomsg 'Not found any database record.'
    endif
    return l:returned
endfunction
"}}}
"Write a new record to file {{{
function! WriteConfig (env_f, newline)
    if a:env_f == '' 
        return 'false'
    endif

    let l:append_l = [a:newline]
    if filereadable (a:env_f)
        let l:update_l = readfile (a:env_f)
    else
        let l:update_l = []
    endif
    for i in l:update_l
        if i == a:newline
            return 'true'
        endif
    endfor
    call extend (l:update_l, l:append_l)
    call writefile (l:update_l, a:env_f)
    return 'true'
endfunction
"}}}
"Close config window {{{
function! CloseConfigWnd ()
    :close!
    if s:platform_inde['tmp_variable'] != -1
        exe s:platform_inde['tmp_variable'] . 'wincmd w'
        let s:platform_inde['tmp_variable'] = -1
    endif
endfunction
"}}}
"Show config window {{{
function! OpenConfigWnd (arg)
    let l:bname = "Help -- [a] Add to environment [d] Delete from environment [D] Delete from environment and remove conspond database files"
    let s:platform_inde['tmp_variable'] = winnr ()
    let l:winnum =  bufwinnr (l:bname)
    "If the list window is open
    if l:winnum != -1
        if winnr() != winnum
            " If not already in the window, jump to it
            exe winnum . 'wincmd w'
        endif
        "Focuse alread int the list window
        "Close window and start a new
        :q!
    endi
    
    setlocal modifiable
    " Open a new window at the bottom
    exe 'silent! botright ' . 8 . 'split ' . l:bname
    0put = a:arg

    " Mark the buffer as scratch
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal nowrap
    setlocal nobuflisted
    normal! gg
    setlocal nomodifiable

    " Create a mapping to control the files
    nmap <buffer><silent><Enter> :call AddSymbs(getline('.')) <CR>
    nmap <buffer><2-LeftMouse>   :call AddSymbs(getline('.')) <CR>

    nmap <buffer><silent>a :call AddSymbs(getline('.'))          <CR>
    nmap <buffer><silent>d :call DelSymbs(getline('.'), 'false') <CR>
    nmap <buffer><silent>D :call DelSymbs(getline('.'), 'true')  <CR>
    "nmap <buffer><silent><ESC> :call CloseConfigWnd() <CR>
endfunction
"}}}
"Synchronize source {{{
function! SynchronizeSource (cur_dir)
    "let l:l = MakeList (getcwd ())
    let l:l = MakeList(a:cur_dir)

    if (empty(l:l))
        let l:output_msg = 'There is no any files found in patten:'
        for l:idx in s:postfix
            let l:output_msg = l:output_msg . ' ' . '[' . l:idx . ']'
        endfor
        echomsg l:output_msg
        return 'false'
    endif

    let l:res_t = ExecCtags (l:l)
    if l:res_t  == 'false'
        echomsg 'Failed to generate ctags database.'
    endif

    if l:res_t == 'true'
        "echo s:platform_inde[s:platform]['env_f']
        call WriteConfig (s:platform_inde[s:platform]['env_f'], getcwd ())
    endif
endfunction
"}}}
" Log the supplied debug message along with the time {{{
function! DevLogOutput (msg, list)
endfunction
"}}}
"Config Symbs {{{
function! ConfigSymbs ()
    call OpenConfigWnd (LoadConfigData(s:platform_inde[s:platform]['env_f']))
endfunction

function! SyncSource ()
	let l:base_directory = ""
	if has ("gui")
		let l:string = "Specified database base directory:"
		let l:string_len = strlen (l:string)
		let l:expr_len = strlen (getcwd ())
		let l:dlg_size = 0
		if l:expr_len > l:string_len
			let l:dlg_size = l:expr_len - l:string_len
		endif
		if l:dlg_size > 0
			for l:offset in range(l:dlg_size * 2)
				let l:string = l:string . ' '
			endfor
		endif
		let l:base_directory = inputdialog (l:string, getcwd ())
	else
		let l:base_directory = getcwd ()
	endif

	if has ("gui")
		try   | exec "lcd " . escape (escape (escape (escape (escape (escape (escape (escape (escape (l:base_directory, "#"), "!"), "&"), "%"), "$"), "@"), "~"), "("), ")")
			\ | catch /.*/
			\ | echo "The directory [" . l:base_directory . "] not exist, Operation canceled"
			\ | return 
			\ | endtry
	endif

	if l:base_directory != ""
		call SynchronizeSource (l:base_directory)
		call AddSymbs (l:base_directory)
	else
		echo "Operation canceled"
	endif
endfunction
"}}}
"Commands {{{
if !exists(':SyncSource')
	command! -nargs=0 SyncSource :call SyncSource()
endif

if !exists(':SymbsConfig')
	command! -nargs=0 SymbsConfig :call ConfigSymbs()
endif
"}}}
"Hotkey setting {{{
:map <Leader>sy :call SyncSource()   <CR>
:map <Leader>sc :call ConfigSymbs()  <CR>
"}}}
" vim600:fdm=marker:fdc=4:cms=\ "\ %s:
