-- ~/.config/nvim/lua/plugins/arduino.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        arduino_language_server = {
          cmd = {
            "arduino-language-server",
            "-cli-config",
            vim.fn.expand("$LOCALAPPDATA") .. "/Arduino15/arduino-cli.yaml",
            "-cli",
            "arduino-cli",
            "-clangd",
            vim.fn.stdpath("data") .. "/mason/bin/clangd.cmd",
            "-fqbn",
            "arduino:avr:uno",
          },
          filetypes = { "arduino" },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
  },
}
