syntax on
filetype on
colorscheme slate

" set leader
let mapleader = " "
let maplocalleader = " "

" Opts from neovim
" Set netrw size and style
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1

set hlsearch
set incsearch
set autowrite
set autoread
set colorcolumn=
set cursorline
set cursorlineopt=line

set laststatus=3
set showtabline=2
set tabline=%t
set nospell
set spelllang=en_us

set textwidth=80
set wrap
set whichwrap=<,>,[,],l,h
set termguicolors
set number
set relativenumber

set numberwidth=2
set mouse=a
set clipboard=unnamedplus
set formatoptions-=o

set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set breakindent
set smartindent

set undofile
set undodir=~/.vim/undodir
set ignorecase
set smartcase
set splitbelow
set splitright
set scrolloff=0
set sidescrolloff=5
set signcolumn=yes
set pumwidth=30
set pumheight=15
set cmdheight=1

set updatetime=250
set background=dark
set timeoutlen=300
set ttimeoutlen=0
set conceallevel=3
"set noshowmode
set noswapfile
set shortmess=filnxtToOFs

set completeopt=menuone,menu,noselect
set list
set listchars=tab:»\ ,trail:·,nbsp:␣
set foldmethod=indent
set foldlevel=99
set wildmenu
set wildmode=longest:full,full
set wildoptions=pum,fuzzy
let g:vimsyn_embed = "alpPrj"
set splitkeep=screen
let g:showbreak = "↪"
set confirm
set showmatch

set showcmd
set noerrorbells
set exrc
set hidden
highlight ColorColumn ctermbg=white guibg=lightgray
set backspace=indent,eol,start

" Keybinds from neovim
nnoremap <Esc> :nohlsearch<CR>
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>m. @@
nnoremap <leader>so :source %<CR>
nnoremap <leader>. :source $MYVIMRC<CR>
nnoremap <leader>f :Lexplore!<CR>

nnoremap <tab> :bn<CR>
nnoremap <S-tab> :bp<CR>
nnoremap H "_^
nnoremap L $

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

inoremap <C-j> <Down>
cnoremap <C-j> <Down>
inoremap <C-k> <Up>
cnoremap <C-k> <Up>
inoremap <C-h> <Left>
cnoremap <C-h> <Left>
inoremap <C-l> <Right>
cnoremap <C-l> <Right>

nnoremap <C-S-h> <C-w><
nnoremap <C-S-l> <C-w>>
nnoremap <C-S-k> <C-w>+
nnoremap <C-S-j> <C-w>-
nnoremap <C-S-Left> :vertical resize +3<CR>
nnoremap <C-S-Right> :vertical resize -3<CR>

nnoremap <left> :vertical resize +3<CR>
nnoremap <right> :vertical resize -3<CR>
nnoremap <down> :resize -3<CR>
nnoremap <up> :resize +3<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

nnoremap <M-j> 5j
vnoremap <M-j> 5j
nnoremap <M-k> 5k
vnoremap <M-k> 5k

nnoremap + <C-a>
nnoremap - <C-x>

nnoremap <leader>V :vsplit<CR>
nnoremap <leader>H :split<CR>

nnoremap <leader>a gg<S-v>G
nnoremap <leader>y :%y+<CR>
xnoremap P <Cmd>silent! normal! "_dP<CR>

nnoremap qq <Cmd>%bd<CR><Cmd>quit<CR>
nnoremap <leader>Q <Cmd>wqa!<CR>
nnoremap <C-s> <ESC><Cmd>w!<CR>
inoremap <C-s> <ESC><Cmd>w!<CR>
vnoremap <C-s> <ESC><Cmd>w!<CR>

nnoremap <C-q> <ESC><Cmd>q<CR>
inoremap <C-q> <ESC><Cmd>q<CR>
vnoremap <C-q> <ESC><Cmd>q<CR>

nnoremap <leader>bd <Cmd>bdelete<CR>
nnoremap <leader>bn <Cmd>bnext<CR>
nnoremap <leader>bp <Cmd>bprevious<CR>

nnoremap <leader>cn <Cmd>cnext<CR>
nnoremap <leader>cp <Cmd>cprev<CR>
nnoremap <leader>co <Cmd>copen<CR>
nnoremap <leader>cc <Cmd>cclose<CR>

cnoreabbrev Q q
cnoreabbrev q1 q!
cnoreabbrev Q1 q!
cnoreabbrev Qa1 qa!
cnoreabbrev Qa qa
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev WQ wq

" Autocmds from neovim
augroup help_window_right
  autocmd!
  autocmd BufWinEnter * if &filetype == 'help' | wincmd L | vertical resize 90 | endif
augroup END

augroup autosave
  autocmd!
  autocmd FocusLost,ModeChanged,TextChanged,BufEnter * silent! update
augroup END

augroup filetype_keymaps
  autocmd!
  autocmd FileType checkhealth,fugitive*,git,help,man,lspinfo,netrw,qf,query, nnoremap <buffer> q :close<CR>
augroup END

augroup center_cursor
  autocmd!
  autocmd CursorMoved,BufEnter * normal! zz
augroup END

augroup filetype_settings
  autocmd!
  autocmd FileType gitcommit,markdown setlocal wrap spell
augroup END

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * call system('highlight yank')
augroup END

augroup restore_cursor
  autocmd!
  autocmd BufReadPost * if getpos("'\"")[1] > 1 && getpos("'\"")[1] <= line('$') | execute "normal! '\"" | endif
augroup END

augroup clear_search_pattern
  autocmd!
  autocmd VimEnter * let @/ = ""
augroup END

"Reloads vimrc after saving but keep cursor position
if !exists("*ReloadVimrc")
    fun! ReloadVimrc()
        source $MYVIMRC
    endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

"colorscheme gruvbox
"map <leader>u :UndotreeToggle<CR>

"nnoremap <Leader>v :e $MYVIMRC<cr>
"nnoremap <Leader>e :CocCommand explorer<CR>

"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
"nmap <C-n> :NERDTreeToggle<CR>
"map <leader>k <c-w>w
"autocmd BufEnter * if line2byte('.') == -1 && len(tabpagebuflist()) == 1 | Startify | endif
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let NERDTreeShowHidden=1
"let g:ctrlp_working_path_mode = 0
"au BufWrite * :Autoformat

"let g:minimap_show='<leader>ms'
"let g:minimap_update='<leader>mu'
"let g:minimap_close='<leader>gc'
"let g:minimap_toggle='<leader>gt'


"Paste Code without formatting
"let &t_SI .= "\<Esc>[?2004h"
"let &t_EI .= "\<Esc>[?2004l"
"
"inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
"
"function! XTermPasteBegin()
"    set pastetoggle=<Esc>[201~
"    set paste
"    return ""
"endfunction
"Paste code with formatting



"Run Python File by pressing F9
"autocmd FileType python map <buffer> <F9> :w<CR>:ter python "%"<CR>
"autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:ter python shellescape(@"%", 1)<CR>
"
"Compile cpp file with ctrl+c and execute file with ctrl+x
"nnoremap <C-c> :ter g++ -o  %:r.out % -std=c++11 && %:r.out<CR>
"nnoremap <C-x> :!/%:r.out<Enter>
"nnoremap <C-c> :!g++ -std=c++11 % -Wall -g -o %.out && ./%.out<CR>


"VIMINIT="source C:\Users\Parvesh and Sumit\.vim\init.vim"
" let g:ncm2_pyclang#library_path = 'C:\Program Files\LLVM\bin\libclang

" call plug#begin('~/.vim/plugged')

"Gruvbox theme
" Plug 'morhetz/gruvbox'

"File explorer trees
" Plug 'scrooloose/nerdtree'

"For undo
" Plug 'mbbill/undotree'

"Git Integration
" Plug 'jreybert/vimagit'

"Most Recently Used Files
" Plug 'mhinz/vim-startify'
" Plug 'yegappan/mru'

"Change surrounding brackets/quotes/tags
" Plug 'tpope/vim-surround'
" Plug 'raimondi/delimitmate'

"Fuzzy Finder
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'junegunn/fzf'

"AutoFormatter
" Plug 'chiel92/vim-autoformat'

"Show Commands in popup
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

"Status bar
" Plug 'bling/vim-airline'

"Intellisense
"Plug 'neoclide/coc.nvim'

"Colorizer
" Plug 'lilydjwg/colorizer'

"Fonts and icon
"Plug 'ryanoasis/nerd-fonts'

"Minimap
" Plug 'severin-lemaignan/vim-minimap'
" call plug#end()
