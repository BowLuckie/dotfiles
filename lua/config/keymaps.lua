-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<F5>", "<cmd>DapContinue<cr>", { desc = "Debug: Continue" })

vim.keymap.set("i", "<A-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("n", "<leader>gg", function()
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error == 0 then
    vim.cmd("lcd " .. root)
  end
  Snacks.lazygit()
end, { desc = "Lazygit (root)" })

vim.keymap.set("i", "<A-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<Up>", { desc = "Move up" })
vim.keymap.set("i", "<A-l>", "<Right>", { desc = "Move right" })

vim.keymap.set("n", "<A-J>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-K>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "javascript", "css", "json" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- f4

vim.keymap.set("n", "<F4>", function()
  vim.cmd("w")
  if vim.fn.filereadable("package.json") == 1 then
    Snacks.terminal("npm run dev; echo 'Press enter to exit...'; read", { cwd = vim.fn.getcwd() })
    return
  end
  if vim.bo.filetype == "rust" then
    Snacks.terminal("cargo run; echo 'Press enter to exit...'; read", { cwd = vim.fn.expand("%:p:h") })
    return
  end
  if vim.bo.filetype == "javascript" then
    Snacks.terminal("node " .. vim.fn.expand("%") .. "; echo 'Press enter to exit...'; read", { cwd = vim.fn.expand("%:p:h") })
    return
  end
  vim.notify(
    "No run config for filetype: " .. vim.bo.filetype,
    vim.log.levels.WARN
  )
end)
