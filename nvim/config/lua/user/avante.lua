require("avante_lib").load()
require("avante").setup({
  hints = { enabled = false },
  ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
  provider = "claude", -- Recommend using Claude
  auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20241022",
    temperature = 0,
    max_tokens = 4096,
  },
})

-- local opts = { noremap = true, silent = true }
-- local keymap = vim.keymap.set
-- local avante = require("avante.api")
-- keymap("n", "<leader>aa", function()
--   avante.ask()
-- end, opts)
-- keymap("n", "<leader>ar", function()
--   avante.refresh()
-- end, opts)
-- keymap("v", "<leader>ae", function()
--   avante.edit()
-- end, opts)
