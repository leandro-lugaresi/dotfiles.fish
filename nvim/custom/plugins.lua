local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "NvChad/base46",
    branch = "dev",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("custom.configs.null-ls")
        end,
      },
      { "simrat39/inlay-hints.nvim" },
    },
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "Pocco81/TrueZen.nvim",
    cmd = { "TZAtaraxis", "TZMinimalist" },
    config = function()
      require("custom.configs.truezen")
    end,
  },

  { "f-person/git-blame.nvim", lazy = false },
  { "folke/zen-mode.nvim" },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("custom.configs.harpoon")
    end,
  },
  { "kylechui/nvim-surround", lazy = false },
  { "kdheepak/lazygit.nvim", lazy = false },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "jinh0/eyeliner.nvim",
    lazy = true,
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true,
        dim = true,
      })
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
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
}

return plugins
