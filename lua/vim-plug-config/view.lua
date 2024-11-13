-- Copyright 2024 Yufan You
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0

local config = require('vim-plug-config.config')
local M = {}

local function get_content(plug, path, comment)
  if vim.uv.fs_stat(path) then
    local f = io.open(path, "r")
    if not f then return {} end

    local header = config.all_header:gsub("{plug}", plug)
    local lines = { comment .. header, "" }

    for line in f:lines() do
      table.insert(lines, line)
    end

    f:close()
    table.insert(lines, "")
    return lines
  end
  return {}
end

function M.show_all()
  local vim_content = {}
  local lua_content = {}

  for _, plug in ipairs(vim.g.plugs_order or {}) do
    local vim_path = config.vim_dir .. '/' .. plug .. '.vim'
    local lua_path = config.lua_dir .. '/' .. plug .. '.lua'

    vim.list_extend(vim_content, get_content(plug, vim_path, '" '))
    vim.list_extend(lua_content, get_content(plug, lua_path, '-- '))
  end

  if #vim_content > 0 then
    vim.cmd(config.edit_command .. ' plug-configs.vim')
    vim.bo.buftype = 'nofile'
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim_content)
  end

  if #lua_content > 0 then
    vim.cmd(config.edit_command .. ' plug-configs.lua')
    vim.bo.buftype = 'nofile'
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lua_content)
  end
end

return M
