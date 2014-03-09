""
"" Vim and Gvim config!
"" by Luis Martín Canaval Sánchez
""
scriptencoding utf-8
set history=700

syntax enable
filetype indent plugin on

"" Search
set hlsearch            " highlight search
set incsearch           " start searching as you type
set ignorecase
set smartcase

"" No backups
set nobackup
set nowb
set noswapfile

"" Tabs, indents, etc.
set expandtab           " tabs to spaces
set smarttab
set shiftwidth=2        " tab = 2 spaces
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set showbreak=«
set list                " show special characters
set listchars=tab:»\ ,trail:·,nbsp:·

"" Leader
let mapleader = ","
let g:mapleader = ","

"" Leader shortcuts
map <leader>w :w!<cr>
map <leader>q :q<cr>
map <leader>n :bn<cr>
map <leader>p :bp<cr>
map <leader>d :bd<cr>
map <leader>- :set paste<cr>
map <leader>+ :set nopaste<cr>
map <leader><space> :noh<cr>

"" Auto complete
set wildmenu
set wildmode=longest:full,full
set wildignore+=*~,*.o,*.tmp

"" Misc
"if has('mouse')
"  set mouse=a
"endif
set completeopt=menu,menuone,longest,preview
set spelllang=en_us
set spellsuggest=fast,20
"set spell
set showcmd
set noerrorbells
set novisualbell
set t_vb=
set encoding=utf8
set cursorline
set colorcolumn=81
set textwidth=80
set scrolloff=7
set laststatus=2
set statusline=%F%m%=%4b\ %{&ff}%y%r%h%w%5(%l%):%-8(%c%V%)P:%-9(%o%)L:%L\ %P
set background=dark
set title

if has('gui_running') || (&term == 'xterm') || (&term =~ 'xterm-256color')
  set t_Co=256
endif

colorscheme muxed

"" Gvim options
if has('gui_running')
  set guioptions-=m     " hide menu
  set guioptions-=T     " hide tool bar
  set guioptions-=r     " hide scroll bar
  set guioptions+=c     " console dialogs
  set lines=25
  set guifont=Cousine\ 12
endif

"" Specific files fixes
autocmd FileType python setlocal shiftwidth=2 tabstop=2

