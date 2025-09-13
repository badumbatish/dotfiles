vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format { async = true }
end, {})
