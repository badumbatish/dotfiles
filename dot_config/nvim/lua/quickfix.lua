local M = {}

-- Tracks undo history per quickfix list (by "id" = qf title or number)
local state = {}

-- Helper: snapshot current quickfix list
local function snapshot()
  return vim.deepcopy(vim.fn.getqflist())
end

-- Helper: get state for current list
local function current_state()
  local title = vim.fn.getqflist({ title = 1 }).title or "<default>"
  if not state[title] then
    state[title] = { undo = {}, redo = {} }
  end
  return state[title]
end

function M.undo()
  local s = current_state()
  local qf = vim.fn.getqflist()
  local prev = table.remove(s.undo)
  if not prev then return vim.notify("Nothing to undo") end
  table.insert(s.redo, snapshot())
  vim.fn.setqflist(prev, "r")
end

function M.redo()
  local s = current_state()
  local qf = vim.fn.getqflist()
  local next = table.remove(s.redo)
  if not next then return vim.notify("Nothing to redo") end
  table.insert(s.undo, snapshot())
  vim.fn.setqflist(next, "r")
end

-- Delete single item
function M.remove_item()
  local s = current_state()
  table.insert(s.undo, snapshot())
  s.redo = {}

  local qf = vim.fn.getqflist()
  local line = vim.fn.line(".")
  table.remove(qf, line)
  vim.fn.setqflist(qf, "r")
end

-- Delete range
function M.remove_range()
  local s = current_state()
  table.insert(s.undo, snapshot())
  s.redo = {}

  local qf = vim.fn.getqflist()

  -- Get the exact visual range
  local start_pos = vim.fn.getpos("v")[2]  -- start of selection
  local end_pos   = vim.fn.getpos(".")[2]  -- cursor line

  if start_pos > end_pos then
    start_pos, end_pos = end_pos, start_pos
  end

  -- Remove items in reverse to preserve indices
  for i = end_pos, start_pos, -1 do
    table.remove(qf, i)
  end

  vim.fn.setqflist(qf, "r")
  vim.fn.cursor(math.min(start_pos, #qf), 1)


  -- Exit visual mode
  if vim.fn.mode():match("[vV\x16]") then
     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end
end

return M
