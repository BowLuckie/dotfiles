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
            vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
            "-cli",
            "arduino-cli",
            "-clangd",
            vim.fn.stdpath("data") .. "/mason/bin/clangd",
            "-fqbn",
            "teensy:avr:teensy40",
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
