local overrides = require("custom.configs.overrides")

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
      suggestion = { enabled = true },
      panel = { enabled = true },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      require("lazyvim.util").on_attach(function(client)
        if client.name == "copilot" then
          copilot_cmp._on_insert_enter()
        end
      end)
    end,
  },
}

return plugins
