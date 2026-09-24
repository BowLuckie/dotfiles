-- lua/core/utils/terminal.lua (or wherever your terminal module lives)
local M = {}

function M.get_or_create_terminal()
  local terminal_buf

  -- find any terminal buffer
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
      terminal_buf = buf
      break
    end
  end

  -- if terminal is already visible, just focus its window
  if terminal_buf then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == terminal_buf then
        vim.api.nvim_set_current_win(win)
        return terminal_buf
      end
    end
  end

  -- find a normal window that isn't Neo-tree
  local target_win
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype ~= "neo-tree" then
      target_win = win
      break
    end
  end

  -- if we're only in Neo-tree, create a window
  if not target_win then
    vim.cmd("botright split")
    target_win = vim.api.nvim_get_current_win()
  end

  vim.api.nvim_set_current_win(target_win)

  -- jump to existing terminal buffer, or create a fresh one
  if terminal_buf then
    vim.api.nvim_set_current_buf(terminal_buf)
  else
    vim.cmd("term")
  end

  return vim.api.nvim_get_current_buf()
end

return M
