local preview_on = false

local function set_preview(callback) 
  if preview_on == false then
    callback()
  end
end
return
{
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.

    lazy = false,
    config = function()
        local oil = require("oil")
        local actions = require("oil.actions")
        local function smart_select()
            local entry = oil.get_cursor_entry()
            if entry and entry.type == "directory" then
                actions.select.callback()
            else
                actions.select.callback({ tab = true })
            end
        end
        vim.api.nvim_create_autocmd("User", {
          pattern = "OilEnter",
          callback = vim.schedule_wrap(function(args)
            if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
              oil.open_preview({
                split = "botright"
              })
            end
          end),
        })

        require("oil").setup({
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },

            -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
            -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
            -- Additionally, if it is a string that matches "actions.<name>",
            -- it will use the mapping at require("oil.actions").<name>
            -- Set to `false` to remove a keymap
            -- See :help oil-actions for a list of all available actions
            keymaps = {
                ["-"] = { "actions.parent", mode = "n" },
                ["h"] = { "actions.parent", mode = "n" },
                ["<CR>"] = { callback = smart_select },
                ["l"] = { callback = smart_select },
                -- Window navigation with Ctrl+hjkl
                ["<C-h>"] = { callback = function() vim.cmd("wincmd h") end, desc = "Move to left window" },
                ["<C-j>"] = { callback = function() vim.cmd("wincmd j") end, desc = "Move to bottom window" },
                ["<C-k>"] = { callback = function() vim.cmd("wincmd k") end, desc = "Move to top window" },
                ["<C-l>"] = { callback = function() vim.cmd("wincmd l") end, desc = "Move to right window" },
            },
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = true,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name, bufnr)
                    local m = name:match("^%.")
                    return m ~= nil
                end,
                -- This function defines what will never be shown, even when `show_hidden` is set
                is_always_hidden = function(name, bufnr)
                    return false
                end,
                -- Sort file names with numbers in a more intuitive order for humans.
                -- Can be "fast", true, or false. "fast" will turn it off for large directories.
                natural_order = "fast",
                -- Sort file and directory names case insensitive
                case_insensitive = false,
                sort = {
                    -- sort order can be "asc" or "desc"
                    -- see :help oil-columns to see which columns are sortable
                    { "type", "asc" },
                    { "name", "asc" },
                },
                -- Customize the highlight group for the file name
                highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
                    return nil
                end,
            }
        })
    end
}
