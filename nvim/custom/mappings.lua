---@type MappingsTable
local M = {}
local opts = { noremap = true, silent = true }

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- Move selected lines beween lines
    ["J"] = {"mzJ`z", opts = opts },
    ["<C-d>"] = {"<C-d>zz", opts = opts },
    ["<C-u>"] = { "<C-u>zz", opts = opts},
    ["n"] = {"nzzzv", opts = opts},
    ["N"] = {"Nzzzvr", opts = opts},
    ["<A-n>"] = { ":bprev<CR>", "previous buffer", opts = opts},
    ["<A-e>"] = { ":bnext<CR>", "next buffer", opts = opts},
    ["<leader>s"] = { ":w<cr>", "save buffer", opts = { nowait = true }},
    ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "find buffers", opts = { nowait = true }},
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "move selected line down", opts = opts },
    ["K"] = { ":m '<-2<CR>gv=gv", "move selected line up", opts = opts },
  }
}

M.truezen = {
  -- plugin = true,
  n = {
    ["<leader>tz"] = { ":TZAtaraxis<CR>", opts = { nowait = true }},
  },
  v = {
    ["<leader>tz"] = { ":'<,'>TZNarrow<CR>", opts = { nowait = true }},
  }
}

M.harpoon = {
  -- plugin = true,
  n = {
    ["<A-Tab>"] = {
      "<cmd>lua require('telescope').extensions.harpoon.marks(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Harpoon'})<CR>",
      "open harpoon ui",
    },
    ["<leader>mm"] = {
      '<cmd>lua require("harpoon.mark").add_file()<cr>',
      "Add file to harpoon",
    },
    ["<leader>m."] = {
      '<cmd>lua require("harpoon.ui").nav_next()<cr>',
      "Harppon next",
    },
    ["<leader>m,"] = {
      '<cmd>lua require("harpoon.ui").nav_prev()<cr>',
      "Harppon prev",
    },
    ["<leader>ms"] = {
      '<cmd>Telescope harpoon marks<cr>',
      "Harppon search files",
    },
    ["<leader>me"] = {
      '<cmd>lua require("harpoon.ui").toggle_quick_menu()',
      "Edit harppon files",
    },
  }
}

return M