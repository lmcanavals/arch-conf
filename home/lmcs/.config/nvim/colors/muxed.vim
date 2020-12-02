" Vim color file
"
" Author: Luis Martín Canaval Sánchez <public01 at canaval dot info>
"
" huh

hi clear

set background=light
let colors_name = "muxed"

if (has("gui_running"))
  " properties
  let s:mod = " gui="
  let s:tbg = " guibg="
  let s:tfg = " guifg="
  " Colors
  let s:bd3 = "#002B36"
  let s:bd2 = "#073642"
  let s:bd1 = "#586E75"
  let s:bd0 = "#657B83"
  let s:bl3 = "#FDF6E3"
  let s:bl2 = "#EEE8D5"
  let s:bl1 = "#93A1A1"
  let s:bl0 = "#839496"
  let s:au0 = "#CB4B16"
  let s:red = "#DC322F"
  let s:gre = "#719E07"
  let s:yel = "#B58900"
  let s:blu = "#268BD2"
  let s:mag = "#D33682"
  let s:cya = "#2AA198"
  let s:au1 = "#6C71C4"
elseif &t_Co >= 16
  " properties
  let s:mod = " cterm="
  let s:tbg = " ctermbg="
  let s:tfg = " ctermfg="
  " Colors
  let s:bd3 = "NONE"
  let s:bd2 = "1"
  let s:bd1 = "2"
  let s:bd0 = "3"
  let s:bl3 = "4"
  let s:bl2 = "5"
  let s:bl1 = "6"
  let s:bl0 = "7"
  let s:au0 = "8"
  let s:red = "9"
  let s:gre = "10"
  let s:yel = "11"
  let s:blu = "12"
  let s:mag = "13"
  let s:cya = "14"
  let s:au1 = "15"
else
  " properties
  let s:mod = " cterm="
  let s:tbg = " ctermbg="
  let s:tfg = " ctermfg="
  " Colors
  let s:bd3 = "Black"
  let s:bd2 = "DarkRed"
  let s:bd1 = "DarkGreen"
  let s:bd0 = "DarkYellow"
  let s:bl3 = "DarkBlue"
  let s:bl2 = "DarkMagenta"
  let s:bl1 = "DarkCyan"
  let s:bl0 = "LightGray"
  let s:au0 = "DarkGray"
  let s:red = "LightRed"
  let s:gre = "LightGreen"
  let s:yel = "LightYellow"
  let s:blu = "LightBlue"
  let s:mag = "LightMagenta"
  let s:cya = "LightCyan"
  let s:au1 = "White"
endif

" basic
exe "hi! Normal"                .s:mod."NONE"     .s:tfg.s:bl0    .s:tbg.s:bd3
exe "hi! Comment"               .s:mod."NONE"     .s:tfg.s:bd1    .s:tbg."NONE"
exe "hi! Constant"              .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! Identifier"            .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! Statement"             .s:mod."NONE"     .s:tfg.s:gre    .s:tbg."NONE"
exe "hi! PreProc"               .s:mod."NONE"     .s:tfg.s:au0    .s:tbg."NONE"
exe "hi! Type"                  .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! Special"               .s:mod."NONE"     .s:tfg.s:red    .s:tbg."NONE"
exe "hi! Underlined"            .s:mod."NONE"     .s:tfg.s:au1    .s:tbg."NONE"
exe "hi! Ignore"                .s:mod."NONE"     .s:tfg."NONE"   .s:tbg."NONE"
exe "hi! Error"                 .s:mod."NONE"     .s:tfg.s:red    .s:tbg."NONE"
exe "hi! Todo"                  .s:mod."bold"     .s:tfg.s:mag    .s:tbg."NONE"

" extended
exe "hi! SpecialKey"            .s:mod."bold"     .s:tfg.s:bd0    .s:tbg.s:bd2
exe "hi! NonText"               .s:mod."bold"     .s:tfg.s:bd0    .s:tbg."NONE"
exe "hi! StatusLine"            .s:mod."reverse"  .s:tfg.s:bl1    .s:tbg.s:bd2
exe "hi! StatusLineNC"          .s:mod."reverse"  .s:tfg.s:bd0    .s:tbg.s:bd2
exe "hi! Visual"                .s:mod."NONE"     .s:tfg."NONE"   .s:tbg.s:bl3
exe "hi! Directory"             .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! ErrorMsg"              .s:mod."NONE"     .s:tfg.s:red    .s:tbg.s:bl3
exe "hi! IncSearch"             .s:mod."NONE"     .s:tfg.s:red    .s:tbg.s:bl1
exe "hi! Search"                .s:mod."NONE"     .s:tfg.s:au0    .s:tbg.s:bl0
exe "hi! MoreMsg"               .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! ModeMsg"               .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! LineNr"                .s:mod."NONE"     .s:tfg.s:bd1    .s:tbg.s:bd2
exe "hi! Question"              .s:mod."bold"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! VertSplit"             .s:mod."reverse"  .s:tfg.s:bd0    .s:tbg.s:bd2
exe "hi! Title"                 .s:mod."bold"     .s:tfg.s:au0    .s:tbg."NONE"
exe "hi! VisualNOS"             .s:mod."reverse"  .s:tfg."NONE"   .s:tbg.s:bd2
exe "hi! WarningMsg"            .s:mod."bold"     .s:tfg.s:red    .s:tbg."NONE"
exe "hi! WildMenu"              .s:mod."reverse"  .s:tfg.s:bl2    .s:tbg.s:bd2
exe "hi! Folded"                .s:mod."NONE"     .s:tfg.s:bd0    .s:tbg."NONE"
exe "hi! FoldColumn"            .s:mod."NONE"     .s:tfg.s:bd0    .s:tbg."NONE"

exe "hi! DiffAdd"               .s:mod."NONE"     .s:tfg.s:gre    .s:tbg.s:bd2
exe "hi! DiffChange"            .s:mod."NONE"     .s:tfg.s:yel    .s:tbg.s:bd2
exe "hi! DiffDelete"            .s:mod."NONE"     .s:tfg.s:red    .s:tbg.s:bd2
exe "hi! DiffText"              .s:mod."NONE"     .s:tfg.s:blu    .s:tbg.s:bd2

exe "hi! SignColumn"            .s:mod."NONE"     .s:tfg.s:bl0    .s:tbg."NONE"
exe "hi! Conceal"               .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! SpellBad"              .s:mod."undercurl".s:tfg."NONE"   .s:tbg."NONE"
exe "hi! SpellCap"              .s:mod."undercurl".s:tfg."NONE"   .s:tbg."NONE"
exe "hi! SpellRare"             .s:mod."undercurl".s:tfg."NONE"   .s:tbg."NONE"
exe "hi! SpellLocal"            .s:mod."undercurl".s:tfg."NONE"   .s:tbg."NONE"
exe "hi! Pmenu"                 .s:mod."reverse"  .s:tfg.s:bl0    .s:tbg.s:bd2
exe "hi! PmenuSel"              .s:mod."reverse"  .s:tfg.s:bd1    .s:tbg.s:bl2
exe "hi! PmenuSbar"             .s:mod."reverse"  .s:tfg.s:bl2    .s:tbg.s:bl0
exe "hi! PmenuThumb"            .s:mod."reverse"  .s:tfg.s:bl0    .s:tbg.s:bd3
exe "hi! TabLine"               .s:mod."NONE"     .s:tfg.s:bl0    .s:tbg.s:bd2
exe "hi! TabLineFill"           .s:mod."NONE"     .s:tfg.s:bl0    .s:tbg.s:bd2
exe "hi! TabLineSel"            .s:mod."NONE"     .s:tfg.s:bd1    .s:tbg.s:bl2
exe "hi! CursorColumn"          .s:mod."NONE"     .s:tfg."NONE"     .s:tbg.s:bd2
exe "hi! CursorLine"            .s:mod."NONE"     .s:tfg."NONE"     .s:tbg.s:bd2
exe "hi! ColorColumn"           .s:mod."NONE"     .s:tfg."NONE"     .s:tbg.s:bd2
exe "hi! Cursor"                .s:mod."NONE"     .s:tfg.s:bd3    .s:tbg.s:bl0
hi! link lCursor Cursor
exe "hi! MatchParen"            .s:mod."NONE"     .s:tfg.s:red    .s:tbg.s:bd1

" vim syntax
"hi! link vimComment Comment
"hi! link vimLineComment Comment
hi! link vimVar Identifier
hi! link vimFunc Function
hi! link vimUserFunc Function
hi! link helpSpecial Special
hi! link vimSet Normal
hi! link vimSetEqual Normal

exe "hi! vimCommentString"      .s:mod."NONE"     .s:tfg.s:au1    .s:tbg."NONE"
exe "hi! vimCommand"            .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! vimCmdSep"             .s:mod."bold"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! helpExample"           .s:mod."NONE"     .s:tfg.s:bl1    .s:tbg."NONE"
exe "hi! helpOption"            .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! helpNote"              .s:mod."NONE"     .s:tfg.s:mag    .s:tbg."NONE"
exe "hi! helpVim"               .s:mod."NONE"     .s:tfg.s:mag    .s:tbg."NONE"
exe "hi! helpHyperTextJump"     .s:mod."underline".s:tfg.s:blu    .s:tbg."NONE"
exe "hi! helpHyperTextEntry"    .s:mod."NONE"     .s:tfg.s:gre    .s:tbg."NONE"
exe "hi! vimIsCommand"          .s:mod."NONE"     .s:tfg.s:bd0    .s:tbg."NONE"
exe "hi! vimSynMtchOpt"         .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! vimSynType"            .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! vimHiLink"             .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! vimHiGroup"            .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! vimGroup"              .s:mod."underline".s:tfg.s:blu    .s:tbg."NONE"

" diff
hi! link diffAdded Statement
hi! link diffLine Identifier

" git
exe "hi! gitcommitComment"      .s:mod."NONE"     .s:tfg.s:bd1    .s:tbg."NONE"
hi! link gitcommitUntracked gitcommitComment
hi! link gitcommitDiscarded gitcommitComment
hi! link gitcommitSelected  gitcommitComment
exe "hi! gitcommitUnmerged"     .s:mod."bold"     .s:tfg.s:gre    .s:tbg."NONE"
exe "hi! gitcommitOnBranch"     .s:mod."bold"     .s:tfg.s:bd1    .s:tbg."NONE"
exe "hi! gitcommitBranch"       .s:mod."bold"     .s:tfg.s:mag    .s:tbg."NONE"
hi! link gitcommitNoBranch gitcommitBranch
exe "hi! gitcommitDiscardedType".s:mod."NONE"     .s:tfg.s:red    .s:tbg."NONE"
exe "hi! gitcommitSelectedType" .s:mod."NONE"     .s:tfg.s:gre    .s:tbg."NONE"
exe "hi! gitcommitHeader"       .s:mod."NONE"     .s:tfg.s:bd1    .s:tbg."NONE"
exe "hi! gitcommitUntrackedFile".s:mod."bold"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! gitcommitDiscardedFile".s:mod."bold"     .s:tfg.s:red    .s:tbg."NONE"
exe "hi! gitcommitSelectedFile" .s:mod."bold"     .s:tfg.s:gre    .s:tbg."NONE"
exe "hi! gitcommitUnmergedFile" .s:mod."bold"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! gitcommitFile"         .s:mod."bold"     .s:tfg.s:bl0    .s:tbg."NONE"
hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
hi! link gitcommitSelectedArrow  gitcommitSelectedFile
hi! link gitcommitUnmergedArrow  gitcommitUnmergedFile

" html
exe "hi! htmlTag"               .s:mod."NONE"     .s:tfg.s:bd1    .s:tbg."NONE"
exe "hi! htmlEndTag"            .s:mod."NONE"     .s:tfg.s:bd1    .s:tbg."NONE"
exe "hi! htmlTagN"              .s:mod."bold"     .s:tfg.s:bl1    .s:tbg."NONE"
exe "hi! htmlTagName"           .s:mod."bold"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! htmlSpecialTagName"    .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! htmlArg"               .s:mod."NONE"     .s:tfg.s:bl0    .s:tbg."NONE"
exe "hi! javaScript"            .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"

" perl
exe "hi! perlHereDoc"           .s:mod."NONE"     .s:tfg.s:bl1    .s:tbg."NONE"
exe "hi! perlVarPlain"          .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! perlStatementFileDesc" .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"

" tex
exe "hi! texStatement"          .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! texMathZoneX"          .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! texMathMatcher"        .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! texMathMatcher"        .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! texRefLabel"           .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"

" ruby
exe "hi! rubyDefine"            .s:mod."bold"     .s:tfg.s:bl1    .s:tbg."NONE"
"hi! link rubyArrayDelimiter    Special  " [ , , ]

"hi! link rubyClass             Keyword
"hi! link rubyModule            Keyword
"hi! link rubyKeyword           Keyword
"hi! link rubyOperator          Operator
"hi! link rubyIdentifier        Identifier
"hi! link rubyInstanceVariable  Identifier
"hi! link rubyGlobalVariable    Identifier
"hi! link rubyClassVariable     Identifier
"hi! link rubyConstant          Type

" haskell http://github.com/urso/dotrc/blob/master/vim/syntax/haskell.vim
let hs_highlight_boolean=1
let hs_highlight_delimiters=1

exe "hi! cPreCondit"            .s:mod."NONE"     .s:tfg.s:au0    .s:tbg."NONE"

exe "hi! VarId"                 .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! ConId"                 .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! hsImport"              .s:mod."NONE"     .s:tfg.s:mag    .s:tbg."NONE"
exe "hi! hsString"              .s:mod."NONE"     .s:tfg.s:bd0    .s:tbg."NONE"

exe "hi! hsStructure"           .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! hs_hlFunctionName"     .s:mod."NONE"     .s:tfg.s:blu    .s:tbg."NONE"
exe "hi! hsStatement"           .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! hsImportLabel"         .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! hs_OpFunctionName"     .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! hs_DeclareFunction"    .s:mod."NONE"     .s:tfg.s:au0    .s:tbg."NONE"
exe "hi! hsVarSym"              .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! hsType"                .s:mod."NONE"     .s:tfg.s:yel    .s:tbg."NONE"
exe "hi! hsTypedef"             .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! hsModuleName"          .s:mod."NONE"     .s:tfg.s:gre    .s:tbg."NONE"
exe "hi! hsModuleStartLabel"    .s:mod."NONE"     .s:tfg.s:mag    .s:tbg."NONE"
hi! link hsImportParams      Delimiter
hi! link hsDelimTypeExport   Delimiter
hi! link hsModuleStartLabel  hsStructure
hi! link hsModuleWhereLabel  hsModuleStartLabel

" following is for the haskell-conceal plugin
" the first two items don't have an impact, but better safe
exe "hi! hsNiceOperator"        .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"
exe "hi! hsniceoperator"        .s:mod."NONE"     .s:tfg.s:cya    .s:tbg."NONE"

" vim:foldmethod=marker:foldlevel=0
