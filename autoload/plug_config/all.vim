" Copyright 2021 Yufan You
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0

" substitute without E486
fun! s:Substitute(expr, pat, sub, flags)
    try
        return substitute(a:expr, a:pat, a:sub, a:flags)
    catch /E486/
        return expr
    endtry
endfun

fun! s:GetContent(plug, path, comment)
    if filereadable(a:path)
        let result = split(s:Substitute(g:plug_config_all_header, "\{plug\}", a:plug, "g"), "\n")
        let result = map(result, 'a:comment . v:val')
        let result += [""] + readfile(a:path) + [""]
        return result
    else
        return []
    endif
endfun

fun! plug_config#all#ShowAll()
    let vimContent = []
    let luaContent = []
    for plug in g:plugs_order
        let vimContent += s:GetContent(plug, plug_config#path#VimConfigPath(plug), '" ')
        let luaContent += s:GetContent(plug, plug_config#path#LuaConfigPath(plug), '-- ')
    endfor

    if len(vimContent)
        exec g:plug_config_edit_command . " plug-configs.vim"
        set buftype=nofile
        " use [:-2] to remove the last blank line
        call setline(1, vimContent[:-2])
    endif

    if len(luaContent)
        exec g:plug_config_edit_command . " plug-configs.lua"
        set buftype=nofile
        call setline(1, luaContent[:-2])
    endif
endfun
