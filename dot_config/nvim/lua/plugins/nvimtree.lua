vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true



return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        -- END_DEFAULT_ON_ATTACH
        --
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)
            vim.keymap.set('n', '<C-t>', api.node.open.drop, opts('Open in window, replace if exists '))
            vim.keymap.set('n', '<CR>', api.node.open.tab_drop, opts('Open in new tab, replace if exists'))
            vim.keymap.set('n', '<S-l>', ":tabnext<CR>", opts('Go to next tab'))
            vim.keymap.set('n', '<S-h>', ":tabprevious<CR>", opts('Go to prev tab'))
        end
        require("nvim-tree").setup {
            -- auto_close = true,
            view = {
                relativenumber = true,
                number = true,
                side = "right",
                centralize_selection = true,

            },
            renderer = {
                group_empty = true,
            },
            -- tab = {
            --     sync = {
            --         open = true,
            --     }
            -- },

            on_attach = my_on_attach
        }
        require 'nvim-web-devicons'.setup {
            -- your personnal icons can go here (to override)
            -- you can specify color or cterm_color instead of specifying both of them
            -- DevIcon will be appended to `name`
            override = {
                zsh = {
                    icon = "",
                    color = "#428850",
                    cterm_color = "65",
                    name = "Zsh"
                }
            },
            -- globally enable different highlight colors per icon (default to true)
            -- if set to false all icons will have the default icon's color
            color_icons = true,
            -- globally enable default icons (default to false)
            -- will get overriden by `get_icons` option
            default = true,
            -- globally enable "strict" selection of icons - icon will be looked up in
            -- different tables, first by filename, and if not found by extension; this
            -- prevents cases when file doesn't have any extension but still gets some icon
            -- because its name happened to match some extension (default to false)
            strict = true,
            -- same as `override` but specifically for overrides by filename
            -- takes effect when `strict` is true
            override_by_filename = {
                [".gitignore"] = {
                    icon = "",
                    color = "#f1502f",
                    name = "Gitignore"
                }
            },
            -- same as `override` but specifically for overrides by extension
            -- takes effect when `strict` is true
            override_by_extension = {
                ["log"] = {
                    icon = "",
                    color = "#81e043",
                    name = "Log"
                }
            },
        }
    end
}
