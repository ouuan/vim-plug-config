" Copyright 2021 Yufan You
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0

fun! s:IsFileEmpty(path)
    return join(readfile(a:path)) == ""
endfun

fun! plug_config#clean#Clean()
    let deleteList = []
    let vimList = split(glob(g:plug_config_vim_dir . "/*.vim"))
    let luaList = split(glob(g:plug_config_lua_dir . "/*.lua"))
    for path in vimList + luaList
        let base = fnamemodify(path, ":t:r")
        if !has_key(g:plugs, base) || s:IsFileEmpty(path)
            let deleteList += [path]
        endif
    endfor
    if len(deleteList) && confirm("Delete the following files?\n\n" . join(deleteList, "\n") . "\n", "&Yes\n&No", 2) == 1
        for path in deleteList
            call delete(path)
        endfor
    endif
endfun

