
local M = {}

---@diagnostic disable-next-line: undefined-field
local sysname = vim.loop.os_uname().sysname

if sysname == "Darwin" then
  -- macOS
  M.llvm_bin = "/Users/jjasmine/Developer/igalia/llvm-project/build/bin/"
  M.clangir_repo = "/Users/jjasmine/Developer/igalia/clangir/"
  M.prebuilt_llvm_bin = "/Users/jjasmine/Developer/LLVM-21.1.2-macOS-X64/bin/"
elseif sysname == "Linux" then
  -- Linux
  M.llvm_bin = "/home/jjasmine/Developer/igalia/llvm-project/build/bin/"
  M.clangir_repo = "/home/jjasmine/Developer/igalia/clangir/"
  M.prebuilt_llvm_bin = "/home/jjasmine/Developer/LLVM-21.1.2-Linux-X64/bin/"
else
  error("Unsupported OS, not sure how to set this up: " .. sysname)
end

return M
