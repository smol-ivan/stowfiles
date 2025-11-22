set nocompatible

set backspace=indent,eol,start

set ruler
set showcmd

set scrolloff=10

set noerrorbells
set novisualbell

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set autoindent

set number
set relativenumber

set encoding=utf-8

filetype plugin indent on
syntax on

call plug#begin()

Plug 'junegunn/seoul256.vim'

" lsp motor y servidor
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'

" fuzzyfinder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Autopairs/quoting
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Comments
Plug 'preservim/nerdcommenter'

" Completado
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Nerdtree
Plug 'scrooloose/nerdtree'
call plug#end()

let g:seoul256_background = 234
silent! colorscheme seoul256

" Custom keymaps
let mapleader=" "

" Buffers manipulation
nnoremap <C-x><C-n> :bnext<CR>        " Siguiente buffer
nnoremap <C-x><C-p> :bprevious<CR>    " Buffer anterior
nnoremap <C-x><C-k> :bdelete<CR>      " Cerrar buffer actual
nnoremap <C-x><C-b> :buffers<CR>      " Listar buffers

" save file
nnoremap <C-s> :w<CR>

" PLUGIN CONFIG

" toggle signcolumn
set signcolumn=no

" Completion

" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" " enter to always new line
" inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

" nerdtree
nnoremap <C-t> :NERDTreeToggle<CR>

" Smart tabs
let g:airline#extensions#tabline#enabled = 1

" nerdcommenter
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" fzf
let g:fzf_vim = {}

" toggle diagnostic
" let g:my_lsp_diagnostics_enabled = 1
"
" function s:MyToggleLSPDiagnostics()
"     if g:my_lsp_diagnostics_enabled == 1
"         call lsp#disable_diagnostics_for_buffer()
"         let g:my_lsp_diagnostics_enabled = 0
"         echo "LSP Diagnostics : off"
"     else
"         call lsp#enable_diagnostics_for_buffer()
"         let g:my_lsp_diagnostics_enabled = 1
"         echo "LSP Diagnostics : on"
"     endif
" endfunction
"
" command MyToggleLSPDiagnostics call s:MyToggleLSPDiagnostics()
"
" nnoremap <F1> :MyToggleLSPDiagnostics<CR>
"
" " Format range of code
" vnoremap <C-f> :LspDocumentRangeFormat<CR>
"
" " Format whole document
" nnoremap <C-f> :LspDocumentFormat<CR>

