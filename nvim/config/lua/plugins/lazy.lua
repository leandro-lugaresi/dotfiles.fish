return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {},
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = true },
        exclude = {
          buftypes = { "terminal", "nofile" },
          filetypes = {
            "help",
            "packer",
            "dashboard",
            "neogitstatus",
            "NvimTree",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "undotree",
            "startify",
            "fugitive",
            "fugitiveblame",
            "gitcommit",
            "packer",
            "neogitstatus",
            "NvimTree",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "undotree",
            "startify",
            "fugitive",
            "fugitiveblame",
            "gitcommit",
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufReadPre",
    config = function()
      local indent = require("mini.indentscope")
      indent.setup({
        symbol = "│",
        draw = {
          animation = indent.gen_animation.none(),
        },
        options = { try_as_border = true },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope" },
    event = "BufReadPost",
    opts = {
      highlight = {
        keyword = "bg",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<c-s>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            pattern = vim.fn.expand("<cword>"),
          })
        end,
        desc = "Flash word",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {
      text = { spinner = "dots_pulse" },
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
    "ojroques/nvim-osc52",
    event = "BufReadPost",
    cond = function()
      -- Check if connection is ssh
      return os.getenv("SSH_CLIENT") ~= nil
    end,
    config = function()
      local osc52 = require("osc52")
      vim.api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        callback = function()
          if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
            osc52.copy_register("+")
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
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
      { "<leader>gs", vim.cmd.Git, noremap = true, silent = true, desc = "Open Git" },
    },
    config = function()
      require("user.fugitive")
    end,
  },
  { "f-person/git-blame.nvim", event = "VeryLazy" },
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
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    keys = {
      { "<leader>tv", "<cmd>NvimTreeFindFileToggle<cr>", noremap = true, silent = true, desc = "nvim-tree Focus" },
      { "<leader>tc", "<cmd>NvimTreeClose<cr>", noremap = true, silent = true, desc = "nvim-tree Close" },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("user.tree")
    end,
  },
  {
    "echasnovski/mini.bufremove",
    version = "*",
    config = function()
      require("mini.bufremove").setup({})
    end,
    keys = {
      {
        "<leader>q",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        noremap = true,
        silent = true,
        desc = "Delete buffer",
      },
    },
  },
  { "asiryk/auto-hlsearch.nvim", event = "VeryLazy", config = true },
  { "tpope/vim-abolish", event = "BufEnter" },
  { "tpope/vim-repeat", event = "BufEnter" },
  { "tpope/vim-eunuch", event = "BufEnter" },
  { "tpope/vim-sleuth", event = "BufEnter" },
  { "tpope/vim-speeddating", event = "BufEnter" },
  {
    "f-person/auto-dark-mode.nvim",
    dev = true,
    config = function()
      require("user.dark_mode")
    end,
    init = function()
      require("auto-dark-mode").init()
    end,
  },
}
