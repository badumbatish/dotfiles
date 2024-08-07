return {
    "nvim-lualine/lualine.nvim",

    config = function()
        require('lualine').setup {
            sections = {
                lualine_x = { require("action-hints").statusline },
            },
            options = {
                theme = "catppuccin"
            }
        }
    end

}
