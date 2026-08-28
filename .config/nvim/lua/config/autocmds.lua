-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     Snacks.picker.files({ hidden = true, ignored = false })
--   end,
-- })

local aliases = { "CountLines", "CL", "LC" }

for _, name in ipairs(aliases) do
  vim.api.nvim_create_user_command(name, function(opts)
    local ext = opts.args
    local files = vim.fs.find(function(file)
      return vim.fn.fnamemodify(file, ":e") == ext
    end, { limit = math.huge, type = "file", path = vim.fn.getcwd() })
    local total = 0
    for _, f in ipairs(files) do
      total = total + #vim.fn.readfile(f)
    end
    vim.notify(string.format("*.%s lines: %d (%d files)", ext, total, #files), vim.log.levels.INFO)
  end, { nargs = 1 })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
      on_visual = true,
    })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local buf = args.buf
    local name = vim.api.nvim_buf_get_name(buf)
    local real = vim.uv.fs_realpath(name)

    if real and real ~= name then
      vim.api.nvim_buf_set_name(buf, real)
    end
  end,
})
