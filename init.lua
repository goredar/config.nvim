if not pcall(require, "impatient") then
  print("Failed to load impatient.")
end

require("options")
require("plugins")
require("plugin-configs")
require("treesitter")
require("completion")
require("keybinds")
