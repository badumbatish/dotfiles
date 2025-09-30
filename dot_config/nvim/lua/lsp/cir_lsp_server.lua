local meta_configs = require 'meta_configs'

---@brief
---
---
--- The Language Server for the LLVM MLIR language, CIR version
---

---@type vim.lsp.Config
return {
  cmd = { meta_configs.clangir_repo .. '/build/bin/cir-lsp-server' },
  filetypes = { 'cir' },
  root_markers = { '.git' },
}
