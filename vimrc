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
set scrolloff=5
set shell=/bin/bash
set showcmd
set showmatch
set showmode
set splitright
set textwidth=0
set title
set viminfo='20,\"50

set autoindent
set expandtab
set smarttab

set shiftwidth=4
set softtabstop=4
set tabstop=4

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

syntax on
colorscheme default
set background=dark

if has("autocmd")
    filetype plugin on
    filetype indent on
    let php_sql_query=1
    let php_htmlInStrings=1
endif

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

if &term == "screen"
    set t_ts=k
    set t_fs=\
    set ttymouse=xterm2
endif

" Set window title to same as statusline
" let &titlestring=&statusline

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif


"" Keybinds

let mapleader=","

" Easier diffget
if &diff
    nnoremap <Leader>d[ :diffget 1
    nnoremap <Leader>d] :diffget 3
endif

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

" Change Y to copy from current character to end of line
" (mimic y0's behavior but backwards)
noremap Y y$

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Disable man key
nnoremap K <nop>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" Ctrl+S to save
nmap <C-s> :write!<CR>
imap <C-s> <C-o>:write!<CR>

" Map _$ to trim whitespace on the end of lines
function! Preserve(command)
    let _s=@/
    let l = line(".")
    let c = col(".")
    execute a:command
    let @/=_s
    call cursor(l, c)
endfun

nmap <silent> _$ :call Preserve("%s/\\s\\+$//e")<CR><C-l>

" Fix numpad over some SSH connections
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


"" Auto Commands

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Exit insert mode after 15 seconds of no input
" au CursorHoldI * stopinsert
" au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
" au InsertLeave * let &updatetime=updaterestore

" Special vb template binds
au BufRead */templates/*.html           call s:template_binds()
au BufNewFile,BufRead *.html            call s:html_settings()

function! s:template_binds()
    setlocal makeprg=clear;php\ ~/bin/update_templates.php\ %:p
    nmap <buffer> <C-b> :make!<CR>
    imap <buffer> <C-b> <C-o>:make!<CR>
endfun

function! s:html_settings()
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endfun

""" Plugins

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
