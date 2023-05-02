---@type MappingsTable
local M = {}
local opts = { noremap = true, silent = true }

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- Move selected lines beween lines
    ["J"] = { "mzJ`z", opts = opts },
    ["<C-d>"] = { "<C-d>zz", opts = opts },
    ["<C-u>"] = { "<C-u>zz", opts = opts },
    ["n"] = { "nzzzv", opts = opts },
    ["N"] = { "Nzzzvr", opts = opts },
    ["<A-n>"] = { ":bprev<CR>", "previous buffer", opts = opts },
    ["<A-e>"] = { ":bnext<CR>", "next buffer", opts = opts },
    ["<leader>cf"] = { ":let @+ = expand(\"%\")<CR>", "copy relative path", opts = opts },
    ["<leader>s"] = { ":w<cr>", "save buffer", opts = { nowait = true } },
    ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "find buffers", opts = { nowait = true } },
    ["<leader>gg"] = { "<cmd>LazyGit<cr>", "open lazygit", opts = { nowait = true } },
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "move selected line down", opts = opts },
    ["K"] = { ":m '<-2<CR>gv=gv", "move selected line up", opts = opts },
  }
}

M.truezen = {
  -- plugin = true,
  n = {
    ["<leader>tz"] = { ":TZAtaraxis<CR>", opts = { nowait = true } },
  },
  v = {
    ["<leader>tz"] = { ":'<,'>TZNarrow<CR>", opts = { nowait = true } },
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
    ["<A-a>"] = {
      '<cmd>lua require("harpoon.ui").nav_file(1)<cr>',
      "Harppon go to file 1",
    },
    ["<A-r>"] = {
      '<cmd>lua require("harpoon.ui").nav_file(2)<cr>',
      "Harppon go to file 2",
    },
    ["<A-s>"] = {
      '<cmd>lua require("harpoon.ui").nav_file(3)<cr>',
      "Harppon go to file 3",
    },
    ["<A-t>"] = {
      '<cmd>lua require("harpoon.ui").nav_file(4)<cr>',
      "Harppon go to file 4",
    },
    ["<leader>me"] = {
      '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>',
      "Edit harppon files",
    },
  }
}

M.lspconfig = {
  n = {
    ["<C-h>"] = {
      "<cmd>Telescope lsp_document_symbols ignore_symbols=variable <cr>",
      "lsp document symbols",
    },
    ["<leader>cl"] = {
      function()
        vim.lsp.codelens.run()
      end,
      "lsp codelens",
    },
    ["<leader>lr"] = {
      function()
        vim.cmd.LspRestart()
      end,
      "lsp restart",
    },
  }
}

return M
