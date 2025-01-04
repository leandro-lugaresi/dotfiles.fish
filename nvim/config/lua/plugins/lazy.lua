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
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("user.harpoon")
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
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
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
