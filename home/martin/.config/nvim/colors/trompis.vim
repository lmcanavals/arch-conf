" Vim color file
"
" Name:       trompis.vim
" Version:    1.0
" Maintainer: Luis Canaval (uno@canaval.org)
"

"set background=dark
"set background=light

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "trompis"

if has("gui_running")
    let s:m = " gui="
    let s:b = " guibg="
    let s:f = " guifg="
    let s:c0 = "#0c1e20"
    let s:c1 = "#c0392b"
    let s:c2 = "#27ae60"
    let s:c3 = "#f39c12"
    let s:c4 = "#2980b9"
    let s:c5 = "#8e44ad"
    let s:c6 = "#16a085"
    let s:c7 = "#9da3a7"
    let s:c8 = "#68696a"
    let s:c9 = "#f76c5c"
    let s:ca = "#4eec91"
    let s:cb = "#f1e42f"
    let s:cc = "#54b8fb"
    let s:cd = "#bb79d6"
    let s:ce = "#4ac1b8"
    let s:cf = "#ecf0f1"
elseif &t_Co >= 16
    let s:m = " cterm="
    let s:b = " ctermbg="
    let s:f = " ctermfg="
    let s:c0 = "0"
    let s:c1 = "1"
    let s:c2 = "2"
    let s:c3 = "3"
    let s:c4 = "4"
    let s:c5 = "5"
    let s:c6 = "6"
    let s:c7 = "7"
    let s:c8 = "8"
    let s:c9 = "9"
    let s:ca = "10"
    let s:cb = "11"
    let s:cc = "12"
    let s:cd = "13"
    let s:ce = "14"
    let s:cf = "15"
else
    let s:m = " cterm="
    let s:b = " ctermbg="
    let s:f = " ctermfg="
    let s:c0 = "Black"
    let s:c1 = "DarkRed"
    let s:c2 = "DarkGreen"
    let s:c3 = "DarkYellow"
    let s:c4 = "DarkBlue"
    let s:c5 = "DarkMagenta"
    let s:c6 = "DarkCyan"
    let s:c7 = "LightGray"
    let s:c8 = "DarkGray"
    let s:c9 = "LightRed"
    let s:ca = "LightGreen"
    let s:cb = "LightYellow"
    let s:cc = "LightBlue"
    let s:cd = "LightMagenta"
    let s:ce = "LightCyan"
    let s:cf = "White"
endif
let s:no = "NONE"
let s:bo = "BOLD"
let s:re = "reverse"
let s:un = "underline"

" __Normal__ __Underlined__ __EndOfBuffer__ __NonText__
" __Special__ __SpecialChar__ __SpecialComment__ __SpecialKey__
if has('gui_running')
    exe 'hi! Normal'        .s:f.s:c7 .s:b.s:c0 .s:m.s:no
else
    exe 'hi! Normal'        .s:f.s:c7 .s:b.s:no .s:m.s:no
endif
exe 'hi! Underlined'    .s:f.s:c4           .s:m.s:un
exe 'hi! NonText'       .s:f.s:c8           .s:m.s:no
exe 'hi! Special'       .s:f.s:c9
exe 'hi! SpecialKey'    .s:f.s:c8

" __ColorColumn__ __CursorColumn__ __CursorLine__ __CursorLineNr__ __LineNr__
" __FoldColumn__ __Folded__
exe 'hi! ColorColumn'   .s:f.s:c1 .s:b.s:c7
exe 'hi! CursorColumn'            .s:b.s:no .s:m.s:no
exe 'hi! CursorLine'              .s:b.s:no .s:m.s:no
exe 'hi! CursorLineNr'  .s:f.s:c9           .s:m.s:no
exe 'hi! LineNr'        .s:f.s:c7 .s:b.s:no
exe 'hi! FoldColumn'    .s:f.s:cf .s:b.s:c4
exe 'hi! Folded'        .s:f.s:c7 .s:b.s:c4

" __MatchParen__ __IncSearch__ __Search__
exe 'hi! MatchParen'    .s:f.s:cf .s:b.s:c3 .s:m.s:no
exe 'hi! IncSearch'     .s:f.s:cf .s:b.s:c5 .s:m.s:no
exe 'hi! Search'        .s:f.s:cf .s:b.s:c2 .s:m.s:no

" __Pmenu__ __PmenuSel__ __PmenuSbar__ __PmenuThumb__
exe 'hi! Pmenu'         .s:f.s:c8 .s:b.s:c7
exe 'hi! PmenuSel'      .s:f.s:cf .s:b.s:c7
exe 'hi! PmenuSbar'     .s:f.s:c0 .s:b.s:c7
exe 'hi! PmenuThumb'    .s:f.s:c8 .s:b.s:c7

" __VertSplit__ __StatusLine__ __StatusLineNC__ __TabLine__ __TabLineFill__ __TabLineSel__
exe 'hi! VertSplit'     .s:f.s:c7 .s:b.s:no .s:m.s:no
exe 'hi! StatusLine'    .s:f.s:cf .s:b.s:c6 .s:m.s:no
exe 'hi! StatusLineNC'  .s:f.s:ca .s:b.s:c6 .s:m.s:no
exe 'hi! TabLine'       .s:f.s:c8 .s:b.s:c7 .s:m.s:no
exe 'hi! TabLineSel'    .s:f.s:cf .s:b.s:no .s:m.s:no
exe 'hi! TabLineFill'   .s:f.s:c8 .s:b.s:c7 .s:m.s:no

" __SignColumn__ __Cursor__ __Visual__ __VisualNOS__ __Tooltip__ __WildMenu__ __Scrollbar__
exe 'hi! SignColumn'    .s:f.s:c7
exe 'hi! Visual'                  .s:b.s:c6 .s:m.s:no
exe 'hi! VisualNOS'               .s:b.s:c1 .s:m.s:no
exe 'hi! WildMenu'      .s:f.s:cf .s:b.s:c3 .s:m.s:no

" __Comment__ __Todo__ __Ignore__ __Conceal__
exe 'hi! Comment'       .s:f.s:c8
exe 'hi! Todo'          .s:f.s:c8 .s:b.s:c3
exe 'hi! Ignore'        .s:f.s:c7

" __WarningMsg__ __Error__ __ErrorMsg__
exe 'hi! WarningMsg'    .s:f.s:c3 .s:b.s:no
exe 'hi! Error'         .s:f.s:cf .s:b.s:c1
exe 'hi! ErrorMsg'      .s:f.s:c9 .s:b.s:no

" __Identifier__ __Function__
exe 'hi! Identifier'    .s:f.s:cf           .s:m.s:no

" __PreCondit__ __PreProc__ __Define__ __Macro__ __Include__
exe 'hi! PreProc'       .s:f.s:cb

" __Number__ __Boolean__ __Character__ __Constant__ __String__ __Float__
exe 'hi! Number'        .s:f.s:c3
exe 'hi! Constant'      .s:f.s:c3

" __Typedef__ __Type__ __Structure__ __StorageClass__
exe 'hi! Type'          .s:f.s:ca           .s:m.s:no

" __Conditional__ __Exception__ __Keyword__ __Label__ __Operator__ __Repeat__
" __Statement__
exe 'hi! Statement'     .s:f.s:c2           .s:m.s:no

" __DiffAdd__ __DiffDelete__ __DiffChange__ __DiffText__
exe 'hi! DiffAdd'       .s:f.s:c0 .s:b.s:c2
exe 'hi! DiffDelete'    .s:f.s:c0 .s:b.s:c1 .s:m.s:no
exe 'hi! DiffChange'    .s:f.s:c0 .s:b.s:c3
exe 'hi! DiffText'      .s:f.s:c0 .s:b.s:c6 .s:m.s:no

""" .diff
"exe 'hi! diffAdded'     .s:f.s:ca
"exe 'hi! diffRemoved'   .s:f.s:c9

" __SpellBad__ __SpellCap__ __SpellLocal__ __SpellRare__
" __User1__ __User2__ __User3__ __User4__ __User5__ __User6__ __User7__
" __User8__ __User9__ __Delimiter__ __Tag__ __Title__ __CursorIM__ __Debug__
" __debugBreakpoint__ __debugPC__ __Directory__ __Question__ __QuickFixLine__
" __Menu__ __ModeMsg__ __MoreMsg__

unlet s:m
unlet s:b
unlet s:f
unlet s:c0
unlet s:c1
unlet s:c2
unlet s:c3
unlet s:c4
unlet s:c5
unlet s:c6
unlet s:c7
unlet s:c8
unlet s:c9
unlet s:ca
unlet s:cb
unlet s:cc
unlet s:cd
unlet s:ce
unlet s:cf
unlet s:no
unlet s:bo
unlet s:re
unlet s:un

" vim: set expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4:
