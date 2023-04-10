local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      { "simrat39/inlay-hints.nvim"},
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
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
      require "custom.configs.truezen"
    end,
  },

  { "f-person/git-blame.nvim" },
  { "folke/zen-mode.nvim" },
  { "lvimuser/lsp-inlayhints.nvim" },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require "custom.configs.harpoon"
    end,
  },
  { "kylechui/nvim-surround", lazy = false },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "jinh0/eyeliner.nvim",
    lazy = false,
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
        dim = true
      }
    end,
  },
}

return plugins
