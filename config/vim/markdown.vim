setlocal conceallevel=2

" Highlighting
" Headers
highlight markdown_h1 ctermfg=Black ctermbg=Blue cterm=None
highlight markdown_h2 ctermfg=Cyan ctermbg=None cterm=bold,underline
highlight markdown_h3 ctermfg=Blue ctermbg=None cterm=bold
highlight markdown_h4 ctermfg=White ctermbg=None cterm=None
highlight markdown_h5 ctermfg=Grey ctermbg=None cterm=None
highlight markdown_h6 ctermfg=DarkGrey ctermbg=None cterm=None
" Code line
highlight markdown_code_line ctermfg=Magenta ctermbg=Black
" Bullets
highlight markdown_bullet ctermfg=Magenta ctermbg=None
" Strikethrough 
highlight markdown_strikethrough ctermfg=White ctermbg=None cterm=strikethrough
" Bold 
highlight markdown_bold ctermfg=White ctermbg=None cterm=bold

" Syntax
" Headers
syntax region markdown_h1 matchgroup=markdown_h1_group start="\v^#" end="$" oneline concealends
syntax region markdown_h2 matchgroup=markdown_h2_group start="\v^##" end="$" oneline concealends
syntax region markdown_h3 matchgroup=markdown_h3_group start="\v^###" end="$" oneline concealends
syntax region markdown_h4 matchgroup=markdown_h4_group start="\v^####" end="$" oneline concealends
syntax region markdown_h5 matchgroup=markdown_h5_group start="\v^#####" end="$" oneline concealends
syntax region markdown_h6 matchgroup=markdown_h4_group start="\v^######" end="$" oneline concealends
" Code line
syntax region markdown_code_line matchgroup=markdown_code_line_group start="`" end="`" oneline concealends
" Bullets
" TODO fix to include indented list
syntax match markdown_bullet "\v^\*" conceal cchar=·
" Strikethrough 
syntax region markdown_strikethrough matchgroup=markdown_strikethrough_group start="\~" end="\~" oneline concealends
" Bold
syntax region markdown_bold matchgroup=markdown_bold start="\*" end="\*" oneline concealends
" Italic

" syntax region markdown_code_block start="```" end="```" contains=markdown_code_block_hide
" syntax match markdown_code_block_hide "```" contained conceal

" TODO
" Change * to bullet char
" Headers (Make sure they are only at start of line)
" Code blocks
" Figure out bold
" Figure out strike through
" Figure out check list
