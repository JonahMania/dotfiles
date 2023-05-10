vim.api.nvim_set_hl(0, "tabNone", {ctermbg="None", ctermfg="White"})
vim.api.nvim_set_hl(0, "tabDarkGrey", {ctermbg="DarkGrey", ctermfg="Black"})
vim.api.nvim_set_hl(0, "tabBlue", {ctermbg="Blue", ctermfg="Black"})
vim.api.nvim_set_hl(0, "tabBlueForeground", {ctermbg="DarkGrey", ctermfg="Blue"})

Tabline = {
    label = "Buffers"
}

Tabline.getBuffers = function()
    -- Only show loaded and listed buffers
    local buffers = vim.tbl_filter(
        function(b)
            return vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_buf_get_option(b, "buflisted")
        end,
        vim.api.nvim_list_bufs()
    )
    -- Get details for each buffer
    return vim.tbl_map(
        function(b)
            return {
                name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(b), ":t"),
                number = b,
                hidden = vim.fn.bufwinnr(b) == -1
            }
        end,
        buffers
    )
end

Tabline.drawBuffer = function(buffer)
    local bufferText = ""
    if buffer.hidden then
        bufferText = bufferText.."%#tabDarkGrey#"
    else
        bufferText = bufferText.."%#tabNone#"
    end
    bufferText = bufferText.." "..buffer.name.." "..buffer.number.." "
    return bufferText
end

Tabline.draw = function()
    local tabline = ""
    for _, buffer in ipairs(Tabline.getBuffers()) do
        tabline = tabline..Tabline.drawBuffer(buffer)
    end
    tabline = tabline.."%#tabDarkGrey#%="
    tabline = tabline.."%#tabBlueForeground#"
    tabline = tabline.."%#tabBlue# "..Tabline.label.." "
    return tabline
end
