require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono NF Medium"
end
