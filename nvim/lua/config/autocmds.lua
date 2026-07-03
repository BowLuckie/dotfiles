-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

local aliases = { "CountLines", "CL", "LC" }

for _, name in ipairs(aliases) do
  vim.api.nvim_create_user_command(name, function(opts)
    local ext = opts.args
    local result = vim.fn.system(string.format("find . -name '*.%s' -exec cat {} + | wc -l", ext))
    vim.notify(string.format("*.%s lines: %s", ext, vim.trim(result)), vim.log.levels.INFO)
  end, { nargs = 1 })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.cmd("echo 'yanked'")
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
