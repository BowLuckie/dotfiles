-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.shell = '"C:/Program Files/WindowsApps/Microsoft.PowerShell_7.6.2.0_x64__8wekyb3d8bbwe/pwsh.exe"'
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8

vim.opt.swapfile = false

vim.g.root_spec = { "cwd" }

vim.opt.autowrite = true
vim.opt.autowriteall = true

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        ignoreDir = { ".git", "node_modules", "target" },
      },
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "NeoTreeGitAdded" })
  end,
})

vim.g.snacks_explorer = false

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer (NeoTree)" })
