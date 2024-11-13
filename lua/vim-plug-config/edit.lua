-- Copyright 2024 Yufan You
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0

local config = require('vim-plug-config.config')
local M = {}

local function ensure_dir(path)
  vim.fn.mkdir(path, 'p')
end

function M.edit_config(plug_name)
  if not vim.g.plugs or not vim.g.plugs[plug_name] then return end

  local type = config.default_type
  local vim_path = config.vim_dir .. '/' .. plug_name .. '.vim'
  local lua_path = config.lua_dir .. '/' .. plug_name .. '.lua'

  if type == "smart" then
    type = vim.uv.fs_stat(vim.g.plugs[plug_name].dir .. "/lua") and "lua" or "vim"
  end

  if type == "vim" or type == "both" or vim.uv.fs_stat(vim_path) then
    ensure_dir(config.vim_dir)
    vim.cmd(config.edit_command .. ' ' .. vim_path)
  end

  if type == "lua" or type == "both" or vim.uv.fs_stat(lua_path) then
    ensure_dir(config.lua_dir)
    vim.cmd(config.edit_command .. ' ' .. lua_path)
  end
end

function M.edit_under_cursor()
  local cword = vim.fn.expand('<cWORD>')
  local plug = cword:match("/[%w_.-]+")

  if not plug then
    local line = vim.fn.getline('.')
    plug = line:match("/[%w_.-]+")
  end

  if plug then
    plug = plug:sub(2)
    if vim.g.plugs[plug] then
      M.edit_config(plug)
    end
  end
end

return M
