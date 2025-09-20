local langref = vim.fn.stdpath("config") .. "/docs/llvm-langref.rst"

if vim.fn.filereadable(langref) == 1 then
  -- Define a buffer-local command that looks up a keyword
  vim.api.nvim_buf_create_user_command(0, "LLVMDoc", function(opts)
    local word =  vim.fn.expand("<cword>")
    word = vim.fn.escape(word, "\\/.*$^~[]")
    vim.cmd("edit " .. vim.fn.fnameescape(langref))

    print("escaped word: " .. word)
    local pattern = ".*" .. word .. ".*' Instruction"
    vim.cmd("let @/ = ''")
    pcall(function()
      vim.fn.search(pattern)
    end)

      -- If search register is still empty => not found
    if vim.fn.getreg("/") == "" then
      -- Fallback to keywordprg
      pcall(function()
        vim.fn.search("keywordprg" .. word)
      end)
    end

    if vim.fn.getreg("/") == "" then
      print("Cannot find: " .. word)
    end
  end, { nargs = "?" })

  vim.opt_local.keywordprg = ":LLVMDoc"
end
