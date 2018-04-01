set shiftwidth=4
set tabstop=4
set expandtab
set background=dark
set number
syntax on
set dir=~/.vim/swaps//

"Highlight matching [{()}]
set showmatch
"Search while characters are entered
set incsearch
"Highlight search results
set hlsearch
"Highlight tabs and trailing white spaces
:highlight ExtraWhitespace ctermbg=1
:match ExtraWhitespace /\s\+$/
"Set explorer to tree view
let g:netrw_liststyle = 3
"Remove explorer banner
let g:netrw_banner = 0

"Set statusbar color
hi StatusLine ctermbg=0 ctermfg=2
"Set tab bar colors
hi TabLine     ctermfg=3 ctermbg=none cterm=none
hi TabLineSel  ctermfg=none ctermbg=4 cterm=bold
hi TabLineFill ctermfg=none ctermbg=none cterm=none
hi Title       ctermfg=none ctermbg=none cterm=none

augroup configgroup
   autocmd!
   autocmd FileType python setlocal commentstring=#\ %s
   autocmd BufEnter Makefile setlocal noexpandtab
augroup END

"Toggle relative numbering
function TogRel()
   set relativenumber!
endfunc

"Set ctrl e to open the file explorer
map <c-e> :Ex <cr>

"Set ctrl r to toggle relative numbering
map <c-t> :call TogRel()<cr>

"Set ctrl t to open a new tab
map <c-t> :tabnew<cr>

"Set ctrl l to move to next tab
map <c-l> :tabnext<cr>

"Set ctrl h to move to previous tab
map <c-h> :tabprev<cr>
