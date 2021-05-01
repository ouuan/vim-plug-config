" Copyright 2021 Yufan You
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0

fun! plug_config#edit#EditConfig(plug)
    let type = g:plug_config_default_type
    let vimPath = plug_config#path#VimConfigPath(a:plug)
    let luaPath = plug_config#path#LuaConfigPath(a:plug)
    if type == "smart"
        if isdirectory(g:plugs[a:plug].dir . "lua")
            let type = "lua"
        else
            let type = "vim"
        endif
    endif
    if type == "vim" || type == "both" || filereadable(vimPath)
        call mkdir(g:plug_config_vim_dir, "p")
        exec g:plug_config_edit_command . " " . vimPath
    endif
    if type == "lua" || type == "both" || filereadable(luaPath)
        call mkdir(g:plug_config_lua_dir, "p")
        exec g:plug_config_edit_command . " " . luaPath
    endif
endfun

fun! plug_config#edit#PlugConfigEditUnderCursor()
    let regex = "/[a-zA-Z0-9_.-]*"
    let plug = matchstr(expand("<cWORD>"), regex)[1:]
    if has_key(g:plugs, plug)
        call plug_config#edit#EditConfig(plug)
    else
        let plug = matchstr(getline("."), regex)[1:]
        if has_key(g:plugs, plug)
            call plug_config#edit#EditConfig(plug)
        endif
    endif
endfun
