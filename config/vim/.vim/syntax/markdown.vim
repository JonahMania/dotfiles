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
" Strikethrough 
highlight markdown_strikethrough ctermfg=White ctermbg=None cterm=strikethrough

" Syntax
" Headers
syntax region markdown_h1 matchgroup=markdown_h1_group start="\v^#{1}\s" end="$" oneline concealends
syntax region markdown_h2 matchgroup=markdown_h2_group start="\v^#{2}\s" end="$" oneline concealends
syntax region markdown_h3 matchgroup=markdown_h3_group start="\v^#{3}\s" end="$" oneline concealends
syntax region markdown_h4 matchgroup=markdown_h4_group start="\v^#{4}\s" end="$" oneline concealends
syntax region markdown_h5 matchgroup=markdown_h5_group start="\v^#{5}\s" end="$" oneline concealends
syntax region markdown_h6 matchgroup=markdown_h4_group start="\v^#{6}\s" end="$" oneline concealends
" Code line
syntax region markdown_code_line matchgroup=markdown_code_line_group start="`" end="`" oneline concealends
" Bullets
syntax match markdown_bullet_list "\v^\s*\*\s" contains=markdown_bullet
syntax match markdown_bullet "\*" contained  conceal cchar=·

" Strikethrough 
syntax region markdown_strikethrough matchgroup=markdown_strikethrough_group start="\~\~" end="\~\~" oneline concealends

" syntax region markdown_code_block start="```" end="```" contains=markdown_code_block_hide
" syntax match markdown_code_block_hide "```" contained conceal

" TODO
" Code blocks
" Figure out check list
