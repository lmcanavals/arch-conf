" Vim color file
"
" Name:       trompis.vim
" Version:    1.0
" Maintainer: Luis Canaval (uno@canaval.org)
"

"set background=dark
set background=light

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "trompis"

if (has("gui_running"))
  let s:m = " gui="
  let s:b = " guibg="
  let s:f = " guifg="
  let s:c0 = "#000000"
  let s:c1 = "#cc0000"
  let s:c2 = "#4e9a06"
  let s:c3 = "#c4a000"
  let s:c4 = "#3465a4"
  let s:c5 = "#75507b"
  let s:c6 = "#06989a"
  let s:c7 = "#d3d7cf"
  let s:c8 = "#555753"
  let s:c9 = "#ef2929"
  let s:ca = "#8ae234"
  let s:cb = "#fce94f"
  let s:cc = "#739fcf"
  let s:cd = "#ad7fa8"
  let s:ce = "#34e2e2"
  let s:cf = "#eeeeec"
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
let s:no = "none"
let s:bo = "bold"
let s:re = "reverse"
let s:un = "underline"

exe "hi! Normal"        .s:f.s:no .s:b.s:c0 .s:m.s:no
exe "hi! ColorColumn"             .s:b.s:c8
exe "hi! CursorColumn"            .s:b.s:c8 .s:m.s:no
exe "hi! CursorLine"              .s:b.s:c8 .s:m.s:no
exe "hi! FoldColumn"    .s:f.s:c7 .s:b.s:c8
exe "hi! Folded"        .s:f.s:cf .s:b.s:cc
exe "hi! IncSearch"     .s:f.s:c8 .s:b.s:c7 .s:m.s:no
exe "hi! NonText"       .s:f.s:c8           .s:m.s:bo
exe "hi! Pmenu"         .s:f.s:c0 .s:b.s:c8
exe "hi! PmenuSbar"               .s:b.s:c8
exe "hi! PmenuSel"      .s:f.s:c0 .s:b.s:c8
exe "hi! PmenuThumb"              .s:b.s:c7
exe "hi! Search"        .s:f.s:no .s:b.s:no .s:m.s:re
exe "hi! SignColumn"    .s:f.s:c7
exe "hi! SpecialKey"    .s:f.s:c8
exe "hi! StatusLine"    .s:f.s:cf .s:b.s:c4 .s:m.s:bo
exe "hi! StatusLineNC"  .s:f.s:c4 .s:b.s:cf .s:m.s:no
exe "hi! TabLine"       .s:f.s:c8 .s:b.s:c7 .s:m.s:no
exe "hi! TabLineSel"    .s:f.s:c1 .s:b.s:no .s:m.s:bo
exe "hi! TabLineFill"   .s:f.s:c9 .s:b.s:c7 .s:m.s:no
exe "hi! VertSplit"     .s:f.s:c8 .s:b.s:c7 .s:m.s:no
exe "hi! Visual"                  .s:b.s:c6
exe "hi! VIsualNOS"               .s:b.s:c6 .s:m.s:no
exe "hi! WildMenu"      .s:f.s:c4 .s:b.s:c7 .s:m.s:no

"" Syntax highlighting
exe "hi! Comment"       .s:f.s:c8
exe "hi! Constant"      .s:f.s:cb
exe "hi! Error"         .s:f.s:cf .s:b.s:c1
exe "hi! ErrorMsg"      .s:f.s:cf .s:b.s:c1
exe "hi! Identifier"    .s:f.s:c9           .s:m.s:no
exe "hi! Ignore"        .s:f.s:c7
exe "hi! LineNr"        .s:f.s:c7 .s:b.s:c4
exe "hi! MatchParen"    .s:f.s:ce .s:b.s:c4 .s:m .s:bo
exe "hi! Number"        .s:f.s:cb
exe "hi! PreProc"       .s:f.s:c2
exe "hi! Special"       .s:f.s:c9
exe "hi! Statement"     .s:f.s:cc           .s:m.s:no
exe "hi! Todo"          .s:f.s:c0 .s:b.s:c6
exe "hi! Type"          .s:f.s:ce           .s:m.s:no
exe "hi! Underlined"    .s:f.s:c4           .s:m.s:un

"" Special
""" .diff
exe "hi! diffAdded"     .s:f.s:ca
exe "hi! diffRemoved"   .s:f.s:c9
""" vimdiff
exe "hi! diffAdd"       .s:f.s:c0 .s:b.s:c2
exe "hi! diffDelete"    .s:f.s:c0 .s:b.s:c1 .s:m.s:no
exe "hi! diffChange"    .s:f.s:c0 .s:b.s:c5
exe "hi! diffText"      .s:f.s:c0 .s:b.s:c6 .s:m.s:no

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

" vim: set expandtab tabstop=2 shiftwidth=2 smarttab softtabstop=2:
