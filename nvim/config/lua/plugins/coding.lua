return {
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {
      { "<leader>smb", vim.cmd.SymbolsOutline, noremap = true, silent = true, desc = "Symbols Outline" },
    },
    opts = { width = 25 },
  },
  {
    "williamboman/mason.nvim",
    event = "BufEnter",
    dependencies = {
      -- lsp
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      'stevearc/conform.nvim',

      -- cmp
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-calc",

      -- auto pairs/tags
      "windwp/nvim-autopairs",
      "windwp/nvim-ts-autotag",

      -- cmp x lsp
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",

      -- snip x cmp
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",

      -- hints
      "simrat39/inlay-hints.nvim",

      -- working with neovim config/plugins
      "folke/neodev.nvim",
    },
    config = function()
      require("neodev").setup({})
      require("luasnip").setup({
        -- see: https://github.com/L3MON4D3/LuaSnip/issues/525
        region_check_events = "InsertEnter",
        delete_check_events = "InsertLeave",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("nvim-autopairs").setup({ check_ts = true })
      require("nvim-ts-autotag").setup({ enable = true })
      require("user.lsp")
      require("user.cmp")
      require("user.conform")
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "JellyApple102/easyread.nvim",
    ft = { "text", "markdown" },
    config = function()
      require("easyread").setup({
        fileTypes = { "text", "markdown" },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
    },
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        nextls = { enable = true },
        credo = {},
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = false,
            enableTestLenses = false,
          }),
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
