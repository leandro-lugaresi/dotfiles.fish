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
      "stevearc/conform.nvim",

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
  {
    "vuki656/package-info.nvim",
    event = "BufReadPre",
    config = function()
      require("package-info").setup()
    end,
    keys = {
      -- Show dependency versions
      -- vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true })
      --
      -- -- Hide dependency versions
      -- vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true })
      --
      -- -- Toggle dependency versions
      -- vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { silent = true, noremap = true })
      --
      -- -- Update dependency on the line
      -- vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update, { silent = true, noremap = true })
      --
      -- -- Delete dependency on the line
      -- vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete, { silent = true, noremap = true })
      --
      -- -- Install a new dependency
      -- vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install, { silent = true, noremap = true })
      --
      -- -- Install a different dependency version
      -- vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version, { silent = true, noremap = true })

      { "<leader>Ns", "<cmd>lua require('package-info').show()<CR>", desc = "Show dependency versions" },
      { "<leader>Nc", "<cmd>lua require('package-info').hide()<CR>", desc = "Hide dependency versions" },
      { "<leader>NT", "<cmd>lua require('package-info').toggle()<CR>", desc = "Toggle dependency versions" },
      { "<leader>Nu", "<cmd>lua require('package-info').update()<CR>", desc = "Update dependency on the line" },
      { "<leader>Nd", "<cmd>lua require('package-info').delete()<CR>", desc = "Delete dependency on the line" },
      { "<leader>Ni", "<cmd>lua require('package-info').install()<CR>", desc = "Install a new dependency" },
      {
        "<leader>Np",
        "<cmd>lua require('package-info').change_version()<CR>",
        desc = "Install a different dependency version",
      },
      { "<leader>Nt", ":Telescope package_info<CR>", desc = "Telescope package info" },
    },
  },
}
