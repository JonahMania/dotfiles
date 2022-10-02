" General settings
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
set showmatch
set incsearch
set hlsearch
set relativenumber
set nonumber
syntax on

"Highlight tabs and trailing white spaces TODO fix
highlight ExtraWhitespace ctermbg=DarkRed
match ExtraWhitespace /\s\+$/

" TODO Move and create vars
hi LineTooLong cterm=bold ctermbg=DarkRed
match LineTooLong /\%>100v.\+/

augroup configgroup
   autocmd!
   autocmd FileType python setlocal commentstring=#\ %s
   autocmd BufEnter Makefile setlocal noexpandtab
augroup END

" Colors
let color_tab_primary_fg='White'
let color_tab_primary_bg='None'
let color_tab_secondary_fg='Black'
let color_tab_secondary_bg='DarkGrey'
let color_tab_buffers_fg='Black'
let color_tab_buffers_bg='Blue'
let color_status_mode_fg='Black'
let color_status_mode_insert_bg='Red'
let color_status_mode_normal_bg='Blue'
let color_status_mode_visual_bg='Yellow'
let color_status_mode_command_bg = 'Magenta'
let color_status_buffer_fg='Black'
let color_status_buffer_bg='Grey'
let color_status_type_fg='White'
let color_status_type_bg='DarkGrey'
let color_status_position_fg='Black'
let color_status_position_bg='Grey'
let color_status_line_bg='DarkGrey'
let color_status_line_fg='White'

" Tabline
exe 'hi primary_tab_color ctermfg=' . color_tab_primary_fg ' ctermbg=' . color_tab_primary_bg
exe 'hi secondary_tab_color ctermfg=' . color_tab_secondary_fg ' ctermbg=' . color_tab_secondary_bg
exe 'hi buffers_color ctermfg=' . color_tab_buffers_fg ' ctermbg=' . color_tab_buffers_bg
exe 'hi buffers_arrow_color ctermfg=' . color_tab_buffers_bg . ' ctermbg=' . color_tab_secondary_bg

function! Get_buffers()
    let buffers = []
    if exists("*getbufinfo")
        for buffer in getbufinfo()
            if buffer.listed
                let name = fnamemodify(buffer.name, ':t')
                let number = buffer.bufnr
                let primary = buffer.loaded
                let buffers += [{'name': name, 'number': number, 'primary': primary}]
            endif
        endfor
    else
        let buffer_numbers = filter(range(1, bufnr('$')), 'buflisted(v:val)') 
        for number in buffer_numbers
            let name = fnamemodify(bufname(number), ':t')
            let primary = bufloaded(numbebuffer_numberr)
            let buffers += [{'name': name, 'number': number, 'primary': primary}]
        endfor
    endif
    return buffers
endfunction

function! Draw_tabline()
    let buffers = []
    let line_text = ''
    let num_buffers = 0
    let buffers = Get_buffers()
    let num_buffers = len(buffers)

    " Draw text
    for buffer_index in range(num_buffers)
        let buffer = buffers[buffer_index]

        if buffer.primary
            let line_text .= '%#primary_tab_color#'
            let line_text .= '\ ' . buffer.name . '\ ' . buffer.number . '\ '
        else
            let line_text .= '%#secondary_tab_color#'
            let line_text .= '\ ' . buffer.name . '\ ' . buffer.number . '\ '
        endif
    endfor
    let line_text .= '%#secondary_tab_color#'
    let line_text .= '%='
    let line_text .= '%#buffers_arrow_color#'
    let line_text .= ''
    let line_text .= '%#buffers_color#'
    let line_text .= '\ Buffers\ '
    exe 'set tabline=' . line_text
endfunction

set showtabline=2
autocmd CmdwinEnter * call Draw_tabline()
autocmd BufNew * call Draw_tabline()
autocmd BufEnter * call Draw_tabline()
autocmd BufWritePost * call Draw_tabline()
autocmd VimResized * call Draw_tabline()
autocmd BufDelete * call Draw_tabline()

" Statusline
exe 'hi normal_color ctermbg=' . color_status_mode_normal_bg . ' ctermfg=' . color_status_mode_fg
exe 'hi insert_color ctermbg=' . color_status_mode_insert_bg . ' ctermfg=' . color_status_mode_fg
exe 'hi visual_color ctermbg=' . color_status_mode_visual_bg . ' ctermfg=' . color_status_mode_fg
exe 'hi command_color ctermbg=' . color_status_mode_command_bg . ' ctermfg=' . color_status_mode_fg
exe 'hi buffer_color ctermbg=' . color_status_buffer_bg . ' ctermfg=' . color_status_buffer_fg
exe 'hi type_color ctermbg=' . color_status_type_bg . ' ctermfg=' . color_status_type_fg
exe 'hi position_color ctermbg=' . color_status_position_bg . ' ctermfg=' . color_status_position_fg
exe 'hi statusline_color ctermbg=' . color_status_line_bg . ' ctermfg=' . color_status_line_fg

set noshowmode
set laststatus=2
set statusline=
set statusline+=%#normal_color#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#insert_color#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#visual_color#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#command_color#%{(mode()=='c')?'\ \ \ CMD\ \ \ ':''}
set statusline+=%#buffer_color#\ %n\ 
set statusline+=%#type_color#\ %Y\ 
set statusline+=%#type_slash_color#
set statusline+=%#position_color#\ %3l:%-2c\ 
set statusline+=%#statusline_color#
set statusline+=\ %m\ %r
set statusline+=%=
set statusline+=%p\ 
