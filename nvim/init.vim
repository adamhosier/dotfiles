set nocompatible
set ignorecase            " search, etc, ignores casing
set noshowmode            " hide mode from the bottom bar
set number                " line numbers
set tabstop=4             " visual width of tabs
set scrolloff=7           " always keep 7 lines at the top/bottom
set signcolumn=yes        " always enable the left column for status symbols
set hidden                " when a new buffer is opened, the current buffer is hidden, not closed
set termguicolors         " better colour support
set clipboard=unnamedplus " share system clipboard
set wildmenu              " better autocomplete for commands
set noerrorbells          " disable annoying bells
set encoding=utf8         " standard encoding
set noswapfile            " swapfiles are really only ever annoying
set smarttab              " i think this is golangs tab behaviour, tabs for indent, space for alignment
set tabstop=4             " tabs appear as being 4 spaces
set shiftwidth=4          " when shifting indent with > and <, use 4 spaces
set colorcolumn=120       " display bar on 120th column

" spell check conifig
set spellfile=~/.config/nvim/spell/en.utf8.add

" enable indents & synax highlight
filetype plugin indent on
syntax on

" use smyck colour scheme
colorscheme smyck
highlight ColorColumn guibg=#353535
highlight SpellBad cterm=underline guibg=#C75646

" load plugins
call plug#begin('~/.config/nvim/plug')
    " language client support
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
    \ }
    " fuzzy find
    Plug 'junegunn/fzf', { 
        \ 'dir': '~/.config/nvim/plug/fzf/bin', 
        \ 'do': './install --all'
    \ }
    Plug 'junegunn/fzf.vim'
    " close brackets, quotes
    Plug 'jiangmiao/auto-pairs'
    " completion 
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	" git integration
	Plug 'tpope/vim-fugitive' 
call plug#end()

" language client config
" go:        https://github.com/golang/tools/tree/master/gopls
" terraform: https://github.com/juliosueiras/terraform-lsp
let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls'],
	\ 'tf': ['terraform-lsp'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
\ }

" format code before save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

" open files in last edit position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" auto-pairs config
let g:AutoPairs = {'(':')', '[':']', '{':'}'}

" deoplete config
let g:deoplete#enable_at_startup = 1
" close preview window on deopletion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

" map space to leader
let mapleader = " "
map <space> <Nop>

" navigation
nnoremap <leader>b <C-o>
nnoremap <leader>t :bn<cr>
nnoremap <leader>T :bp<cr>

" copy filename
noremap <leader>c :let @*=expand("%:p")<cr> 

" easy exit from terminal mode
tnoremap <Esc> <C-\><C-n>| " easy exit

" lanauge client remaps
nnoremap <leader>m :call LanguageClient_contextMenu()<cr>
nnoremap <leader>a :call LanguageClient#textDocument_codeAction()<cr> 
nnoremap <leader>d :call LanguageClient#textDocument_definition()<cr> 
nnoremap <leader>r :call LanguageClient#textDocument_references()<cr>

" fzf remaps
nnoremap <leader>o :Files<cr>
nnoremap <leader>f :Rg<cr>

" deoplete remaps
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

