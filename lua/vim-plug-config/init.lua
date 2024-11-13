-- Copyright 2024 Yufan You
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0

local config = require('vim-plug-config.config')

require('vim-plug-config.commands').setup()

if config.autoload then
  require('vim-plug-config.load').load_all()
end
