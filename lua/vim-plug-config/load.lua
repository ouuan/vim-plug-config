-- Copyright 2024 Yufan You
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0

local config = require('vim-plug-config.config')
local M = {}

function M.load_single(plug_name)
  local vim_path = config.vim_dir .. '/' .. plug_name .. '.vim'
  local lua_path = config.lua_dir .. '/' .. plug_name .. '.lua'

  if vim.uv.fs_stat(vim_path) then
    vim.cmd('source ' .. vim_path)
  end

  if vim.uv.fs_stat(lua_path) then
    dofile(lua_path)
  end
end

function M.load_all()
  if not vim.g.plugs then return end
  for _, plug in ipairs(vim.g.plugs_order or {}) do
    M.load_single(plug)
  end
end

return M
