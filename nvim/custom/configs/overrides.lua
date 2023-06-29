local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "c",
    "markdown",
    "markdown_inline",
    "graphql",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.telescope = {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = function(...)
          require("telescope.actions").close(...)
        end,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      initial_mode = "normal",
      mappings = {
        i = {
          ["<C-d>"] = function(...)
            require("telescope.actions").delete_buffer(...)
          end,
        },
        n = {
          ["dd"] = function(...)
            require("telescope.actions").delete_buffer(...)
          end,
        },
      },
    },
  },
}

return M
