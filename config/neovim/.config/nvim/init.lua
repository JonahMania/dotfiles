require("packages")
require("statusline")

-- Ctrl + j enters normal mode
vim.keymap.set("", "<C-j>", "<Esc>", { silent = true, nowait = true })
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

-- Custom functions
function splitExtension(path)
    s, e = path:find(".[^.]*$")
    if s == nil or e == nil then
        return nil, nil
    end
    return path:sub(0, s - 1), path:sub(s + 1, e)
end

function switchSourceHeader(opts)
    header_extensions = {
        ["h"] = true,
        ["hpp"] = true
    }
    source_extensions = {
        ["c"] = true,
        ["cc"] = true,
        ["cpp"] = true
    }
    buffer_name = vim.api.nvim_buf_get_name(0)
    base, extension = splitExtension(buffer_name)

    if base == nil or extension == nil then
        print("No extension in file")
    end

    if header_extensions[extension] then
        for e, _ in pairs(source_extensions) do
            if vim.fn.filereadable(base .. "." .. e) ~= 0 then
                print(base .. "." .. e)
                vim.cmd.edit(base .. "." .. e)
                return
            end
        end
        print("No source file in same folder as header file")
    elseif source_extensions[extension] then
        for e, _ in pairs(header_extensions) do
            if vim.fn.filereadable(base .. "." .. e) ~= 0 then
                print(base .. "." .. e)
                vim.cmd.edit(base .. "." .. e)
                return
            end
        end
        print("No header file in same folder as source file")
    else
        print("Invalid file type")
    end
end
vim.api.nvim_create_user_command('Oc', switchSourceHeader, {})

function openBuild(opts)
    buffer_name = vim.api.nvim_buf_get_name(0)
    buffer_folder = buffer_name:sub(0, buffer_name:find("/[^/]*$"))
    build_file = buffer_folder .. "BUILD"
    if vim.fn.filereadable(build_file) ~= 0 then
        vim.cmd.edit(build_file)
        return
    end
    print("No BUILD file at " .. build_file)
end
vim.api.nvim_create_user_command('Ob', openBuild, {})
