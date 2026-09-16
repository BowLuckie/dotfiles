local M = {}

function M.get_or_create_terminal()
  local marked_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      if vim.b[buf].my_terminal then
        marked_buf = buf
        break
      end
      if not marked_buf then
        marked_buf = buf
      end
    end
  end

  if marked_buf then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == marked_buf then
        vim.api.nvim_set_current_win(win)
        return marked_buf
      end
    end
    vim.api.nvim_set_current_buf(marked_buf)
    return marked_buf
  end

  vim.cmd("term")
  return vim.api.nvim_get_current_buf()
end

return M
