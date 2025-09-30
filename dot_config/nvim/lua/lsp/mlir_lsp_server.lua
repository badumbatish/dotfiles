local meta_configs = require 'meta_configs'
---@brief
---
--- https://mlir.llvm.org/docs/Tools/MLIRLSP/#mlir-lsp-language-server--mlir-lsp-server=
---
--- The Language Server for the LLVM MLIR language
---
--- `mlir-lsp-server` can be installed at the llvm-project repository (https://github.com/llvm/llvm-project)

---@type vim.lsp.Config
return {
  cmd = { meta_configs.llvm_bin .. '/mlir-lsp-server' },
  filetypes = { 'mlir' },
  root_markers = { '.git' },
}
