-- no treeSHITter is not a typo, this mf is always breaking
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    keys = { { "S", false, mode = "v" } },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "ocaml",
        "python",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.bo[args.buf].syntax = "off"
            vim.b[args.buf].ts_highlight = true
          end
        end,
      })
    end,
  },
}
