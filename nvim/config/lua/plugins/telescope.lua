return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("user.telescope")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-github.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "ThePrimeagen/harpoon",
      "nvim-telescope/telescope-frecency.nvim",
    },
  },
}
