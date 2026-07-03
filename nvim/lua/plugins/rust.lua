return {
  "mrcjkb/rustaceanvim",
  ft = { "rust" },
  opts = {
    tools = {
      inlay_hints = { only_current_line = true },
    },
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<leader>cR", function()
          vim.cmd.RustLsp("codeAction")
        end, { desc = "Code Action", buffer = bufnr })
        vim.keymap.set("n", "<leader>dr", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })
        vim.keymap.set("n", "<leader>rr", function()
          vim.cmd.RustLsp("runnables")
        end, { desc = "Rust Runnables", buffer = bufnr })
      end,
      default_settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          checkOnSave = true,
          diagnostics = {
            enable = true,
          },
          procMacro = {
            enable = true,
          },
          files = {
            exclude = {
              ".direnv",
              ".git",
              ".jj",
              ".github",
              ".gitlab",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            },
            watcher = "client",
          },
        },
      },
    },
  },
  config = function(_, opts)
    local mason_registry_ok = pcall(require, "mason-registry")
    if mason_registry_ok then
      local codelldb = vim.fn.exepath("codelldb")
      local codelldb_lib_ext = io.popen("uname"):read("*l") == "Linux" and ".so" or ".dylib"
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local library_path = mason_path .. "/opt/lldb/lib/liblldb" .. codelldb_lib_ext
      if codelldb ~= "" then
        opts.dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
        }
      end
    end
    vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    if vim.fn.executable("rust-analyzer") == 0 then
      vim.notify(
        "rust-analyzer not found in PATH, please install it via Mason or your package manager.\nhttps://rust-analyzer.github.io/",
        vim.log.levels.ERROR,
        { title = "rustaceanvim" }
      )
    end
  end,
}
