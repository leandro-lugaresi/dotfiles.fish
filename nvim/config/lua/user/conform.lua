local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    css = { "prettier" },
    fish = { "fish_indent" },
    go = { "gofumpt", "injected" },
    html = { "prettier", "injected" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    nix = { "nixpkgs_fmt" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    sql = { "pg_format", "sql_formatter" },
    tf = { "terraform_fmt" },
    yaml = { "prettier" },
    zig = { "zigfmt" },
    elixir = { "mix" },
    ["_"] = { "trim_whitespace" },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
