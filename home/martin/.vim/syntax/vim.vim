" ==============================================================================
" File:         after/syntax/vim.vim
" Description:  Highlight all default highlight-groups inside comments
" Maintainer:   bfrg <bfrg@users.noreply.github.com>
" Website:      https://github.com/bfrg/vim-colorscheme-tester
" License:      Vim License (see `:help license`)
" Last Change:  Feb 16, 2018
" ==============================================================================

" Add the following lines to your colorscheme file next to the color definitions
" to test your colorscheme, or drop them in a new buffer with 'set filetype=vim'
" __Boolean__        __Character__     __ColorColumn__       __Comment__
" __Conceal__        __Conditional__   __Constant__          __Cursor__
" __CursorColumn__   __CursorIM__      __CursorLine__        __CursorLineNr__
" __Debug__          __Define__        __Delimiter__         __DiffAdd__
" __DiffChange__     __DiffDelete__    __DiffText__          __Directory__
" __EndOfBuffer__    __Error__         __ErrorMsg__          __Exception__
" __Float__          __FoldColumn__    __Folded__            __Function__
" __Identifier__     __Ignore__        __IncSearch__         __Include__
" __Keyword__        __Label__         __LineNr__            __Macro__
" __MatchParen__     __Menu__          __ModeMsg__           __MoreMsg__
" __NonText__        __Normal__        __Number__            __Operator__
" __Pmenu__          __PmenuSbar__     __PmenuSel__          __PmenuThumb__
" __PreCondit__      __PreProc__       __Question__          __QuickFixLine__
" __Repeat__         __Scrollbar__     __Search__            __SignColumn__
" __Special__        __SpecialChar__   __SpecialComment__    __SpecialKey__
" __SpellBad__       __SpellCap__      __SpellLocal__        __SpellRare__
" __Statement__      __StatusLine__    __StatusLineNC__      __StorageClass__
" __String__         __Structure__     __TabLine__           __TabLineFill__
" __TabLineSel__     __Tag__           __Title__             __Todo__
" __Tooltip__        __Type__          __Typedef__           __Underlined__
" __User1__          __User2__         __User3__             __User4__
" __User5__          __User6__         __User7__             __User8__
" __User9__          __VertSplit__     __Visual__            __VisualNOS__
" __WarningMsg__     __WildMenu__      __debugBreakpoint__   __debugPC__


syntax keyword hiGroupNormal          __Normal__            contained containedin=vimLineComment
syntax keyword hiGroupComment         __Comment__           contained containedin=vimLineComment
syntax keyword hiGroupSpecialComment  __SpecialComment__    contained containedin=vimLineComment
syntax keyword hiGroupNonText         __NonText__           contained containedin=vimLineComment
syntax keyword hiGroupDirectory       __Directory__         contained containedin=vimLineComment
syntax keyword hiGroupConceal         __Conceal__           contained containedin=vimLineComment
syntax keyword hiGroupSpecialKey      __SpecialKey__        contained containedin=vimLineComment
syntax keyword hiGroupIgnore          __Ignore__            contained containedin=vimLineComment
syntax keyword hiGroupIncSearch       __IncSearch__         contained containedin=vimLineComment
syntax keyword hiGroupSearch          __Search__            contained containedin=vimLineComment
syntax keyword hiGroupQuickFixLine    __QuickFixLine__      contained containedin=vimLineComment
syntax keyword hiGroupErrorMsg        __ErrorMsg__          contained containedin=vimLineComment
syntax keyword hiGroupMoreMsg         __MoreMsg__           contained containedin=vimLineComment
syntax keyword hiGroupModeMsg         __ModeMsg__           contained containedin=vimLineComment
syntax keyword hiGroupWarningMsg      __WarningMsg__        contained containedin=vimLineComment
syntax keyword hiGroupWildMenu        __WildMenu__          contained containedin=vimLineComment
syntax keyword hiGroupQuestion        __Question__          contained containedin=vimLineComment
syntax keyword hiGroupStatusLine      __StatusLine__        contained containedin=vimLineComment
syntax keyword hiGroupStatusLineNC    __StatusLineNC__      contained containedin=vimLineComment
syntax keyword hiGroupTabLineFill     __TabLineFill__       contained containedin=vimLineComment
syntax keyword hiGroupTabLine         __TabLine__           contained containedin=vimLineComment
syntax keyword hiGroupTabLineSel      __TabLineSel__        contained containedin=vimLineComment
syntax keyword hiGroupVertSplit       __VertSplit__         contained containedin=vimLineComment
syntax keyword hiGroupTitle           __Title__             contained containedin=vimLineComment
syntax keyword hiGroupVisualNOS       __VisualNOS__         contained containedin=vimLineComment
syntax keyword hiGroupVisual          __Visual__            contained containedin=vimLineComment
syntax keyword hiGroupFolded          __Folded__            contained containedin=vimLineComment
syntax keyword hiGroupFoldColumn      __FoldColumn__        contained containedin=vimLineComment
syntax keyword hiGroupDiffAdd         __DiffAdd__           contained containedin=vimLineComment
syntax keyword hiGroupDiffChange      __DiffChange__        contained containedin=vimLineComment
syntax keyword hiGroupDiffDelete      __DiffDelete__        contained containedin=vimLineComment
syntax keyword hiGroupDiffText        __DiffText__          contained containedin=vimLineComment
syntax keyword hiGroupCursor          __Cursor__            contained containedin=vimLineComment
syntax keyword hiGroupCursorIM        __CursorIM__          contained containedin=vimLineComment
syntax keyword hiGroupConstant        __Constant__          contained containedin=vimLineComment
syntax keyword hiGroupString          __String__            contained containedin=vimLineComment
syntax keyword hiGroupCharacter       __Character__         contained containedin=vimLineComment
syntax keyword hiGroupNumber          __Number__            contained containedin=vimLineComment
syntax keyword hiGroupBoolean         __Boolean__           contained containedin=vimLineComment
syntax keyword hiGroupFloat           __Float__             contained containedin=vimLineComment
syntax keyword hiGroupIdentifier      __Identifier__        contained containedin=vimLineComment
syntax keyword hiGroupFunction        __Function__          contained containedin=vimLineComment
syntax keyword hiGroupStatement       __Statement__         contained containedin=vimLineComment
syntax keyword hiGroupConditional     __Conditional__       contained containedin=vimLineComment
syntax keyword hiGroupRepeat          __Repeat__            contained containedin=vimLineComment
syntax keyword hiGroupLabel           __Label__             contained containedin=vimLineComment
syntax keyword hiGroupOperator        __Operator__          contained containedin=vimLineComment
syntax keyword hiGroupKeyword         __Keyword__           contained containedin=vimLineComment
syntax keyword hiGroupException       __Exception__         contained containedin=vimLineComment
syntax keyword hiGroupPreProc         __PreProc__           contained containedin=vimLineComment
syntax keyword hiGroupInclude         __Include__           contained containedin=vimLineComment
syntax keyword hiGroupDefine          __Define__            contained containedin=vimLineComment
syntax keyword hiGroupMacro           __Macro__             contained containedin=vimLineComment
syntax keyword hiGroupPreCondit       __PreCondit__         contained containedin=vimLineComment
syntax keyword hiGroupType            __Type__              contained containedin=vimLineComment
syntax keyword hiGroupStorageClass    __StorageClass__      contained containedin=vimLineComment
syntax keyword hiGroupStructure       __Structure__         contained containedin=vimLineComment
syntax keyword hiGroupTypedef         __Typedef__           contained containedin=vimLineComment
syntax keyword hiGroupSpecial         __Special__           contained containedin=vimLineComment
syntax keyword hiGroupSpecialChar     __SpecialChar__       contained containedin=vimLineComment
syntax keyword hiGroupTag             __Tag__               contained containedin=vimLineComment
syntax keyword hiGroupDelimiter       __Delimiter__         contained containedin=vimLineComment
syntax keyword hiGroupDebug           __Debug__             contained containedin=vimLineComment
syntax keyword hiGroupUnderlined      __Underlined__        contained containedin=vimLineComment
syntax keyword hiGroupError           __Error__             contained containedin=vimLineComment
syntax keyword hiGroupTodo            __Todo__              contained containedin=vimLineComment
syntax keyword hiGroupLineNr          __LineNr__            contained containedin=vimLineComment
syntax keyword hiGroupCursorLineNr    __CursorLineNr__      contained containedin=vimLineComment
syntax keyword hiGroupColorColumn     __ColorColumn__       contained containedin=vimLineComment
syntax keyword hiGroupCursorLine      __CursorLine__        contained containedin=vimLineComment
syntax keyword hiGroupCursorColumn    __CursorColumn__      contained containedin=vimLineComment
syntax keyword hiGroupSignColumn      __SignColumn__        contained containedin=vimLineComment
syntax keyword hiGroupEndOfBuffer     __EndOfBuffer__       contained containedin=vimLineComment
syntax keyword hiGroupMatchParen      __MatchParen__        contained containedin=vimLineComment
syntax keyword hiGroupPmenu           __Pmenu__             contained containedin=vimLineComment
syntax keyword hiGroupPmenuSel        __PmenuSel__          contained containedin=vimLineComment
syntax keyword hiGroupPmenuSbar       __PmenuSbar__         contained containedin=vimLineComment
syntax keyword hiGroupPmenuThumb      __PmenuThumb__        contained containedin=vimLineComment
syntax keyword hiGroupSpellBad        __SpellBad__          contained containedin=vimLineComment
syntax keyword hiGroupSpellCap        __SpellCap__          contained containedin=vimLineComment
syntax keyword hiGroupSpellLocal      __SpellLocal__        contained containedin=vimLineComment
syntax keyword hiGroupSpellRare       __SpellRare__         contained containedin=vimLineComment
syntax keyword hiGroupUser1           __User1__             contained containedin=vimLineComment
syntax keyword hiGroupUser2           __User2__             contained containedin=vimLineComment
syntax keyword hiGroupUser3           __User3__             contained containedin=vimLineComment
syntax keyword hiGroupUser4           __User4__             contained containedin=vimLineComment
syntax keyword hiGroupUser5           __User5__             contained containedin=vimLineComment
syntax keyword hiGroupUser6           __User6__             contained containedin=vimLineComment
syntax keyword hiGroupUser7           __User7__             contained containedin=vimLineComment
syntax keyword hiGroupUser8           __User8__             contained containedin=vimLineComment
syntax keyword hiGroupUser9           __User9__             contained containedin=vimLineComment
syntax keyword hiGroupMenu            __Menu__              contained containedin=vimLineComment
syntax keyword hiGroupScrollbar       __Scrollbar__         contained containedin=vimLineComment
syntax keyword hiGroupTooltip         __Tooltip__           contained containedin=vimLineComment
syntax keyword hiGroupdebugPC         __debugPC__           contained containedin=vimLineComment
syntax keyword hiGroupdebugBreakpoint __debugBreakpoint__   contained containedin=vimLineComment

highlight default link hiGroupNormal          Normal
highlight default link hiGroupComment         Comment
highlight default link hiGroupSpecialComment  SpecialComment
highlight default link hiGroupNonText         NonText
highlight default link hiGroupDirectory       Directory
highlight default link hiGroupConceal         Conceal
highlight default link hiGroupSpecialKey      SpecialKey
highlight default link hiGroupIgnore          Ignore
highlight default link hiGroupIncSearch       IncSearch
highlight default link hiGroupSearch          Search
highlight default link hiGroupQuickFixLine    QuickFixLine
highlight default link hiGroupErrorMsg        ErrorMsg
highlight default link hiGroupMoreMsg         MoreMsg
highlight default link hiGroupModeMsg         ModeMsg
highlight default link hiGroupWarningMsg      WarningMsg
highlight default link hiGroupWildMenu        WildMenu
highlight default link hiGroupQuestion        Question
highlight default link hiGroupStatusLine      StatusLine
highlight default link hiGroupStatusLineNC    StatusLineNC
highlight default link hiGroupTabLineFill     TabLineFill
highlight default link hiGroupTabLine         TabLine
highlight default link hiGroupTabLineSel      TabLineSel
highlight default link hiGroupVertSplit       VertSplit
highlight default link hiGroupTitle           Title
highlight default link hiGroupVisualNOS       VisualNOS
highlight default link hiGroupVisual          Visual
highlight default link hiGroupFolded          Folded
highlight default link hiGroupFoldColumn      FoldColumn
highlight default link hiGroupDiffAdd         DiffAdd
highlight default link hiGroupDiffChange      DiffChange
highlight default link hiGroupDiffDelete      DiffDelete
highlight default link hiGroupDiffText        DiffText
highlight default link hiGroupCursor          Cursor
highlight default link hiGroupCursorIM        CursorIM
highlight default link hiGroupConstant        Constant
highlight default link hiGroupString          String
highlight default link hiGroupCharacter       Character
highlight default link hiGroupNumber          Number
highlight default link hiGroupBoolean         Boolean
highlight default link hiGroupFloat           Float
highlight default link hiGroupIdentifier      Identifier
highlight default link hiGroupFunction        Function
highlight default link hiGroupStatement       Statement
highlight default link hiGroupConditional     Conditional
highlight default link hiGroupRepeat          Repeat
highlight default link hiGroupLabel           Label
highlight default link hiGroupOperator        Operator
highlight default link hiGroupKeyword         Keyword
highlight default link hiGroupException       Exception
highlight default link hiGroupPreProc         PreProc
highlight default link hiGroupInclude         Include
highlight default link hiGroupDefine          Define
highlight default link hiGroupMacro           Macro
highlight default link hiGroupPreCondit       PreCondit
highlight default link hiGroupType            Type
highlight default link hiGroupStorageClass    StorageClass
highlight default link hiGroupStructure       Structure
highlight default link hiGroupTypedef         Typedef
highlight default link hiGroupSpecial         Special
highlight default link hiGroupSpecialChar     SpecialChar
highlight default link hiGroupTag             Tag
highlight default link hiGroupDelimiter       Delimiter
highlight default link hiGroupDebug           Debug
highlight default link hiGroupUnderlined      Underlined
highlight default link hiGroupError           Error
highlight default link hiGroupTodo            Todo
highlight default link hiGroupLineNr          LineNr
highlight default link hiGroupCursorLineNr    CursorLineNr
highlight default link hiGroupColorColumn     ColorColumn
highlight default link hiGroupCursorLine      CursorLine
highlight default link hiGroupCursorColumn    CursorColumn
highlight default link hiGroupSignColumn      SignColumn
highlight default link hiGroupEndOfBuffer     EndOfBuffer
highlight default link hiGroupMatchParen      MatchParen
highlight default link hiGroupPmenu           Pmenu
highlight default link hiGroupPmenuSel        PmenuSel
highlight default link hiGroupPmenuSbar       PmenuSbar
highlight default link hiGroupPmenuThumb      PmenuThumb
highlight default link hiGroupSpellBad        SpellBad
highlight default link hiGroupSpellCap        SpellCap
highlight default link hiGroupSpellLocal      SpellLocal
highlight default link hiGroupSpellRare       SpellRare
highlight default link hiGroupUser1           User1
highlight default link hiGroupUser2           User2
highlight default link hiGroupUser3           User3
highlight default link hiGroupUser4           User4
highlight default link hiGroupUser5           User5
highlight default link hiGroupUser6           User6
highlight default link hiGroupUser7           User7
highlight default link hiGroupUser8           User8
highlight default link hiGroupUser9           User9
highlight default link hiGroupMenu            Menu
highlight default link hiGroupScrollbar       Scrollbar
highlight default link hiGroupTooltip         Tooltip
highlight default link hiGroupdebugPC         debugPC
highlight default link hiGroupdebugBreakpoint debugBreakpoint
