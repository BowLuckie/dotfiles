if vim.fn.has("win32") == 1 then
  vim.opt.shell = '"C:/Program Files/WindowsApps/Microsoft.PowerShell_7.6.2.0_x64__8wekyb3d8bbwe/pwsh.exe"'
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
else
  vim.opt.clipboard = "unnamedplus"
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.wrap = false

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum"

vim.g.have_nerd_font = true

vim.opt.fillchars = { eob = "~" }

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8

vim.opt.swapfile = false
vim.opt.undofile = true

vim.g.root_spec = { "cwd" }

vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.g.autoformat = true

vim.opt.foldlevelstart = 99

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "NeoTreeGitAdded" })
  end,
})

vim.g.snacks_explorer = false

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer (NeoTree)" })

vim.g.no_ocaml_maps = 1

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

if not vim.treesitter.language.ft_to_lang then
  vim.treesitter.language.ft_to_lang = function(ft)
    return vim.treesitter.language.get_lang(ft) or ft
  end
end
