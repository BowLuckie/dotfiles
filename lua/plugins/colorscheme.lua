-- return {
--   {
--     "loctvl842/monokai-pro.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {
--       filter = "octagon",
--     },
--     config = function(_, opts)
--       require("monokai-pro").setup(opts)
--       vim.cmd.colorscheme("monokai-pro-octagon")
--     end,
--   },
-- }

return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
