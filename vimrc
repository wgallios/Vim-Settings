" vim: ts=4 sts=4 sw=4 et ai

set nocompatible                " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " more powerful backspacing

set noautoindent                " always set autoindenting off
set textwidth=0                 " Don't wrap words by default
set nobackup                    " Don't keep a backup file
set backupcopy=no               " KNOPPIX: Overwrite files/links with w!
set viminfo='20,\"50            " read/write a .viminfo file, don't store more than
                                " 50 lines of registers
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time

colorscheme default
set background=dark

set wildmenu
set wildignore+=.git/*,.hg/*,.svn/*,._*,.DS_Store

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.pyc,.pyo,.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.orig

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" // clears search highlight
nmap <silent> // :noh<CR>

" Tab indenting
nmap <Tab> >>
nmap <S-Tab> <<

vmap <Tab> >gv
vmap <S-Tab> <gv

" Quick word jumping with Ctrl+Arrows
imap <C-[>[A <Up>
imap <C-[>[B <Down>
imap <C-[>[C <S-Right>
imap <C-[>[D <S-Left>

nmap <C-[>[A <Up>
nmap <C-[>[B <Down>
nmap <C-[>[C <S-Right>
nmap <C-[>[D <S-Left>

" Tab movement keys
"imap <Right> <C-o>:tabn<CR>
"imap <Left> <C-o>:tabp<CR>

nmap <Right> :tabn<CR>
nmap <Left> :tabp<CR>

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

function! Preserve(command)
    let _s=@/
    let l = line(".")
    let c = col(".")
    execute a:command
    let @/=_s
    call cursor(l, c)
endfun

nmap _$ :call Preserve("%s/\\s\\+$//e")<CR><C-l>

syntax on

if has("autocmd")
    filetype plugin on
    filetype indent on
    let php_sql_query=1
    let php_htmlInStrings=1
endif " has ("autocmd")

" Some Debian-specific things
augroup filetype
  au BufRead reportbug.*                set ft=mail
  au BufRead reportbug-*                set ft=mail
augroup END

au BufNewFile,BufRead *.php             call s:php_settings()
au BufNewFile,BufRead *.py              call s:py_settings()
au BufNewFile,BufRead *.html            call s:html_settings()
au BufNewFile,BufRead *.css             call s:css_settings()
au BufNewFile,BufRead *.js              call s:js_settings()

au BufRead */templates/*.html           call s:template_binds()

function! s:template_binds()
    set makeprg=clear;php\ ~/bin/update_templates.php\ %:p
    nmap <C-b> :make!<CR>
    imap <C-b> <C-o>:make!<CR>
    nmap ,c :nunmap ,c<CR>:rightbelow vs ~/html/slickdeals/css/306/usercp.css<CR>:vert res -50<CR><C-w>h<C-l>
endfun

function! s:php_settings()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab
    set autoindent
    set smartindent
    nmap <C-s> :write!<CR>
    imap <C-s> <C-o>:write!<CR>
    let b:SuperTabDisabled=0
endfun

function! s:py_settings()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab
    set autoindent
    set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
endfun

function! s:html_settings()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
    set smarttab
    set expandtab
    set autoindent
endfun

function! s:css_settings()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab
    set autoindent
endfun

function! s:js_settings()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab
    set autoindent
endfun

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
"set ignorecase         " Do case insensitive matching
set incsearch           " Incremental search
set autowrite           " Automatically save before commands like :next and :make
set mouse=a             " Mouse support!

" Fix numpad over SSH
imap <Esc>Oq 1
imap <Esc>Or 2
imap <Esc>Os 3
imap <Esc>Ot 4
imap <Esc>Ou 5
imap <Esc>Ov 6
imap <Esc>Ow 7
imap <Esc>Ox 8
imap <Esc>Oy 9
imap <Esc>Op 0
imap <Esc>On .
imap <Esc>OR *
imap <Esc>OQ /
imap <Esc>Ol +
imap <Esc>OS -

" Taglist
noremap <silent> ,t :TlistToggle<CR>
let g:Tlist_Auto_Open=0

" SuperTab
let b:SuperTabDisabled=1
set completeopt=menuone,longest
let g:SuperTabLongestEnhanced=1
let g:SuperTabLongestHighlight=1
let g:SuperTabDefaultCompletionType='context'

" SmartHome
map [1~ :SmartHomeKey<CR>
imap [1~ <C-o>:SmartHomeKey<CR>

call pathogen#infect()
