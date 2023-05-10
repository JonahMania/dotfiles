require("statusline")

-- Tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
-- Search highlighting
vim.o.showmatch = true
vim.o.incsearch = true
vim.o.hlsearch = true
-- Line numbering
vim.o.relativenumber = true
vim.o.number = false
-- Color column
vim.o.colorcolumn = '100'
-- Background
vim.o.background = 'dark'

-- Set color column highlight color
vim.cmd('highlight ColorColumn ctermbg=DarkGrey')
-- Highlight tabs and trailing white spaces
vim.cmd([[
    highlight ExtraWhitespace ctermbg=DarkRed
    match ExtraWhitespace /\s\+$/
]])

-- Statusline
vim.o.laststatus = 2
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]], false)
