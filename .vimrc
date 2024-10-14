syntax on
filetype on
filetype indent on
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

let g:vimsyn_embed = "alpPrj"
let g:showbreak = "↪"

set term=xterm-256color
set ttyfast
set nocompatible

set autowrite
set autoread
set nospell
set spelllang=en_us
set path+=**
set undofile
set undodir=~/.vim/undodir

"set noshowmode
set noswapfile

set showcmd
set noerrorbells
set exrc
set hidden

set wrap
set whichwrap=<,>,[,],l,h

set mouse=n
set clipboard=unnamedplus

" Tabs and Indents
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set breakindent
set smartindent

" Look and feel
set background=dark
set hlsearch
set colorcolumn=
set signcolumn=yes
set cursorline
set cursorlineopt=line
set ruler
set number
set relativenumber
set numberwidth=2
set textwidth=80
set termguicolors
set cmdheight=1
set laststatus=0
set showtabline=2
set splitbelow
set splitright
set splitkeep=screen
set shortmess=filnxtToOFs
set updatetime=250
set timeoutlen=300
set ttimeoutlen=0
set conceallevel=3
set scrolloff=0
set sidescrolloff=5
set pumwidth=30
set pumheight=15

"Search
set ignorecase
set smartcase
set showmatch
set incsearch


set completeopt=menuone,menu,noselect
set list
set listchars=tab:»·,trail:·,nbsp:␣
set foldmethod=indent
set foldlevel=99
set wildmenu
set wildmode=longest:full,full
set wildoptions=pum,fuzzy
set confirm

highlight ColorColumn ctermbg=white guibg=lightgray
set backspace=indent,eol,start
set omnifunc=syntaxcomplete#Complete

" Completion
" Check :h ins-completion
imap <C-o> <C-x><C-o>
imap <C-f> <C-x><C-f>
imap <C-t> <C-x><C-]>
imap <C-p> <C-x><C-p>
cmap <C-o> <C-x><C-v>

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
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

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

nnoremap qq <Cmd>%bd<CR>
nnoremap <C-s> <ESC><Cmd>w!<CR>
inoremap <C-s> <ESC><Cmd>w!<CR>
vnoremap <C-s> <ESC><Cmd>w!<CR>

nnoremap <C-q> <ESC><Cmd>wqa!<CR>
inoremap <C-q> <ESC><Cmd>wqa!<CR>
vnoremap <C-q> <ESC><Cmd>wqa!<CR>

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
