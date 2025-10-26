local qf = require("quickfix")

vim.keymap.set("n", "dd", qf.remove_item, { buffer = true, silent = true, desc = "Delete QF item" })
vim.keymap.set("x", "d", qf.remove_range, { buffer = true, silent = true, desc = "Delete QF range" })
vim.keymap.set("n", "u", qf.undo, { buffer = true, silent = true, desc = "Undo QF change" })
vim.keymap.set("n", "<C-r>", qf.redo, { buffer = true, silent = true, desc = "Redo QF change" })

-- <Space>s to pseudo-save
vim.keymap.set("n", "<Space>s", function()
  vim.notify("Pseudo-saved", vim.log.levels.INFO)
end, { buffer = true, silent = true, desc = "Pseudo-save quickfix list" })
