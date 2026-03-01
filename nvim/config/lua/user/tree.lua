local tree = require("nvim-tree")
local api = require("nvim-tree.api")

local function on_attach(bufnr)
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "<Esc>", api.tree.close, { buffer = bufnr, noremap = true, silent = true, desc = "Close tree" })
end

local function set_win()
  local ratio_h = 0.8
  local ratio_w = 0.5

  local lines = vim.opt.lines:get() - vim.opt.cmdheight:get()
  local col = vim.opt.co:get()
  local window_h = math.floor(lines * ratio_h)
  local window_w = math.floor(col * ratio_w)
  local center_y = math.floor(((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get())
  local center_h = math.floor(((col - window_w) / 2))
  return {
    relative = "editor",
    border = "rounded",
    width = window_w,
    height = window_h,
    row = center_y,
    col = center_h,
  }
end

tree.setup({
  on_attach = on_attach,
  view = {
    centralize_selection = false,
    cursorline = true,
    debounce_delay = 15,
    width = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = set_win(),
    },
  },
})
