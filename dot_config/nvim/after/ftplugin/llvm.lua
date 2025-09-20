local langref = vim.fn.stdpath("config") .. "/docs/llvm-langref.rst.txt"

if vim.fn.filereadable(langref) == 1 then
  -- Define a buffer-local command that looks up a keyword
  vim.api.nvim_buf_create_user_command(0, "LLVMDoc", function()
    local word = vim.fn.expand("<cword>")
    word = vim.fn.escape(word, "\\/.*$^~[]")
    vim.cmd("edit " .. vim.fn.fnameescape(langref))

    print("escaped word: " .. word)
    local patterns = {
      ".*" .. word .. ".*' Instruction",
      ".*" .. word .. ".*' Intrinsic",
      "keywordprg" .. word,
    }

    for p in patterns do
      if (vim.fn.search(p) ~= 0) then
        return
      end
    end

    print("Cannot find: " .. word)
  end, { nargs = "?" })

  vim.opt_local.keywordprg = ":LLVMDoc"
end
