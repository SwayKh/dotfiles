syntax on

set noerrorbells
set exrc
set hidden
set nohlsearch
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set signcolumn=yes
set colorcolumn=120
highlight ColorColumn ctermbg=white guibg=lightgray
set backspace=indent,eol,start
set wildmenu
set laststatus=2

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


"colorscheme gruvbox
set background=dark
let mapleader = " "
set showcmd
map <leader>u :UndotreeToggle<CR>

nnoremap <Leader>v :e $MYVIMRC<cr>
nnoremap <Leader>e :CocCommand explorer<CR>

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nmap <C-n> :NERDTreeToggle<CR>
map <leader>k <c-w>w
autocmd BufEnter * if line2byte('.') == -1 && len(tabpagebuflist()) == 1 | Startify | endif
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let NERDTreeShowHidden=1
let g:ctrlp_working_path_mode = 0
au BufWrite * :Autoformat

let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'


"Paste Code without formatting
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
"Paste code with formatting


"Reloads vimrc after saving but keep cursor position
if !exists("*ReloadVimrc")
    fun! ReloadVimrc()
        source $MYVIMRC
    endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

"Run Python File by pressing F9
autocmd FileType python map <buffer> <F9> :w<CR>:ter python "%"<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:ter python shellescape(@"%", 1)<CR>

"Compile cpp file with ctrl+c and execute file with ctrl+x
nnoremap <C-c> :ter g++ -o  %:r.out % -std=c++11 && %:r.out<CR>
"nnoremap <C-x> :!/%:r.out<Enter>
"nnoremap <C-c> :!g++ -std=c++11 % -Wall -g -o %.out && ./%.out<CR>


"VIMINIT="source C:\Users\Parvesh and Sumit\.vim\init.vim"
" let g:ncm2_pyclang#library_path = 'C:\Program Files\LLVM\bin\libclang
