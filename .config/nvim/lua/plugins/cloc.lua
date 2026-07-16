return {
  "gcanoxl/cloc.nvim",
  opts = {
    program = "gocloc",
    projects = {
      { pattern = ".git", include = { "." } },
    },
    autocmds = { "BufWritePost" },
  },
}
