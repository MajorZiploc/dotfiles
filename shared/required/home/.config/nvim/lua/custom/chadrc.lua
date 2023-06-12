---@type ChadrcConfig

local M = {}

vim.keymap.set('n', '<C-s>', ':wa<cr>', {})
-- tabline will go away when only 1 tab exists
vim.opt.showtabline = 1
-- dont use system clipboard by default
vim.opt.clipboard = nil

return M
