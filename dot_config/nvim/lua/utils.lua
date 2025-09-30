local M = {}

M.extract_vis_text = function()
    local current_mode = vim.fn.mode()

    local start_info = vim.fn.getpos("v")
    local end_info = vim.fn.getpos(".")

    vim.print(current_mode)
    -- if its the whole line, always get from beginning
    if current_mode == "V" then
        if (start_info[2] == end_info[2]) then
            return vim.fn.getline(start_info[2])
        else
            return table.concat(vim.fn.getline(start_info[2], end_info[2]), "\n")
        end
    elseif current_mode == "v" then
        return table.concat(vim.fn.getregion(start_info, end_info), "\n")
    else
        vim.print("Failure to select in visual mode")
    end
end


M.jasmine_escape = function(str)
    --find .  -type f | xargs sed -i 's/\#include "ast\/ast.h"/haha/g'
    local escaped = vim.fn.escape(str, "/#")
    return escaped
end

function string:contains(sub)
    return self:find(sub, 1, true) ~= nil
end

M.yank_all_in_buffer = function ()
    local cur = vim.api.nvim_win_get_cursor(0) -- Save current cursor position
    vim.cmd('normal! ggVGy') -- Yank the whole file
    vim.api.nvim_win_set_cursor(0, cur) -- Restore cursor position

    print('Yanked whole file to system clipboard')
end

M.yank_msg = 'Produced for register: '


M.yank_rel_file = function()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
    print(M.yank_msg .. path)
end

M.yank_full_file = function()
    local path = vim.fn.expand('%:p')
    vim.fn.setreg('+', path)
    print(M.yank_msg .. path)
end


M.yank_file_with_location = function()
    local path = vim.fn.expand('%:p')
    local line = vim.fn.line('.')
    local result = path .. ':' .. line
    vim.fn.setreg('+', result)
    print(M.yank_msg .. result)
end

M.yank_for_conditional_break = function()
    local path = vim.fn.expand('%:.')
    local line = vim.fn.line('.')
    local word = vim.fn.expand("<cword>")
    local result = 'breakpoint set --file '.. path .. ' --line ' .. line .. ' --condition ' .. '\'' .. word
    vim.fn.setreg('+', result)
    print(M.yank_msg .. result)
end
M.jump_to_file = function()
  local fname = vim.fn.expand("<cfile>")  -- respects ./, ../, foo/bar, etc.
  if fname == "" then
    print("No filename under cursor")
    return
  end

  -- Resolve relative paths
  fname = vim.fn.fnamemodify(fname, ":p")

  -- Find buffer number if it exists
  local bufnr = vim.fn.bufnr(fname)
  if bufnr == -1 then
    -- File not open, open in new tab
    vim.cmd("tabnew " .. vim.fn.fnameescape(fname))
    return
  end

  -- File is open, search current tab first
  -- local curtab = vim.fn.tabpagenr()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  -- Search other tabs
  local tabcount = vim.fn.tabpagenr("$")
  for t = 1, tabcount do
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(vim.api.nvim_list_tabpages()[t])) do
      if vim.api.nvim_win_get_buf(win) == bufnr then
        vim.cmd(t .. "tabnext")
        vim.api.nvim_set_current_win(win)
        return
      end
    end
  end

  -- If somehow not visible, just open in new tab
  vim.cmd("tabnew " .. vim.fn.fnameescape(fname))
end

return M
