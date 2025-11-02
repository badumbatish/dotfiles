return {
  {
    'crispgm/nvim-tabline',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional
    config = function()
      require('tabline').setup({
        show_index = true,           -- show tab index
        show_modify = true,          -- show buffer modification indicator
        show_icon = true,            -- show file extension icon
        fnamemodify = ':t',          -- file name modifier string
        -- can be a function to modify buffer name
        modify_indicator = '[+]',    -- modify indicator
        no_name = 'No name',         -- no name buffer name
        brackets = { '', '' },       -- file name brackets surrounding
        inactive_tab_max_length = 0, -- max length of inactive tab titles, 0 to ignore

      })
    end
  }, -- For `plugins/helpview.lua` users.
  {
    "OXY2DEV/helpview.nvim",
    lazy = false
  },
  {
    "onsails/lspkind.nvim",
    config = function()
      require('lspkind').init({
        -- DEPRECATED (use mode instead): enables text annotations
        --
        -- default: true
        -- with_text = true,

        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = 'symbol_text',

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = 'codicons',

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      })
    end
  },
  {
    -- SHOWS STATUS LINE AT THE BOTTOM
    "nvim-lualine/lualine.nvim",

    config = function()
      require('lualine').setup {
        options = {
          theme = 'ayu',

        },

        extensions = {
          'oil',
          {
            sections = {
              lualine_a = {
                function()
                  return 'Quickfix List'
                end
              },
            },
            filetypes = { 'qf' }
          }
        },
        sections = {
          lualine_a = {
            'mode', 'branch' },
          lualine_b = { 'lsp_status', 'diff',
            { "progress",
              colored = true,
              use_mode_colors = true,
            },
            { "location",
              colored = true,
              use_mode_colors = true,
            },
          },
          lualine_c = { {
            'filename',
            file_status = true,    -- Displays file status (readonly status, modified status)
            newfile_status = true, -- Display new file status (new file means no write after created)
            path = 1,              -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '[+]',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            } },
            {
              'filetype',
              colored = true,             -- Displays filetype icon in color if set to true
              icon_only = false,          -- Display only an icon for filetype
              icon = { align = 'right' }, -- Display filetype icon on the right hand side
              -- icon =    {'X', align='right'}
              -- Icon string ^ in table is ignored in filetype component
            },
          },
          lualine_x = { 'encoding', 'fileformat' },
          lualine_z = {},
          lualine_y = {}
        },
      }
    end


  },

  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    config = function()
    end
  },
  -- {
  --     "catppuccin/nvim",
  --     name = "catppuccin",
  --     priority = 1000,
  --     config = function()
  --         require("catppuccin").setup({
  --             -- transparent_background = true, -- disables setting the background color.
  --             custom_highlights = function(colors)
  --                 return {
  --                     TabLineSel = { bg = colors.sky },
  --                     CmpBorder = { fg = colors.surface2 },
  --                 }
  --             end
  --
  --         })
  --         --- latte for light
  --         --- mocha for dark
  --         vim.cmd.colorscheme "catppuccin-latte"
  --     end
  -- },
  {
    "Shatur/neovim-ayu",
    priority = 1000,
    config = function()
      require('ayu').setup({
        mirage = false,  -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
        terminal = true, -- Set to `false` to let terminal manage its own colors.
        overrides = {
          TabLineSel = { fg = "#2E82FF", bg = "None" },
        },
      })
      require('ayu').colorscheme()
    end
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
  }
}
