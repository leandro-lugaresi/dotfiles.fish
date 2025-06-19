require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
    kind_icons = {
      Array = "",
      Boolean = "",
      Class = "",
      Color = "",
      Constant = "",
      Constructor = "",
      Copilot = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "",
      File = "",
      Folder = "󰉋",
      Function = "",
      Interface = "",
      Key = "",
      Keyword = "",
      Method = "",
      Module = "",
      Namespace = "",
      Null = "󰟢",
      Number = "",
      Object = "",
      Operator = "",
      Package = "",
      Property = "",
      Reference = "",
      Snippet = "",
      String = "",
      Struct = "",
      Text = "",
      TypeParameter = "",
      Unit = "",
      Value = "",
      Variable = "",
    },
  },
  signature = { enabled = true },
  cmdline = {
    sources = function()
      local type = vim.fn.getcmdtype()
      if type == "/" or type == "?" then
        return { "buffer" }
      end
      if type == ":" then
        return { "cmdline" }
      end
      return {}
    end,
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lsp = {
        min_keyword_length = 0,
        score_offset = 0,
      },
      path = {
        min_keyword_length = 0,
      },
      snippets = {
        min_keyword_length = 2,
      },
      buffer = {
        min_keyword_length = 5,
        max_items = 5,
      },
    },
  },
  fuzzy = {
    sorts = {
      "exact",
      "score",
      "sort_text",
    },
  },
  completion = {
    accept = { auto_brackets = { enabled = true } },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,
    },

    menu = {
      auto_show = function(ctx)
        return ctx.mode ~= "cmdline"
      end,
      draw = {
        columns = {
          { "kind_icon", "label", gap = 1 },
          { "kind" },
        },
      },
    },
  },
})
