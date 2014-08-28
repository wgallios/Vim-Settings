" vim: ts=4 sts=4 sw=4 et ai

set autowrite
set backspace=indent,eol,start
set backupcopy=no
set history=50
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:-
set mouse=a
set nobackup
set nocindent
set nocompatible
set noignorecase
set ruler
set scrolloff=5
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
set shell=/bin/bash
set showcmd
set showmatch
set showmode
set showtabline=2
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

" fix diff colors
highlight DiffText ctermbg=1

if has("autocmd")
    filetype plugin on
    filetype indent on
    let php_folding=1
    " let php_sql_query=1
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

if &term == "screen" || &term == "screen-256color"
    set t_ts=k
    set t_fs=\
    set ttymouse=xterm2
endif

" Set window title to same as statusline
" let &titlestring=&statusline

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"

    set t_Co=256
    set t_AB=^[[48;5;%dm
    set t_AF=^[[38;5;%dm


    "set t_Co=16
    "set t_Sf=[3%dm
    "set t_Sb=[4%dm
endif


"" Keybinds

let mapleader=","
nmap ; :
vmap ; :

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

" inoremap <Esc>[A {
" inoremap <Esc>[B }
inoremap <Esc>[C <S-Right>
inoremap <Esc>[D <S-Left>

nnoremap <Esc>[A {
nnoremap <Esc>[B }
nnoremap <Esc>[C <S-Right>
nnoremap <Esc>[D <S-Left>

" Tab movement keys
nnoremap <silent> <Esc><Right> :tabn<CR>
nnoremap <silent> <Esc><Left> :tabp<CR>

" Change Y to copy from current character to end of line
" (mimic y0's behavior but backwards)
noremap Y y$

" Make p in Visual mode replace the selected text with the "" register.
" vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
vnoremap p "_dP
vnoremap P "_dP

" Disable man key
nnoremap K <nop>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" Show NERDTree
noremap <silent> <F2> :NERDTreeToggle<CR>

" Show Tabman
noremap <silent> <F3> :TMToggle<CR>

" Show Function List
noremap <silent> <F4> :Flisttoggle<CR>

" Save session
noremap <silent> <F5> :wa <Bar> mksession! ~/.vim/session <Bar> echo "Saved session"<CR>
noremap <silent> <F6> :source ~/.vim/session<CR>

" Ctrl+S to save
nmap <C-s> :write!<CR>
imap <C-s> <C-o>:write!<CR>

" Remove annoying default Ctrl+B behavior
nmap <C-b> <nop>
imap <C-b> <nop>

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

" Fix keys over some SSH connections
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

noremap  <Esc>[1~ <Home>
cnoremap <Esc>[1~ <Home>

noremap  <Esc>[4~ <End>
cnoremap <Esc>[4~ <End>
inoremap <Esc>[4~ <End>

"" Auto Commands

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Exit insert mode after 15 seconds of no input
" au CursorHoldI * stopinsert
" au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
" au InsertLeave * let &updatetime=updaterestore

" Special vb template binds
au BufNewFile,BufRead */templates/*.html   call s:template_binds()
au BufNewFile,BufRead *.html               call s:html_settings()

function! s:template_binds()
    setlocal makeprg=clear;php\ ~/bin/update_templates.php\ %:p
    nmap <buffer> <C-b> :make!<CR>
    imap <buffer> <C-b> <C-o>:make!<CR>
endfun

function! s:html_settings()
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal textwidth=0
endfun


""" Custom Commands

command! CodingStandards call RunCodingStandards()
function! RunCodingStandards()
    retab
    call Preserve("%s/\\(\\S\\)\\s*{$/\\1\\r{/")
    call Preserve("%s/\\Cif(/if (/e")
    call Preserve("%s/\\Cfor(/for (/e")
    call Preserve("%s/\\Cswitch(/switch (/e")
    call Preserve("%s/\\Cforeach(/foreach (/e")
    call Preserve("%s/\\Cwhile(/while (/e")
    call Preserve("%s/\\Ccatch(/catch (/e")
    call Preserve("%s/\\s\\+$//e")
    " call Preserve("normal gg=G")
    call Preserve("v/./,/./-j")
    nohlsearch
endfun


""" Plugins

" JS indenting
" let g:SimpleJsIndenter_BriefMode = 1

" New JS/HTML indenting
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1  = "inc"

" Taglist
noremap <silent> <Leader>tt :TlistToggle<CR>
let g:Tlist_Auto_Open=0

" NERDTree
let NERDTreeQuitOnOpen=1

" SmartHome
noremap  <silent> [1~ :SmartHomeKey<CR>
inoremap <silent> [1~ <C-o>:SmartHomeKey<CR>

" TComment
let g:tcommentGuessFileType_php = 'php'
let g:tcommentMapLeader1 = ''
let g:tcommentMapLeader2 = ''
let g:tcommentMapLeaderOp1 = ''
let g:tcommentMapLeaderOp2 = ''
nmap C :TComment<CR>
vmap C :TComment<CR>

" Tabularize
nmap `= :Tabularize /^[^=]\+\zs=>\?<CR>
vmap `= :Tabularize /^[^=]\+\zs=>\?<CR>
nmap `; :Tabularize /^[^:]\+\zs:<CR>
vmap `; :Tabularize /^[^:]\+\zs:<CR>
nmap <Leader>t= :Tabularize /^[^=]\+\zs=>\?<CR>
vmap <Leader>t= :Tabularize /^[^=]\+\zs=>\?<CR>
nmap <Leader>t; :Tabularize /^[^:]\+\zs:<CR>
vmap <Leader>t; :Tabularize /^[^:]\+\zs:<CR>
nmap <Leader>t: :Tabularize /^[^:]\+\zs:<CR>
vmap <Leader>t: :Tabularize /^[^:]\+\zs:<CR>


" dbext

nmap <F7> :DBResultsClose<CR>
"vnoremap <F9> <Leader>se <Plug>DBExecVisualSQL :'<,'>DBExecVisualSQL
nmap <F8> :DBPromptForBufferParameters<Cr>
vnoremap <F9> :DBExecVisualSQL<cr>
"let g:dbext_default_profile_mongodb


" let g:omni_sql_no_default_maps = 1

if filereadable($HOME."/.vim/localrc")
    source ~/.vim/localrc
endif

"loads dbext plugin
"if filereadable($HOME."/.vim/bundle/dbext/autoload/dbext.vim")
"    source ~/.vim/bundle/dbext/autoload/dbext.vim
"endif

"if filereadable($HOME."/.vim/bundle/vimongous/vimongous.vim")
"    source ~/.vim/bundle/vimongous/vimongous.vim
"endif



" vim-pipe
"nmap <Leader>r

" vim-pipe mongodb setting
autocmd BufNewFile, BufReadPost *.mql setlocal filetype=mongoql

"autocmd BufEnter *.tpl colorscheme default


" vim-less
nnoremap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>

" airline
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif

let g:airline_symbols.space = "\ua0"

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Track the engine.
"Plugin 'bundle/utisnips'

" Snippets are separated from the engine. Add this if you want them:
"Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

call pathogen#infect()
