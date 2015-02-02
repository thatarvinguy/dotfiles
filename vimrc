"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File: .vimrc                                              "
" 							    "
" Sections:                                                 "
"   01. General ................. General Vim behavior      "
"   02. Events .................. General autocmd events    "
"   03. Theme/Colors ............ Colors, fonts, etc.       "
"   04. Vim UI .................. User interface behavior   "
"   05. Text Formatting/Layout .. Text, tab, indenation     "
"   06. Keys .................... Key binds, rebinds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible           " Kill Vi compatibility
set history=700            " How many lines of history Vim must remember
set autoread               " Auto read when a file is changed from the outside


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Events                                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Initialize Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'gmarik/Vundle.vim'
Plugin 'ctrlp.vim'
Plugin 'surround.vim'
Plugin 'fugitive.vim'
Plugin 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'

filetype plugin indent on  "filetype detection[ON] plugin [ON] indent[ON]


" Enable NERDTree on startup
"autocmd vimenter * NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" In Ruby files, use 2 spaces instead of 4 for tabs
autocmd FileType ruby setlocal sw=2 ts=2 sts=2

" Enable omnicompletion
set ofu=syntaxcomplete#Complete

" Set location of YCM python file
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. Theme/Colors                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256               " enable 256-color mode
syntax enable              " enable syntax highlighting

colorscheme desert
set background=dark        " set dark background

set encoding=utf8          " set uft8 as standard encoding


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. Vim UI                                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                 " show line numbers
set cul                    " highlight current line
set laststatus=2           " last window always has a statusline
set hlsearch               " highlight searched phrases
set incsearch              " highlight while searching
set ignorecase             " make searches case-insensitive
set smartcase              " when searching try to be smart about cases
set ruler                  " always show info along bottom
set showmatch              " highlight completed block
set mat=2                  " how long to blink when matching brackets
set wildmenu               " turn on wild menu
set wildignore=*.o,*~,*pyc " wild ignores compiled files
set cmdheight=2            " height of command bar
set hid                    " buffer becomes hidden when abandoned
set lazyredraw             " do not redraw while executing macros
set magic                  " regular expressions

" Return to last edit possition when opening files
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif
"Remember info about open buffers on close
set viminfo^=%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Text Formatting/Layout                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent             " auto-indent
set tabstop=4              " tab spacing
set softtabstop=4          " unify
set shiftwidth=4           " indent/outdent by 4 columns
set shiftround             " always indent/oudent to the nearest tabstop
set expandtab              " use spaces instead of tabs
set smarttab               " use tabs at the start of a line, spaces elsewhere
set nowrap                 " do not wrap text
set ai                     " auto indent
set si                     " smart indent

" Delete trailing white space on save
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Keys                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader mapping
let mapleader = ","
let g:mapleader = ","
" Fast saving
nmap <leader>w :w! <cr>
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"Visual mode - pressing * or # will search for current selection
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Treat long lines as break lines
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Map <space> to / (search) and Ctrl-<space> to ? (backwards search)
map <space> /

" Map esc to jj
inoremap jj <Esc>

" Map ; to :
nnoremap ; :