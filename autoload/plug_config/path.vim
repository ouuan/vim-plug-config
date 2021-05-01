" Copyright 2021 Yufan You
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0

fun! plug_config#path#VimConfigPath(plug)
    return resolve(g:plug_config_vim_dir . "/" . a:plug . ".vim")
endfun

fun! plug_config#path#LuaConfigPath(plug)
    return resolve(g:plug_config_lua_dir . "/" . a:plug . ".lua")
endfun
