-- Copyright 2024 Yufan You
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0

local M = {
  autoload = true,
  vim_dir = vim.fn.stdpath("config") .. "/plug-config",
  lua_dir = vim.fn.stdpath("config") .. "/plug-config",
  edit_command = "edit",
  default_type = "smart",
  all_header = "Configs for plug: {plug}"
}

for k, v in pairs({
  autoload = "plug_config_autoload",
  vim_dir = "plug_config_vim_dir",
  lua_dir = "plug_config_lua_dir",
  edit_command = "plug_config_edit_command",
  default_type = "plug_config_default_type",
  all_header = "plug_config_all_header"
}) do
  if vim.g[v] ~= nil then
    M[k] = vim.g[v]
  end
end

return M
