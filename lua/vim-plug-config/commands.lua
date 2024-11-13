-- Copyright 2024 Yufan You
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0

local M = {}

local edit = require('vim-plug-config.edit')
local load = require('vim-plug-config.load')
local view = require('vim-plug-config.view')
local clean = require('vim-plug-config.clean')

function M.setup()
  vim.api.nvim_create_user_command('PlugConfigEdit', function(opts)
    edit.edit_config(opts.args)
  end, { nargs = 1 })

  vim.api.nvim_create_user_command('PlugConfigEditUnderCursor', edit.edit_under_cursor, {})

  vim.api.nvim_create_user_command('PlugConfigLoad', function(opts)
    load.load_single(opts.args)
  end, { nargs = 1 })

  vim.api.nvim_create_user_command('PlugConfigLoadAll', load.load_all, {})

  vim.api.nvim_create_user_command('PlugConfigAll', view.show_all, {})

  vim.api.nvim_create_user_command('PlugConfigClean', clean.clean, {})
end

return M
