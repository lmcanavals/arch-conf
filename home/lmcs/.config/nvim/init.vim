"
" My config
"

se sm
se ts=4
se sts=4
se et
se si
se sw=4
se wim=longest:full,full
se wig+=*~,*.o,*.tmp
se cc=81
se nu
se sbr=▼\ 
se list
se lcs=tab:•\ ,trail:·,extends:»,precedes:«,nbsp:§
se so=5
se stl=%f%M%Y%R%H%W,%{&ff},%{&fenc?&fenc:&enc}%=%-10(%l,%c%V%)%P
se ls=0
se bg=dark
se tgc
se title
color trompis

map <space> \

nnor <leader><space> :noh<cr>
nnor <leader>w :w<cr>
nnor <leader>q :q<cr>
nnor <leader>n :bn<cr>
nnor <leader>N :bp<cr>
nnor <leader>d :bd<cr>
nnor <leader>h <c-w>h
nnor <leader>j <c-w>j
nnor <leader>k <c-w>k
nnor <leader>l <c-w>l
nnor <leader>c <c-w>c
vnor <leader>y "*y
nnor <leader>p "*p
vnor <leader>Y "+y
nnor <leader>P "+p

autocmd FileType go setl lcs+=tab:\|\  noet

call plug#begin()

Plug 'pprovost/vim-ps1',    { 'for': 'ps1' }
Plug 'scrooloose/nerdtree', {  'on': 'NERDTreeToggle' }

call plug#end()
