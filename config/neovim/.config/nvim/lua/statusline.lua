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

function statusLine(isActive)
    local mode = Statusline.modes[vim.api.nvim_get_mode().mode]
    local modeColor = "%#"..mode[2].."#"
    local colorA = "%#statusGrey#"
    local colorB = "%#statusDarkGrey#"
    if not isActive then
        modeColor = "%#statusDarkGrey#"
        colorA = "%#statusDarkGrey#"
        colorB = "%#statusDarkGrey#"
    end
    local statusLine = ""

    -- Mode
    if mode ~= nil then
        statusLine = statusLine..modeColor.." "..mode[1].." "
    end
    -- Buffer number
    statusLine = statusLine..colorA.." %n "
    -- Type
    statusLine = statusLine..colorB.." %Y "
    -- Position
    statusLine = statusLine..colorA.." %3l:%-2c "
    -- DeadSpace
    -- Modified, read only, percentage
    statusLine = statusLine..colorB.." %m %r%=%t %p "
    return statusLine
end

Statusline.active = function()
    return statusLine(true)
end

Statusline.inactive = function()
    return statusLine(false)
end
