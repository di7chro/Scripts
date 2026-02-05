" ========================================
" Vimrc - snygg & praktisk (mörk terminal)
" ========================================

" Grund
set nocompatible
filetype plugin indent on
syntax on

" Tema / färger
set background=dark
colorscheme desert

" UI
set number              " radnummer
set relativenumber      " relativa radnummer (bra för rörelser)
set cursorline          " highlighta aktuell rad
set showcmd             " visa kommandon längst ned
set ruler               " rad/kolumn
set laststatus=2        " statusrad alltid
set showmode            " visar -- INSERT -- (kan stängas av om du vill)
set signcolumn=yes      " stabil vänstermarginal (git/diagnostik i framtiden)

" Text/indrag
set tabstop=3
set shiftwidth=3
set expandtab           " tab -> spaces (matchar din nano-stil)
set smartindent
set autoindent

" Visuell hjälp
set list
set listchars=tab:»·,trail:·,extends:›,precedes:‹,nbsp:␣

" Sök
set ignorecase
set smartcase
set incsearch
set hlsearch

" Beteende / kvalitet
set hidden              " tillåt byta buffert utan att spara direkt
set backspace=indent,eol,start
set updatetime=300      " snabbare respons för t.ex. CursorHold
set ttimeoutlen=10

" Scroll/visning
set scrolloff=5
set sidescrolloff=5
set wrap                " behåll wrap för textfiler
set linebreak           " wrap vid ordgränser
set breakindent         " snyggare wrap-indrag

" Mus (valfritt, kan vara skönt i terminal)
set mouse=a

" Enklare Esc i insert-läge (valfritt men populärt)
inoremap jk <Esc>

" Snabbt: slå av/på search-highlight
nnoremap <silent> <leader>h :set hlsearch!<CR>

" Leader
let mapleader=" "
