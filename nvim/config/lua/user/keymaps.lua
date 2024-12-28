-- Shorten function name
local keymap = function(mode, keys, func, desc)
  vim.keymap.set(mode, keys, func, { desc = desc, noremap = true, silent = true })
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", "Leader key")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- disable Ex mode, I always enter in it by mistake
keymap("n", "Q", "<Nop>", "avoid quiting vim")

-- create and edit new buffer
keymap("n", "<leader>fn", ":enew<CR>", "New buffer")

-- quicklists
keymap("n", "<leader>co", ":copen<CR>")
keymap("n", "<leader>cc", ":cclose<CR>")
keymap("n", "[q", ":cprevious<CR>zz")
keymap("n", "]q", ":cnext<CR>zz")

-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- buffer nav
keymap("n", "<S-l>", ":bnext<CR>", "Next buffer")
keymap("n", "<S-h>", ":bprevious<CR>", "Previous buffer")

-- save and quit
keymap("n", "<leader>w", ":write<CR>", "Save file")

-- paste over without replacing default register
keymap("n", "<leader>p", '"_dP', "Paste without replacing register")

-- keep more or less in the same place when going next
keymap("n", "n", "nzzzv", "")
keymap("n", "N", "Nzzzv", "")

-- keep more or less in the same place when going up/down
keymap("n", "<C-u>", "<C-u>zz", "")
keymap("n", "<C-d>", "<C-d>zz", "")
keymap("n", "<C-o>", "<C-o>zz", "")
keymap("n", "<C-i>", "<C-i>zz", "")

-- move record macro to Q instead of q
keymap("n", "Q", "q", "Record macro")
keymap("n", "q", "<Nop>", "")

-- Insert empty blank line above/bellow
keymap("n", "]<Space>", "m`o<Esc>``")
keymap("n", "[<Space>", "m`O<Esc>``")

-- system clipboard integration
keymap("n", "<leader>y", '"+y', "Copy to clipboard")
keymap("n", "<leader>Y", '"+Y', "Copy to clipboard")

-- delete to blackhole
keymap("n", "<leader>d", '"_d')
keymap("n", "<leader>D", '"_D')

-- Insert --
-- in insert mode, adds new undo points after , . ! and ?.
keymap("i", "-", "-<c-g>u")
keymap("i", "_", "_<c-g>u")
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", "!", "!<c-g>u")
keymap("i", "?", "?<c-g>u")

-- alias quick jk to esc
keymap("i", "jk", "<ESC>")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")
keymap("v", "p", '"_dP')

-- system clipboard integration
keymap("v", "<leader>y", '"+y')
keymap("v", "<leader>Y", '"+Y')

-- delete to blackhole
keymap("v", "<leader>d", '"_d')
keymap("v", "<leader>D", '"_D')

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")
