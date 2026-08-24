vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.wrap = false

vim.opt.incsearch = true
vim.keymap.set("c", "<Esc>", function()
  local cmd = vim.fn.getcmdtype()
  if cmd == "/" or cmd == "?" then
    return "<CR>"
  end
  return "<Esc>"
end, { expr = true })

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum"

vim.opt.termguicolors = true
vim.opt.fillchars = { eob = "~" }
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.autowrite = true
vim.opt.autowriteall = true

vim.opt.foldlevelstart = 99

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { link = "NeoTreeGitAdded" })
  end,
})

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

vim.filetype.add({
  filename = {
    [".clang-format"] = "yaml",
    ["_clang-format"] = "yaml",
    [".clang-tidy"] = "yaml",
  },
})
