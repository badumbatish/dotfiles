local language_servers = {
  "lua_ls",
  -- "pyright", "pylsp",
  "clangd", "tblgen_lsp_server", "mlir_lsp_server",
  "cir_lsp_server",
  "fortls",
  "gleam",
  "esbonio",
  "cmake-language-server",
}
vim.lsp.set_log_level(4)

for _, name in ipairs(language_servers) do
  local ok, config = pcall(require, "lsp." .. name)
  if ok then
    vim.lsp.config[name] = config
    vim.lsp.enable(name)
  else
    vim.lsp.enable(name)
  end
end

-- vim.lsp.enable("clangd")

-- vim.lsp.enable('rust_analyzer')



--- AUTO COMMANDS
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    -- vim.lsp.buf.format({
    --     async = false,
    --     bufnr = args.buf,
    --     timeout_ms = 1000,
    -- })
  end,
})

--- KEY MAPS

vim.keymap.set("n", "<leader>c", function()
  vim.cmd("LspClangdSwitchSourceHeader")
end, { desc = "Open matching source file in current buffer" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to implementation" })

vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename,
  { noremap = true, silent = true, desc = "Rename" })


vim.keymap.set('n', '<leader>lt', vim.lsp.buf.typehierarchy,
  { desc = "type hierachy" })
