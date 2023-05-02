local lsp_on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local inlay_hints = require("inlay-hints")
local autocmds = require("custom.lsp_autocommands")

inlay_hints.setup({
  renderer = "inlay-hints/render/eol",
  -- https://github.com/simrat39/inlay-hints.nvim/issues/3
  eol = {
    parameter = {
      format = function(hints)
        return string.format(" <- (%s)", hints):gsub(":", "")
      end,
    },
    type = {
      format = function(hints)
        return string.format(" » (%s)", hints):gsub(":", "")
      end,
    },
  },
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  lsp_on_attach(client, bufnr)
  inlay_hints.on_attach(client, bufnr)
  autocmds.on_attach(client, bufnr)
end

lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        fieldalignment = true,
        staticcheck = true,
      },
      codelenses = {
        run_govulncheck = true,
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
})

lspconfig.tsserver.setup({
  on_attach = on_attach,
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})

lspconfig.ltex.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ltex = {
      language = "en-US",
    },
  },
})

lspconfig.yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
    },
  },
})

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      telemetry = { enable = false },
      hint = {
        enable = true,
      },
    },
  },
})

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "jsonls",
  "rust_analyzer",
  "clangd",
  "dockerls",
  "tflint",
  "terraformls",
  "golangci_lint_ls",
  "bashls",
  "jsonls",
  "pyright",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

