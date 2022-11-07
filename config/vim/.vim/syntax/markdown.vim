" TODO
" Unordered list
" Check list

if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'markdown'
endif

unlet! b:current_syntax

setlocal conceallevel=2

if !exists('g:markdown_fenced_languages')
  let g:markdown_fenced_languages = []
endif
let s:done_include = {}
for s:type in map(copy(g:markdown_fenced_languages),'matchstr(v:val,"[^=]*$")')
  if has_key(s:done_include, matchstr(s:type,'[^.]*'))
    continue
  endif
  if s:type =~ '\.'
    let b:{matchstr(s:type,'[^.]*')}_subtype = matchstr(s:type,'\.\zs.*')
  endif
  exe 'syn include @markdownHighlight'.substitute(s:type,'\.','','g').' syntax/'.matchstr(s:type,'[^.]*').'.vim'
  unlet! b:current_syntax
  let s:done_include[matchstr(s:type,'[^.]*')] = 1
endfor
unlet! s:type
unlet! s:done_include

if !exists('g:markdown_minlines')
  let g:markdown_minlines = 50
endif
execute 'syn sync minlines=' . g:markdown_minlines
syn case ignore

syn match markdownValid '[<>]\c[a-z/$!]\@!' transparent contains=NONE
syn match markdownValid '&\%(#\=\w*;\)\@!' transparent contains=NONE
syn match markdownLineStart "^[<@]\@!" nextgroup=@markdownBlock
syn cluster markdownBlock contains=markdownH1,markdownH2,markdownH3,markdownH4,markdownH5,markdownH6,markdownRule
syn cluster markdownInline contains=markdownItalic,markdownBold,markdownCode,markdownValid

syn region markdownH1 matchgroup=markdownH1Delimiter start="##\@!"      end="#*\s*$" oneline contains=@markdownInline contained concealends
syn region markdownH2 matchgroup=markdownH2Delimiter start="###\@!"     end="#*\s*$" oneline contains=@markdownInline contained concealends
syn region markdownH3 matchgroup=markdownH3Delimiter start="####\@!"    end="#*\s*$" oneline contains=@markdownInline contained concealends
syn region markdownH4 matchgroup=markdownH4Delimiter start="#####\@!"   end="#*\s*$" oneline contains=@markdownInline contained concealends
syn region markdownH5 matchgroup=markdownH5Delimiter start="######\@!"  end="#*\s*$" oneline contains=@markdownInline contained concealends
syn region markdownH6 matchgroup=markdownH6Delimiter start="#######\@!" end="#*\s*$" oneline contains=@markdownInline contained concealends

syn match markdownRule "\* *\* *\*[ *]*$" contained
syn match markdownRule "- *- *-[ -]*$" contained

syn region markdownItalic matchgroup=markdownItalicDelimiter start="\S\@<=\*\|\*\S\@=" end="\S\@<=\*\|\*\S\@=" skip="\\\*" contains=markdownLineStart,@Spell concealends
syn region markdownItalic matchgroup=markdownItalicDelimiter start="\w\@<!_\S\@=" end="\S\@<=_\w\@!" skip="\\_" contains=markdownLineStart,@Spell concealends
syn region markdownBold matchgroup=markdownBoldDelimiter start="\S\@<=\*\*\|\*\*\S\@=" end="\S\@<=\*\*\|\*\*\S\@=" skip="\\\*" contains=markdownLineStart,markdownItalic,@Spell concealends
syn region markdownBold matchgroup=markdownBoldDelimiter start="\w\@<!__\S\@=" end="\S\@<=__\w\@!" skip="\\_" contains=markdownLineStart,markdownItalic,@Spell concealends
syn region markdownBoldItalic matchgroup=markdownBoldItalicDelimiter start="\S\@<=\*\*\*\|\*\*\*\S\@=" end="\S\@<=\*\*\*\|\*\*\*\S\@=" skip="\\\*" contains=markdownLineStart,@Spell concealends
syn region markdownBoldItalic matchgroup=markdownBoldItalicDelimiter start="\w\@<!___\S\@=" end="\S\@<=___\w\@!" skip="\\_" contains=markdownLineStart,@Spell concealends

syn region markdownCode matchgroup=markdownCodeDelimiter start="`" end="`" keepend contains=markdownLineStart
syn region markdownCode matchgroup=markdownCodeDelimiter start="`` \=" end=" \=``" keepend contains=markdownLineStart
syn region markdownCode matchgroup=markdownCodeDelimiter start="^\s*````*.*$" end="^\s*````*\ze\s*$" keepend

syn match markdownFootnote "\[^[^\]]\+\]"
syn match markdownFootnoteDefinition "^\[^[^\]]\+\]:"

syn match markdownCodeLine "`[^`]\+`" contains=markdownCodeLineEnds
syn match markdownCodeLineEnds "`" contained conceal

syn region markdownStrikethrough matchgroup=markdown_strikethrough_group start="\~\~" end="\~\~" oneline concealends

if main_syntax ==# 'markdown'
  let s:done_include = {}
  for s:type in g:markdown_fenced_languages
    if has_key(s:done_include, matchstr(s:type,'[^.]*'))
      continue
    endif
    exe 'syn region markdownHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\..*','','').' matchgroup=markdownCodeDelimiter start="^\s*````*\s*\%({.\{-}\.\)\='.matchstr(s:type,'[^=]*').'}\=\S\@!.*$" end="^\s*````*\ze\s*$" keepend contains=@markdownHighlight'.substitute(matchstr(s:type,'[^=]*$'),'\.','','g')
    let s:done_include[matchstr(s:type,'[^.]*')] = 1
  endfor
  unlet! s:type
  unlet! s:done_include
endif

highlight markdownH1 ctermfg=Black ctermbg=Blue cterm=None
highlight markdownH2 ctermfg=Cyan ctermbg=None cterm=bold,underline
highlight markdownH3 ctermfg=Blue ctermbg=None cterm=bold
highlight markdownH4 ctermfg=White ctermbg=None cterm=None
highlight markdownH5 ctermfg=Grey ctermbg=None cterm=None
highlight markdownH6 ctermfg=DarkGrey ctermbg=None cterm=None

highlight markdownItalic cterm=italic
highlight markdownBold cterm=bold
highlight markdownBoldItalic cterm=bold,italic

highlight markdownCodeLine ctermfg=Magenta ctermbg=Black
highlight markdownStrikethrough ctermfg=White ctermbg=None cterm=strikethrough

highlight markdownCodeDelimiter  ctermfg=DarkGrey

let b:current_syntax = "markdown"
if main_syntax ==# 'markdown'
  unlet main_syntax
endif
