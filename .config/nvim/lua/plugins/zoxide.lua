return {
  "nanotee/zoxide.vim",
  event = "VeryLazy",
  init = function()
    vim.g.zoxide_custom_options = {
      fzf_preview_window = "right:50%",
    }
  end,
  keys = {
    { "<leader>fz", "<cmd>Zoxide<cr>", desc = "Zoxide (recent dirs)" },
  },
}
