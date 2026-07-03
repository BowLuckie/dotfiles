-- no treeSHITter is not a typo, this mf is always breaking
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup()
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
