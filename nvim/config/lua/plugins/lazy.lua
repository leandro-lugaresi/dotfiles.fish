return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "InsertEnter",
    config = true,
  },
  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufEnter",
    config = {
      highlight = {
        keyword = "bg",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = "BufEnter",
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = {
      text = { spinner = "dots" },
      window = { blend = 0 },
    },
  },
  {
    "danymat/neogen",
    event = "BufEnter",
    keys = {
      { "<leader>nf", "<cmd>Neogen<cr>", noremap = true, silent = true, desc = "Neogen generate docs" },
    },
    config = true,
  },
  {
    "vim-test/vim-test",
    event = "BufEnter",
    keys = {
      { "<leader>ttn", ":TestNearest -v<CR>g", noremap = true, silent = true, desc = "Test Nearest" },
      { "<leader>ttf", ":TestFile -v<CR>g", noremap = true, silent = true, desc = "Test File" },
      { "<leader>tts", ":TestSuite -v<CR>g", noremap = true, silent = true, desc = "Test Suite" },
      { "<leader>ttl", ":TestLast -v<CR>g", noremap = true, silent = true, desc = "Test Last" },
      { "<leader>ttv", ":TestVisit -v<CR>g", noremap = true, silent = true, desc = "Test Visit" },
    },
    config = function()
      vim.api.nvim_set_var("test#strategy", "neovim")
      vim.api.nvim_set_var("test#neovim#term_position", "vert")
    end,
  },
  {
    "ojroques/vim-oscyank",
    event = "BufReadPost",
    cond = function()
      -- Check if connection is ssh
      return os.getenv("SSH_CLIENT") ~= nil
    end,
    config = function()
      vim.api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        callback = function()
          if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
            vim.cmd([[OSCYankReg +]])
          end
        end,
        group = vim.api.nvim_create_augroup("OSCYank", { clear = true }),
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    config = function()
      require("user.harpoon")
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = {
      window = {
        width = 220,
        options = {
          number = true,
          relativenumber = true,
        },
        plugin = {
          gitsigns = true,
        },
      },
    },
  },
  {
    "tpope/vim-fugitive",
    command = "Git",
    keys = {
      { "<leader>gs", vim.cmd.Git, noremap = true, silent = true, desc = "Open Git" },
    },
    config = function()
      require("user.fugitive")
    end,
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, noremap = true, silent = true, desc = "Toggle undotree" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      { "<leader>tv", "<cmd>Neotree toggle<cr>", noremap = true, silent = true, desc = "NeoTree" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = {
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      },
    },
  },
  {
    "mhinz/vim-sayonara",
    cmd = "Sayonara",
    keys = {
      { "<leader>q", ":Sayonara!<CR>", noremap = true, silent = true, desc = "NeoTree" },
    },
  },
  { "tpope/vim-abolish", event = "BufEnter" },
  { "editorconfig/editorconfig-vim", event = "BufEnter" },
  { "tpope/vim-repeat", event = "BufEnter" },
  { "tpope/vim-eunuch", event = "BufEnter" },
  { "tpope/vim-sleuth", event = "BufEnter" },
  { "tpope/vim-speeddating", event = "BufEnter" },
}