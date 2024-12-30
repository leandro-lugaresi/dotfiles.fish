local darkMode = require("auto-dark-mode")

darkMode.setup({
  update_interval = 3000,
  set_dark_mode = function()
    vim.cmd([[colorscheme catppuccin]])
    require("user.colorscheme")
    require("lualine").setup({
      options = {
        theme = "catppuccin",
      },
    })
    vim.api.nvim_set_option("background", "dark")
    vim.fn.jobstart('yes | fish_config theme save "Catppuccin Mocha"', {
      stdout_buffered = true,
    })
  end,
  set_light_mode = function()
    vim.cmd([[colorscheme catppuccin]])
    require("user.colorscheme")
    require("lualine").setup({
      options = {
        theme = "catppuccin",
      },
    })
    vim.api.nvim_set_option("background", "light")
    vim.fn.jobstart('yes | fish_config theme save "Catppuccin Latte"', {
      stdout_buffered = true,
    })
  end,
})
