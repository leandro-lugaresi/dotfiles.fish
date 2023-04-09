local opt = vim.opt

opt.relativenumber = true
opt.wrap = false
opt.textwidth = 0
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.spell = true
opt.spelllang = { "en_us" }
opt.colorcolumn = "80"

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
