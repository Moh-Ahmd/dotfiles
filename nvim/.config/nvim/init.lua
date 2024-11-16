local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("lazy").setup("plugins")



-- Set leader key (if not already set)
vim.g.mapleader = ' '

-- Window splitting keybindings
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>sh', ':split<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>sb', ':split<CR>', {noremap = true, silent = true})

-- Navigation keybindings
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

-- Open terminal below the current tab
vim.keymap.set('n', ':terminal', ':split | terminal<CR>', {noremap = true, silent = true})

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', {noremap = true, silent = true})


vim.cmd("set clipboard+=unnamedplus")

-- latex key-bindings
vim.keymap.set('n', '<leader>ll', ':VimtexCompile<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>lv', ':VimtexView<CR>', { noremap = true, silent = true })
