-- Statusline colors
vim.api.nvim_set_hl(0, "statusBlue", {ctermbg="Blue", ctermfg="Black"})
vim.api.nvim_set_hl(0, "statusYellow", {ctermbg="Yellow", ctermfg="Black"})
vim.api.nvim_set_hl(0, "statusRed", {ctermbg="Red", ctermfg="Black"})
vim.api.nvim_set_hl(0, "statusMagenta", {ctermbg="Magenta", ctermfg="Black"})
vim.api.nvim_set_hl(0, "statusGrey", {ctermbg="Grey", ctermfg="Black"})
vim.api.nvim_set_hl(0, "statusDarkGrey", {ctermbg="DarkGrey", ctermfg="White"})

Statusline = {}
Statusline.modes = {
  ["n"] = {"NORMAL", "statusBlue"},
  ["no"] = {"NORMAL", "statusBlue"},
  ["v"] = {"VISUAL", "statusYellow"},
  ["V"] = {"VISUAL LINE", "statusYellow"},
  ["^V"] = {"VISUAL BLOCK", "statusYellow"},
  ["s"] = {"SELECT", "statusYellow"},
  ["S"] = {"SELECT LINE", "statusYellow"},
  ["^S"] = {"SELECT BLOCK", "statusBlue"},
  ["i"] = {"INSERT", "statusRed"},
  ["ic"] = {"INSERT", "statusRed"},
  ["R"] = {"REPLACE", "statusRed"},
  ["Rv"] = {"VISUAL REPLACE", "statusRed"},
  ["c"] = {"COMMAND", "statusMagenta"},
  ["cv"] = {"VIM EX", "statusMagenta"},
  ["ce"] = {"EX", "statusMagenta"},
  ["r"] = {"PROMPT", "statusMagenta"},
  ["rm"] = {"MOAR", "statusMagenta"},
  ["r?"] = {"CONFIRM", "statusMagenta"},
  ["!"] = {"SHELL", "statusMagenta"},
  ["t"] = {"TERMINAL", "statusMagenta"},
}

Statusline.active = function()
    local mode = Statusline.modes[vim.api.nvim_get_mode().mode]
    local statusLine = ""
    -- Mode
    if mode ~= nil then
        statusLine = statusLine.."%#"..mode[2].."# "..mode[1].." "
    end
    -- Buffer number
    statusLine = statusLine.."%#statusGrey# %n "
    -- Type
    statusLine = statusLine.."%#statusDarkGrey# %Y "
    -- Position
    statusLine = statusLine.."%#statusGrey# %3l:%-2c "
    -- DeadSpace
    statusLine = statusLine.."%#statusDarkGrey#"
    -- Modified, read only, percentage
    statusLine = statusLine.." %m %r%=%p "
    return statusLine
end

Statusline.inactive = function()
    return "%#statusGrey# %f"
end
