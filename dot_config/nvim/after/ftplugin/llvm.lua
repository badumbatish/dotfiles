local langref = vim.fn.stdpath("config") .. "/docs/llvm-langref.txt"

if vim.fn.filereadable(langref) == 1 then
  -- Define a buffer-local command that looks up a keyword
  vim.api.nvim_buf_create_user_command(0, "LLVMDoc", function(opts)
    local word = opts.args ~= "" and opts.args or vim.fn.expand("<cword>")
    vim.cmd("edit " .. vim.fn.fnameescape(langref))
    vim.cmd("/^" .. word)
  end, { nargs = "?" })

  vim.opt_local.keywordprg = ":LLVMDoc"
end
