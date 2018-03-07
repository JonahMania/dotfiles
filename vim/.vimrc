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
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

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
