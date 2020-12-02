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
"se cc=81
se nu
se sbr=▲·
se list
se lcs=tab:▬·,trail:·,extends:»,precedes:«,nbsp:☼

se so=5
se stl=%f%M%Y%R%H%W,%{&ff},%{&fenc?&fenc:&enc}%=%-10(%l,%c%V%)%P
se ls=0
se bg=dark
"se tgc
se title

color trompis

map <space> \

nm <leader><space> :noh<cr>
nm <leader>w :w<cr>
nm <leader>q :q<cr>
nm <leader>n :bn<cr>
nm <leader>N :bp<cr>
nm <leader>d :bd<cr>
nm <leader>h <c-w>h
nm <leader>j <c-w>j
nm <leader>k <c-w>k
nm <leader>l <c-w>l
nm <leader>c <c-w>c
vm <leader>y "*y
vm <leader>Y "+y
nm <leader>p "*p
nm <leader>P "+p

autocmd FileType go setl lcs+=tab:\|\  noet

call plug#begin()

Plug 'fatih/vim-go'
Plug 'nsf/gocode'
Plug 'scrooloose/nerdtree'

call plug#end()
