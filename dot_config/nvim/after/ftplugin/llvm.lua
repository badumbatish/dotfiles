local langref = vim.fn.stdpath("config") .. "/docs/llvm-langref.rst.txt"

if vim.fn.filereadable(langref) == 1 then
  -- Define a buffer-local command that looks up a keyword
  vim.api.nvim_buf_create_user_command(0, "LLVMDoc", function(opts)
    local word =  vim.fn.expand("<cword>")
    word = vim.fn.escape(word, "\\/.*$^~[]")
    vim.cmd("edit " .. vim.fn.fnameescape(langref))

    print("escaped word: " .. word)
    local pattern = ".*" .. word .. ".*' Instruction"
    local x = vim.fn.search(pattern)
    if x ~= 0 then
      return
    end

    if x == 0 then
      x = vim.fn.search("keywordprg" .. word)
    end
    if x == 0 then
      print("Cannot find: " .. word)
    end
  end, { nargs = "?" })

  vim.opt_local.keywordprg = ":LLVMDoc"
end
