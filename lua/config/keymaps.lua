-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<F5>", "<cmd>DapContinue<cr>", { desc = "Debug: Continue" })

vim.keymap.set("n", "<leader>gg", function()
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error == 0 then
    vim.cmd("lcd " .. root)
  end
  Snacks.lazygit()
end, { desc = "Lazygit (root)" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.keymap.set({ "n", "i" }, "<F4>", function()
      vim.cmd("w")
      local cwd = vim.fn.expand("%:p:h")
      Snacks.terminal("cargo run; pause", { cwd = cwd })
    end, { desc = "Cargo run", buffer = true })
  end,
})

vim.keymap.set("i", "<A-h>", "<Left>",  { desc = "Move left" })
vim.keymap.set("i", "<A-j>", "<Down>",  { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<Up>",    { desc = "Move up" })
vim.keymap.set("i", "<A-l>", "<Right>", { desc = "Move right" })

vim.keymap.set("n", "<A-J>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-K>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

vim.keymap.set("i", "<Tab>", function()
  local blink = require("blink.cmp")
  if blink.is_visible() then
    blink.accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, { desc = "Tab autocomplete" })
