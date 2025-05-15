Statusline = {}
Statusline.modes = {
  ["n"] = {"NORMAL", "statusBlue"},
  ["no"] = {"NORMAL", "statusBlue"},
  ["v"] = {"VISUAL", "statusYellow"},
  ["V"] = {"VISUAL LINE", "statusYellow"},
  [""] = {"VISUAL BLOCK", "statusYellow"},
  ["s"] = {"SELECT", "statusYellow"},
  ["S"] = {"SELECT LINE", "statusYellow"},
  [""] = {"SELECT BLOCK", "statusBlue"},
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
  ["nt"] = {"TERMINAL", "statusMagenta"},
}

Statusline.registerColors = function()
    vim.api.nvim_set_hl(0, "statusBlue", {ctermbg="Blue", ctermfg="Black"})
    vim.api.nvim_set_hl(0, "statusYellow", {ctermbg="Yellow", ctermfg="Black"})
    vim.api.nvim_set_hl(0, "statusRed", {ctermbg="Red", ctermfg="Black"})
    vim.api.nvim_set_hl(0, "statusMagenta", {ctermbg="Magenta", ctermfg="Black"})
    vim.api.nvim_set_hl(0, "statusGrey", {ctermbg="Grey", ctermfg="Black"})
    vim.api.nvim_set_hl(0, "statusDarkGrey", {ctermbg="DarkGrey", ctermfg="White"})
end

function statusLine(isActive)
    local statusLine = ""
    local mode = Statusline.modes[vim.api.nvim_get_mode().mode]
    local modeColor = "%#statusDarkGrey#"
    local colorA = "%#statusDarkGrey#"
    local colorB = "%#statusDarkGrey#"
    if mode == nil then
        mode = {vim.api.nvim_get_mode().mode, "statusRed"}
    end
    if isActive then
        modeColor = "%#"..mode[2].."#"
        colorA = "%#statusGrey#"
        colorB = "%#statusDarkGrey#"
    end

    -- Mode
    statusLine = statusLine..modeColor.." "..mode[1].." "
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
