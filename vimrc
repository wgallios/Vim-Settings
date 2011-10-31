" vim: ts=4 sts=4 sw=4 et ai

set autowrite
set backspace=indent,eol,start
set backupcopy=no
set history=50
set incsearch
set laststatus=2
set mouse=a
set noautoindent
set nobackup
set nocompatible
set nolist
set ruler
set shell=/bin/bash
set showcmd
set showmatch
set showmode
set splitright
set textwidth=0
set title
set viminfo='20,\"50

set wildmenu
set wildignore+=.git/*,.hg/*,.svn/*,*.orig          " version control
set wildignore+=._*,.DS_Store                       " OSX nonsense
set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest    " compiled object files
set wildignore+=*.spl,.sw?,.py?                     " more binary stuff

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.o,.info,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx

colorscheme default
set background=dark

" Highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set statusline=%f    " Path.
set statusline+=%m   " Modified flag.
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.

set statusline+=\    " Space.

set statusline+=%=   " Right align.

" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=)

" Line and column position and counts.
set statusline+=\ (line\ %l\/%L,\ col\ %03c)

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

let mapleader=","

" // clears search highlight
nnoremap <silent> // :noh<CR>

" Space toggles folds
nnoremap <Space> za
vnoremap <Space> za

" z0 = recursively open top-level fold we're in
nnoremap z0 zCz0

" Tab indenting
nnoremap <Tab> >>
nnoremap <S-Tab> <<

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Quick word jumping with Ctrl+Arrows
inoremap <C-[>[A <Up>
inoremap <C-[>[B <Down>
inoremap <C-[>[C <S-Right>
inoremap <C-[>[D <S-Left>

nnoremap <C-[>[A <Up>
nnoremap <C-[>[B <Down>
nnoremap <C-[>[C <S-Right>
nnoremap <C-[>[D <S-Left>

" Tab movement keys
nnoremap <Right> :tabn<CR>
nnoremap <Left> :tabp<CR>

" Change Y to copy from current character to end of line (mimic y0's behavior but backwards)
noremap Y y$

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Disable man key
nnoremap K <nop>

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

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

augroup filetype
  au BufRead reportbug.*                set ft=mail
  au BufRead reportbug-*                set ft=mail
augroup END

" file settings
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

" Fix numpad over SSH
inoremap <Esc>Oq 1
inoremap <Esc>Or 2
inoremap <Esc>Os 3
inoremap <Esc>Ot 4
inoremap <Esc>Ou 5
inoremap <Esc>Ov 6
inoremap <Esc>Ow 7
inoremap <Esc>Ox 8
inoremap <Esc>Oy 9
inoremap <Esc>Op 0
inoremap <Esc>On .
inoremap <Esc>OR *
inoremap <Esc>OQ /
inoremap <Esc>Ol +
inoremap <Esc>OS -

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
noremap [1~ :SmartHomeKey<CR>
inoremap [1~ <C-o>:SmartHomeKey<CR>

call pathogen#infect()
