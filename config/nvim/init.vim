"----------------------------------------
"
" Author        :   Lasercata
" Last update   :   2024.11.30
" Version       :   v4.1.0_min
"
"----------------------------------------

"=========General
"------Tabulations
"---For all files
set tabstop=4              " number of visual spaces per tab
set softtabstop=4          " number of spaces in tab when editing
set shiftwidth=4           " number of spaces to use for auto indent
set expandtab              " tabs are space
set autoindent
set copyindent             " copy indent from the previous line

set breakindent            " Add indentation to wrapped lines.
set breakindentopt=shift:1 " Wrapped lines will have one more space.
set linebreak              " Wrap on word (not in the middle of a word)

"---For OCaml
autocmd FileType ocaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79

"------Syntax
filetype plugin indent on "Enable file type detection, indent for the detected file type, and use the plugin for it.
syntax enable             "Enable syntax highlighting


"------Appearance
set background=dark
set nu             " Line numbers
set relativenumber " Relative line number to current position
set ruler          " Show things at bottom right
set list           " Needed for the plugin 'indent_blankline'
set listchars=trail:-
set mouse=r
set scrolloff=3

set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 "Cursor shape in different modes, see :h guicursor


"------Search
set incsearch  "Search as char entered
set hlsearch   "Highlight matches
set ignorecase "Ignore the case of normal letters in search
set smartcase  "Overwrite ignorecase if there is an uppercase character in the searched text


"------Spelling
setlocal spell
set spelllang=en_gb,fr

" Correct the closer error behind cursor in insert mode.
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Toggle spell in normal mode
nnoremap <C-s> <cmd>set invspell<CR>


"------Folds
"---Python
autocmd FileType python setlocal foldnestmax=2 foldmethod=indent

"---C
autocmd FileType c setlocal foldnestmax=1 foldmethod=indent

"---LaTeX
autocmd FileType tex setlocal foldnestmax=3 foldmethod=indent foldlevelstart=1 foldlevel=1

"---JS
autocmd FileType javascript setlocal foldnestmax=1 foldmethod=indent

"---Java
autocmd FileType java setlocal foldnestmax=2 foldmethod=indent foldlevel=1


"------Assembly syntax
augroup asm_syntax
    autocmd!
    autocmd BufReadPost *.s let b:asmsyntax = 'nasm'
augroup END


"=========Keybinds
"---Leader keys
let mapleader = " "
nmap <space> <nop>
let maplocalleader = " "
" let maplocalleader = ","

"---Escape from insert mode
inoremap jk <esc>
inoremap kj <esc>

"---Also from terminal
tnoremap <ESC> <C-\><C-n>

"---Deleting in insert mode (with C-h, C-w) starts a new undo sequence
inoremap <C-h> <C-g>u<C-h>
inoremap <C-w> <C-g>u<C-w>

"---Auto close delimiters (now using pear-tree extension)
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O

"---Wrap selection with a delimiter (in visual mode)
vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>
vnoremap [ <ESC>`>a]<ESC>`<i[<ESC>
vnoremap { <ESC>`<i{<ESC>`>la}<ESC>%
vnoremap <leader>" <ESC>`<i"<ESC>`>la"<ESC>
vnoremap <leader>' <ESC>`<i'<ESC>`>la'<ESC>
vnoremap <leader>` <ESC>`<i`<ESC>`>la`<ESC>

"---Space around a char
nnoremap <space><space> i <esc>la <esc>

"---Deleting surrounding delimiter (any that is detected with %) in normal mode.
"The cursor can be anywhere inside the delimiter pair.
nnoremap <leader>ds %v%<ESC>x`<x`>

"---Change window
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"Also from terminal
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h

"---Change buffer faster
nnoremap <C-n> <cmd>bn<CR>
nnoremap <C-p> <cmd>bp<CR>

"---Change tab faster
nnoremap <M-n> gt
nnoremap <M-p> gT

"---Move cursor in insert and command mode : Alt + [hjkl$_]
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>
inoremap <M-h> <Left>
inoremap <M-$> <End>
inoremap <M-_> <Home>

cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-l> <Right>
cnoremap <M-h> <Left>
cnoremap <M-$> <End>
cnoremap <M-_> <Home>

"---In visual mode, <leader>i indents selection, <leader>I decrease indentation, and both reselect the selection
vnoremap <leader>i >gv4l
vnoremap <leader>I <gv4h

"Also from normal mode
nnoremap <leader>i >>4l
nnoremap <leader>I <<4h

"---Toggle relative line
" nnoremap <leader>n <cmd>set invrelativenumber<CR>

"---Quickfix window
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <leader>n <cmd>cn<cr>
nnoremap <leader>p <cmd>cp<cr>

" nnoremap <leader>c <cmd>ccl<cr>
nnoremap <silent> <leader>q <cmd>call ToggleQuickFix()<cr>

"---Make
nnoremap <F5> <cmd>make<CR>

"---xxd
nnoremap <leader>x <cmd>%!xxd<cr><cmd>set ft=xxd<cr>
nnoremap <leader>X <cmd>%!xxd -r<cr>
