vim.g.mapleader = " "

vim.cmd("filetype plugin on")

require("configs")
require("lsp")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
-- hey!
vim.opt.rtp:prepend(lazypath)

vim.opt.runtimepath:prepend("~/.config/nvim/vimrc")
vim.cmd('source ~/.config/nvim/vimrc')
require('lazy').setup({
    { import = 'plugins' }
}, {
    dev = {
        path = '~/Developer/nvim_proj',
    },
})

vim.opt.cursorline = true
