" Copyright 2021 Yufan You
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0

if exists("g:vim_plug_config_defined")
    finish
endif
let g:vim_plug_config_defined = 1

if !exists("g:plugs")
    finish
endif

fun! s:SetDefault(variable, default)
    if !exists(a:variable)
        let {a:variable} = a:default
    endif
endf

call s:SetDefault("g:plug_config_autoload", 1)
call s:SetDefault("g:plug_config_vim_dir", stdpath("config") . "/plug-config")
call s:SetDefault("g:plug_config_lua_dir", stdpath("config") . "/plug-config")
call s:SetDefault("g:plug_config_edit_command", "edit")
call s:SetDefault("g:plug_config_default_type", "smart")

command! -nargs=1 -bar PlugConfigEdit call plug_config#edit#EditConfig(<args>)
command! -nargs=0 -bar PlugConfigEditUnderCursor call plug_config#edit#PlugConfigEditUnderCursor()
command! -nargs=1 -bar PlugConfigLoad call plug_config#load#LoadSingleConfig(<args>)
command! -nargs=0 -bar PlugConfigLoadAll call plug_config#load#LoadPlugConfigs()

if g:plug_config_autoload
    PlugConfigLoadAll
endif
