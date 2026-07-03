return {
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "jiaoshijie/undotree",
    opts = {
      -- your options
    },
    keys = {
      { "<leader>o", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toogle undotree" },
    },
  },
}
