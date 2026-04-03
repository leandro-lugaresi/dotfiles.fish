local languages = {
  "bash",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "fish",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gowork",
  "graphql",
  "hcl",
  "html",
  "http",
  "javascript",
  "typescript",
  "jq",
  "json",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "nix",
  "query",
  "regex",
  "rust",
  "scss",
  "sql",
  "terraform",
  "toml",
  "vhs",
  "vim",
  "yaml",
  "zig",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "RRethy/nvim-treesitter-endwise",
    },
    config = function()
      require("nvim-treesitter").setup({})
      require("nvim-treesitter").install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      -- Select
      local select_fn = function(query)
        return function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
        end
      end

      vim.keymap.set({ "x", "o" }, "af", select_fn("@function.outer"))
      vim.keymap.set({ "x", "o" }, "if", select_fn("@function.inner"))
      vim.keymap.set({ "x", "o" }, "ac", select_fn("@conditional.outer"))
      vim.keymap.set({ "x", "o" }, "ic", select_fn("@conditional.inner"))
      vim.keymap.set({ "x", "o" }, "aa", select_fn("@parameter.outer"))
      vim.keymap.set({ "x", "o" }, "ia", select_fn("@parameter.inner"))
      vim.keymap.set({ "x", "o" }, "av", select_fn("@variable.outer"))
      vim.keymap.set({ "x", "o" }, "iv", select_fn("@variable.inner"))

      -- Move
      local move = require("nvim-treesitter-textobjects.move")
      local move_next = function(query)
        return function()
          move.goto_next_start(query, "textobjects")
        end
      end
      local move_next_end = function(query)
        return function()
          move.goto_next_end(query, "textobjects")
        end
      end
      local move_prev = function(query)
        return function()
          move.goto_previous_start(query, "textobjects")
        end
      end
      local move_prev_end = function(query)
        return function()
          move.goto_previous_end(query, "textobjects")
        end
      end

      vim.keymap.set({ "n", "x", "o" }, "]f", move_next("@function.inner"))
      vim.keymap.set({ "n", "x", "o" }, "]p", move_next("@parameter.inner"))
      vim.keymap.set({ "n", "x", "o" }, "]c", move_next("@class.inner"))
      vim.keymap.set({ "n", "x", "o" }, "]F", move_next_end("@function.inner"))
      vim.keymap.set({ "n", "x", "o" }, "]P", move_next_end("@parameter.inner"))
      vim.keymap.set({ "n", "x", "o" }, "]C", move_next_end("@class.inner"))
      vim.keymap.set({ "n", "x", "o" }, "[f", move_prev("@function.inner"))
      vim.keymap.set({ "n", "x", "o" }, "[p", move_prev("@parameter.inner"))
      vim.keymap.set({ "n", "x", "o" }, "[c", move_prev("@class.inner"))
      vim.keymap.set({ "n", "x", "o" }, "[F", move_prev_end("@function.inner"))
      vim.keymap.set({ "n", "x", "o" }, "[P", move_prev_end("@parameter.inner"))
      vim.keymap.set({ "n", "x", "o" }, "[C", move_prev_end("@class.inner"))

      -- Swap
      vim.keymap.set("n", "<leader>a", function()
        require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
      end)
      vim.keymap.set("n", "<leader>A", function()
        require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
      end)
    end,
  },
}
