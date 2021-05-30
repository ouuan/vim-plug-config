" Copyright 2021 Yufan You
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0

fun! plug_config#load#LoadSingleConfig(plug)
    let vimPath = plug_config#path#VimConfigPath(a:plug)
    let luaPath = plug_config#path#LuaConfigPath(a:plug)
    if filereadable(vimPath)
        exec "source " . vimPath
    endif
    if filereadable(luaPath)
        exec "luafile " . luaPath
    endif
endfun

fun! plug_config#load#LoadPlugConfigs()
    for plug in g:plugs_order
        call plug_config#load#LoadSingleConfig(plug)
    endfor
endfun
