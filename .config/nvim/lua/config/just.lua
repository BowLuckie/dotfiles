local just_keymap_keys = {}

local function clear_just_keymaps()
  for _, key in ipairs(just_keymap_keys) do
    pcall(vim.keymap.del, "n", "<leader>j" .. key)
  end
  just_keymap_keys = {}
end

local function get_or_create_terminal()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
          vim.api.nvim_set_current_win(win)
          return buf
        end
      end
      vim.api.nvim_set_current_buf(buf)
      return buf
    end
  end
  vim.cmd("term")
  return vim.api.nvim_get_current_buf()
end

local function setup_just_keymaps()
  clear_just_keymaps()

  local file = vim.fn.findfile("justfile", ".;") --[[@as string]]
  if file == "" then
    return
  end

  local recipes = {}
  for line in io.lines(file) do
    local recipe = line:match("^([%w_-]+):")
    if recipe then
      table.insert(recipes, recipe)
    end
  end

  local used = {}
  local function assign_key(recipe)
    local key = recipe:sub(1, 1):lower()
    if used[key] then
      local second = recipe:sub(2, 2):lower()
      key = (second ~= "" and not used[second]) and second or recipe
    end
    used[key] = true
    return key
  end

  for _, recipe in ipairs(recipes) do
    local key = assign_key(recipe)
    vim.keymap.set("n", "<leader>j" .. key, function()
      vim.cmd("w")
      local buf = get_or_create_terminal()
      local job_id = vim.b[buf].terminal_job_id
      if job_id then
        vim.api.nvim_chan_send(job_id, "just " .. recipe .. "\r")
      end
      vim.cmd("startinsert")
    end, { desc = "just " .. recipe })
    table.insert(just_keymap_keys, key)
  end
end

vim.api.nvim_create_user_command("JustKeymapsReload", setup_just_keymaps, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "justfile",
  callback = setup_just_keymaps,
})
vim.api.nvim_create_autocmd("DirChanged", { callback = setup_just_keymaps })

vim.keymap.set("n", "<leader>jR", "<cmd>JustKeymapsReload<CR>", { desc = "reload just keymaps" })

setup_just_keymaps()
