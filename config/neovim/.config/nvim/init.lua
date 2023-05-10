require("statusline")
require("tabline")

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
vim.o.colorcolumn = "100"
-- Background
vim.o.background = "dark"

-- Set color column highlight color
vim.api.nvim_set_hl(0, "ColorColumn", {ctermbg="DarkGrey"})
-- Highlight tabs and trailing white spaces
vim.api.nvim_set_hl(0, "ExtraWhitespace", {ctermbg="DarkRed"})
vim.cmd([[match ExtraWhitespace /\s\+$/]])

-- Statusline
vim.o.laststatus = 2
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]], false)

-- Tabline
vim.o.showtabline = 2
vim.api.nvim_exec([[
  augroup Tabline
  au!
  au CmdwinEnter * setlocal tabline=%!v:lua.Tabline.draw()
  au BufNew * setlocal tabline=%!v:lua.Tabline.draw()
  au BufEnter * setlocal tabline=%!v:lua.Tabline.draw()
  au BufWritePost * setlocal tabline=%!v:lua.Tabline.draw()
  au VimResized * setlocal tabline=%!v:lua.Tabline.draw()
  au BufDelete * setlocal tabline=%!v:lua.Tabline.draw()
  augroup END
]], false)
