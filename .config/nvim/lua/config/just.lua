local just_keymap_keys = {}
local terminal = require("config.terminal")

local function clear_just_keymaps()
  for _, key in ipairs(just_keymap_keys) do
    pcall(vim.keymap.del, "n", "<leader>j" .. key)
  end
  just_keymap_keys = {}
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
    for i = 1, #recipe do
      local candidate = recipe:sub(i, i):lower()
      if candidate:match("%a") and not used[candidate] then
        used[candidate] = true
        return candidate
      end
    end
    used[recipe] = true
    return recipe
  end

  used["j"] = true
  for _, recipe in ipairs(recipes) do
    local key
    if recipe == "default" then
      key = "j"
    else
      key = assign_key(recipe)
    end
    vim.keymap.set("n", "<leader>j" .. key, function()
      if vim.bo.filetype ~= "dashboard" and vim.fn.expand("%") ~= "" then
        vim.cmd("w")
      end
      local buf = terminal.get_or_create_terminal()
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
