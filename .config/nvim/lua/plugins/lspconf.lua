return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },
  },
  opts = function()
    local ret = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.HINT] = "H",
            [vim.diagnostic.severity.INFO] = "I",
          },
        },
      },
      inlay_hints = {
        enabled = true,
        exclude = { "vue" },
      },
      codelens = {
        enabled = false,
      },
      folds = {
        enabled = false,
      },
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        ["*"] = {
          capabilities = {
            workspace = {
              fileOperations = {
                didRename = true,
                willRename = true,
              },
            },
          },
          keys = {
            { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
            {
              "gr",
              function()
                require("snacks").picker.lsp_references()
              end,
              desc = "References",
              nowait = true,
            },
            { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
            { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
            { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
            { "K", vim.lsp.buf.hover, desc = "Hover" },
            { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
            { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" } },
            { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" } },
            { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = "n" },
            { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },

            {
              "<leader>cl",
              function()
                require("snacks").picker.lsp_config()
              end,
              desc = "LSP Config",
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
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
          mason = false,
        },
        nixd = {
          mason = false,
          cmd = { "nixd" },
          settings = {
            nixd = {
              nixpkgs = {
                expr = "import <nixpkgs> {}",
              },
            },
          },
        },
      },
      setup = {},

      -- rust is done through plugins/rust.lua, rustaceanvim
    }
    return ret
  end,
  config = function(_, opts)
    -- attach lsp-only keymaps per-buffer, scoped to capability
    local capability_for_key = {
      ["gd"] = "textDocument/definition",
      ["gr"] = "textDocument/references",
      ["gI"] = "textDocument/implementation",
      ["gy"] = "textDocument/typeDefinition",
      ["gD"] = "textDocument/declaration",
      ["K"] = "textDocument/hover",
      ["gK"] = "textDocument/signatureHelp",
      ["<c-k>"] = "textDocument/signatureHelp",
      ["<leader>ca"] = "textDocument/codeAction",
      ["<leader>cc"] = "textDocument/codeLens",
      ["<leader>cC"] = "textDocument/codeLens",
      ["<leader>cr"] = "textDocument/rename",
    }

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end
        local star = opts.servers["*"]
        if not (star and star.keys) then
          return
        end
        for _, key in ipairs(star.keys) do
          local method = capability_for_key[key[1]]
          if not method or client:supports_method(method) then
            local mode = key.mode or "n"
            vim.keymap.set(mode, key[1], key[2], { desc = key.desc, buffer = args.buf })
          end
        end
      end,
    })

    -- inlay hints
    if opts.inlay_hints.enabled then
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client:supports_method("textDocument/inlayHint") then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end
        end,
      })
    end

    -- folds
    if opts.folds.enabled then
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/foldingRange") then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
          end
        end,
      })
    end

    -- code lens
    if opts.codelens.enabled and vim.lsp.codelens then
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/codeLens") then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = args.buf,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end,
      })
    end

    -- diagnostics
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    if opts.servers["*"] then
      vim.lsp.config("*", opts.servers["*"])
    end

    local have_mason = pcall(require, "mason-lspconfig")
    local mason_all = have_mason
        and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
      or {}
    local mason_exclude = {}

    local function configure(server)
      if server == "*" then
        return false
      end
      local sopts = opts.servers[server]
      sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts

      if sopts.enabled == false then
        mason_exclude[#mason_exclude + 1] = server
        return
      end

      local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
      local setup = opts.setup[server] or opts.setup["*"]
      if setup and setup(server, sopts) then
        mason_exclude[#mason_exclude + 1] = server
      else
        vim.lsp.config(server, sopts)
        if not use_mason then
          vim.lsp.enable(server)
        end
      end
      return use_mason
    end

    local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
    if have_mason then
      require("mason-lspconfig").setup({
        ensure_installed = install,
        automatic_enable = { exclude = vim.list_extend(mason_exclude, { "rust_analyzer" }) },
      })
    end
  end,
}
