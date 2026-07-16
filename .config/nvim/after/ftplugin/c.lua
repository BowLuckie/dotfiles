local function get_clang_format_indent()
  local clang_format_path = vim.fn.findfile(".clang-format", ".;")
  if clang_format_path == "" then
    return nil
  end
  for line in io.lines(clang_format_path) do
    local width = line:match("IndentWidth:%s*(%d+)")
    if width then
      return tonumber(width)
    end
  end
  return nil
end

local indent = get_clang_format_indent() or 4
vim.opt_local.tabstop = indent
vim.opt_local.shiftwidth = indent
vim.opt_local.softtabstop = indent
vim.opt_local.expandtab = true
