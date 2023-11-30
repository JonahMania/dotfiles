require("packages")
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
vim.fn.matchadd("ColorColumn", [[\%100v]], 100)
-- Background
vim.o.background = "dark"
-- Markdown
vim.o.conceallevel = 2
vim.g.markdown_fenced_languages = {"bash=sh", "python", "c", "cpp"}

-- Set color column highlight color
vim.api.nvim_set_hl(0, "ColorColumn", {ctermbg="DarkRed"})
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
