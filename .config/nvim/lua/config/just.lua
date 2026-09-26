local build_keymap_keys = {}
local terminal = require("config.terminal")

local function clear_build_keymaps()
  for _, key in ipairs(build_keymap_keys) do
    pcall(vim.keymap.del, "n", "<leader>j" .. key)
  end
  build_keymap_keys = {}
end

local function get_build_files()
  local files = {}

  local justfile = vim.fn.findfile("justfile", ".;")
  if justfile ~= "" then
    table.insert(files, { file = justfile, tool = "just" })
  end

  local makefile = vim.fn.findfile("Makefile", ".;")
  if makefile == "" then
    makefile = vim.fn.findfile("makefile", ".;")
  end

  if makefile ~= "" then
    table.insert(files, { file = makefile, tool = "make" })
  end

  return files
end

local function get_targets(file, tool)
  local targets = {}

  for line in io.lines(file) do
    local target

    if tool == "just" then
      target = line:match("^([%w_-]+):")
    else
      target = line:match("^([%w_%.%-]+)%s*:")
    end

    if target then
      table.insert(targets, target)
    end
  end

  return targets
end

local function setup_build_keymaps()
  clear_build_keymaps()

  local build_files = get_build_files()
  if #build_files == 0 then
    return
  end

  local used = {
    j = true,
  }

  local function assign_key(target)
    for i = 1, #target do
      local candidate = target:sub(i, i):lower()

      if candidate:match("%a") and not used[candidate] then
        used[candidate] = true
        return candidate
      end
    end

    return nil
  end

  for _, build in ipairs(build_files) do
    local targets = get_targets(build.file, build.tool)

    for _, target in ipairs(targets) do
      local key

      if target == "default" or target == "all" then
        key = "j"
      else
        key = assign_key(target)
      end

      if key then
        vim.keymap.set("n", "<leader>j" .. key, function()
          if vim.bo.filetype ~= "dashboard" and vim.fn.expand("%") ~= "" then
            vim.cmd("w")
          end

          local buf = terminal.get_or_create_terminal()
          local job_id = vim.b[buf].terminal_job_id

          if job_id then
            vim.api.nvim_chan_send(job_id, build.tool .. " " .. target .. "\r")
          end

          vim.cmd("startinsert")
        end, {
          desc = build.tool .. " " .. target,
        })

        table.insert(build_keymap_keys, key)
      end
    end
  end
end

vim.api.nvim_create_user_command("BuildKeymapsReload", setup_build_keymaps, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    "justfile",
    "Makefile",
    "makefile",
  },
  callback = setup_build_keymaps,
})

vim.api.nvim_create_autocmd("DirChanged", {
  callback = setup_build_keymaps,
})

vim.keymap.set("n", "<leader>jR", "<cmd>BuildKeymapsReload<CR>", { desc = "reload build keymaps" })

setup_build_keymaps()
