" Vim color file
" Name:       trompis.vim
" Version:    3.0
" Maintainer: Luis Canaval (uno@canaval.org)
"

"hi clear
"syntax reset
let g:colors_name = 'trompis'

fu! s:setHi(g, f, b, m)
    exe 'hi! '.a:g
        \ . (a:f >= 0 ? ' guifg='.s:c[a:f][0].' ctermfg='.s:c[a:f][1] : '')
        \ . (a:b >= 0 ? ' guibg='.s:c[a:b][0].' ctermbg='.s:c[a:b][1] : '')
        \ . (a:m >= 0 ? ' gui='.s:c[a:m][0].' cterm='.s:c[a:m][1] : '')
endf

let s:c = [['#000000',   0          ],
         \ ['#FF3300',   1          ],
         \ ['#00CC33',   2          ],
         \ ['#FF9900',   3          ],
         \ ['#3366FF',   4          ],
         \ ['#FF3399',   5          ],
         \ ['#00CCFF',   6          ],
         \ ['#CCCCCC',   7          ],
         \ ['#666666',   8          ],
         \ ['#FF9966',   9          ],
         \ ['#66CC99',   10         ],
         \ ['#FFDD00',   11         ],
         \ ['#6699FF',   12         ],
         \ ['#FF66CC',   13         ],
         \ ['#66FFFF',   14         ],
         \ ['#FFFFFF',   15         ],
         \ ['NONE',      'NONE'     ],
         \ ['BOLD',      'BOLD'     ],
         \ ['reverse',   'reverse'  ],
         \ ['underline', 'underline']]

call s:setHi('Normal',       -1,  16, 16)
"call s:setHi('Normal',           -1,  0, 16) " __Normal__
call s:setHi('Underlined',      12, -1, 19) " __Underlined__
call s:setHi('NonText',          8, -1, 16) " __NonText__ __EndOfBuffer__
call s:setHi('Special',          9, -1, -1) " __Special__ __SpecialChar__ __SpecialComment__
call s:setHi('SpecialKey',       8, -1, -1) " __SpecialKey__
call s:setHi('ColorColumn',      1,  7, -1) " __ColorColumn__
call s:setHi('CursorColumn',    -1, 16, 16) " __CursorColumn__
call s:setHi('CursorLine',      -1, 16, 16) " __CursorLine__
call s:setHi('CursorLineNr',     9, -1, 16) " __CursorLineNr__
call s:setHi('LineNr',           8, 16, -1) " __LineNr__
call s:setHi('FoldColumn',      12,  4, -1) " __FoldColumn__
call s:setHi('Folded',          12,  4, -1) " __Folded__
call s:setHi('MatchParen',       7,  3, 16) " __MatchParen__
call s:setHi('IncSearch',       15,  5, 16) " __IncSearch__
call s:setHi('Search',          15,  2, 16) " __Search__ __QuickFixLine__
call s:setHi('Pmenu',            8,  7, -1) " __Pmenu__
call s:setHi('PmenuSel',         7,  6, -1) " __PmenuSel__
call s:setHi('PmenuSbar',        8,  7, -1) " __PmenuSbar__
call s:setHi('PmenuThumb',       7,  6, -1) " __PmenuThumb__
call s:setHi('VertSplit',        8, 16, 16) " __VertSplit__
call s:setHi('StatusLine',      15,  6, 16) " __StatusLine__
call s:setHi('StatusLineNC',     5,  6, 16) " __StatusLineNC__
call s:setHi('TabLine',         13,  5, 16) " __TabLine__
call s:setHi('TabLineSel',      15, 16, 16) " __TabLineSel__
call s:setHi('TabLineFill',     13,  5, 16) " __TabLineFill__
call s:setHi('SignColumn',       9,  1, -1) " __SignColumn__
call s:setHi('Visual',          -1, -1, 18) " __Visual__
call s:setHi('VisualNOS',       -1,  1, 16) " __VisualNOS__
call s:setHi('WildMenu',        15,  3, 16) " __WildMenu__
call s:setHi('Comment',          8, -1, -1) " __Comment__
call s:setHi('Todo',            15,  3, -1) " __Todo__
call s:setHi('Ignore',           7, -1, -1) " __Ignore__
call s:setHi('ModeMsg',         14, 16, -1) " __ModeMsg__
call s:setHi('WarningMsg',       3, 16, -1) " __WarningMsg__
call s:setHi('ErrorMsg',         9, 16, -1) " __ErrorMsg__
call s:setHi('Error',           15,  1, -1) " __Error__
call s:setHi('Identifier',      15, -1, 16) " __Identifier__ __Function__
call s:setHi('PreProc',         11, -1, -1) " __PreProc__ __PreCondit__ __Define__ __Macro__ __Include__
call s:setHi('Number',           3, -1, -1) " __Number__ __Float__
call s:setHi('Constant',         3, -1, -1) " __Constant__ __Boolean__ __Character__ __String__
call s:setHi('Type',            10, -1, 16) " __Type__ __Typedef__ __Type__ __Structure__ __StorageClass__
call s:setHi('Statement',        2, -1, 16) " __Statement__ __Conditional__ __Exception__ __Keyword__ __Label__ __Operator__ __Repeat__
call s:setHi('DiffAdd',          0,  2, -1) " __DiffAdd__
call s:setHi('DiffDelete',       0,  1, 16) " __DiffDelete__
call s:setHi('DiffChange',       0,  3, -1) " __DiffChange__
call s:setHi('DiffText',         0,  6, 16) " __DiffText__
call s:setHi('Directory',       14, -1, -1) " __Directory__

" __Conceal__ __SpellBad__ __SpellCap__ __SpellLocal__ __SpellRare__
" __User1__ __User2__ __User3__ __User4__ __User5__ __User6__ __User7__
" __User8__ __User9__ __CursorIM__
" __debugBreakpoint__ __debugPC__  __Menu__ __Tooltip__ __Scrollbar__
" __Cursor__ __Debug__ __Delimiter__ __MoreMsg__ __Question__ __Tag__ __Title__

unlet s:c

" vim: set expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4:
