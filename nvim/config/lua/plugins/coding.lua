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
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot",
    },
    version = "*",
    config = function()
      require("user.cmp")
    end,
  },

  {
    "williamboman/mason.nvim",
    event = "BufEnter",
    dependencies = {
      -- Dependencies for lsp packages
      "nvim-lua/plenary.nvim",

      -- lsp
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "stevearc/conform.nvim",
      "pmizio/typescript-tools.nvim",

      -- auto pairs/tags
      "windwp/nvim-autopairs",
      "windwp/nvim-ts-autotag",

      -- hints
      "simrat39/inlay-hints.nvim",

      -- working with neovim config/plugins
      "folke/neodev.nvim",
    },
    config = function()
      require("neodev").setup({})
      require("nvim-autopairs").setup({ check_ts = true })
      require("nvim-ts-autotag").setup({ enable = true })
      require("user.lsp")
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
        enabled = false,
        auto_trigger = false,
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
    "vuki656/package-info.nvim",
    event = "BufReadPre",
    config = function()
      require("package-info").setup()
    end,
    keys = {
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
