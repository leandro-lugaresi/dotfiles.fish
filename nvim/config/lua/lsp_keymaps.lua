local M = {}

--- On attach for key maps.
---@param bufnr number Buffer number
M.on_attach = function(bufnr)
  local builtin = require("telescope.builtin")
  local wk = require("which-key")

  --- Add a normal keymap.
  ---@param keys string Keymap
  ---@param func function Action
  ---@param desc string  Description
  local keymap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, {
      noremap = true,
      silent = true,
      buffer = bufnr,
      desc = "LSP: " .. desc,
    })
  end

  keymap("gd", builtin.lsp_definitions, "Goto Definition")
  keymap("gr", builtin.lsp_references, "Goto References")
  keymap("<C-j>", builtin.lsp_document_symbols, "Document Symbols")
  keymap("<C-h>", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
  keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
  keymap("gi", builtin.lsp_implementations, "Goto Implementation")
  keymap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  keymap("K", vim.lsp.buf.hover, "Hover Documentation")
  keymap("[d", function()
    vim.diagnostic.goto_prev({ float = false })
    vim.cmd("norm zz")
  end, "Next Diagnostic")
  keymap("]d", function()
    vim.diagnostic.goto_next({ float = false })
    vim.cmd("norm zz")
  end, "Previous Diagnostic")

  wk.add({
    { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
    { "<leader>lA", vim.lsp.buf.range_code_action, desc = "Range Code Actions" },
    { "<leader>ls", vim.lsp.buf.signature_help, desc = "Display Signature Information" },
    { "<leader>rn", vim.lsp.buf.rename, desc = "Rename all references" },
    { "<leader>lr", vim.cmd.LspRestart, desc = "Rename all references" },
    { "<leader>lf", vim.lsp.buf.format, desc = "Format" },
    { "<leader>li", require("telescope.builtin").lsp_implementations, desc = "Implementation" },
    { "<leader>lw", require("telescope.builtin").diagnostics, desc = "Diagnostics" },
  })
end

return M
