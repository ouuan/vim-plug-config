-- Copyright 2024 Yufan You
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0

local config = require('vim-plug-config.config')
local M = {}

local function is_empty_file(path)
  local f = io.open(path, "r")
  if not f then return true end
  local content = f:read("*all")
  f:close()
  return content:gsub("%s", "") == ""
end

function M.clean()
  local to_delete = {}

  for _, ext in ipairs({ 'vim', 'lua' }) do
    local dir = ext == 'vim' and config.vim_dir or config.lua_dir
    local files = vim.fn.glob(dir .. '/*.' .. ext, false, true)

    for _, path in ipairs(files) do
      local name = vim.fn.fnamemodify(path, ':t:r')
      if not vim.g.plugs[name] or is_empty_file(path) then
        table.insert(to_delete, path)
      end
    end
  end

  if #to_delete > 0 then
    local answer = vim.fn.confirm(
      "Delete the following files?\n\n" .. table.concat(to_delete, "\n"),
      "&Yes\n&No",
      2
    )

    if answer == 1 then
      for _, path in ipairs(to_delete) do
        os.remove(path)
      end
    end
  end
end

return M
