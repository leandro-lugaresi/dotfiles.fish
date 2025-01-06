-- get neotest namespace (api call creates or returns namespace)
local neotest_ns = vim.api.nvim_create_namespace("neotest")

vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)

local goConfig = {
  testify_enabled = true,
}

---@diagnostic disable-next-line: missing-fields
require("neotest").setup({
  -- your neotest config here
  adapters = {
    require("neotest-golang")(goConfig),
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "✘",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "✓",
    running = "",
    running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
    skipped = "↓",
    unknown = "",
  },
  status = {
    enabled = true,
    signs = true,
    virtual_text = true,
  },
  floating = {
    enabled = true,
    border = "rounded",
    max_height = 0.9,
    max_width = 0.9,
    options = {},
  },
  -- output = { open_on_run = true },
  quickfix = {
    enabled = true,
    open = function()
      vim.cmd("Trouble quickfix")
    end,
  },
})
