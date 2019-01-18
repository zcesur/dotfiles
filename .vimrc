" Plugins
if !filereadable(expand('~/.vim/autoload/plug.vim'))
    silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/plugged'))
Plug 'tpope/vim-commentary'                " Comment stuff out
Plug 'tpope/vim-surround'                  " Mappings to easily delete, change and add surroundings in pairs
Plug 'tpope/vim-repeat'                    " Enable repeating supported plugin maps with '.'
Plug 'tpope/vim-dispatch'                  " Asynchronous build and test dispatcher
Plug 'w0rp/ale'                            " Asynchronous Lint Engine
Plug 'epeli/slimux'                        " Interact with different tmux panes directly from Vim
Plug 'easymotion/vim-easymotion'           " EasyMotion
Plug 'mattn/emmet-vim'                     " Expanding abbreviations
Plug 'godlygeek/tabular'                   " Text filtering and alignment

Plug 'eagletmt/ghcmod-vim'                 " Haskell stuff
Plug 'eagletmt/neco-ghc'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'neovimhaskell/haskell-vim'

Plug 'pangloss/vim-javascript'             " Javascript stuff
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'elzr/vim-json'
call plug#end()

" Main config
syntax enable                       " enable syntax processing
colorscheme Tomorrow-Night-Eighties
set backspace=indent,eol,start
set number                          " show line numbers
set showcmd                         " show command in bottom bar
set cursorline                      " highlight current line
set wildmenu                        " visual autocomplete for command menu
set showmatch                       " highlight matching parenthesis-like character
set incsearch                       " search as characters are entered
set hlsearch                        " highlight matches
set mouse=a                         " mouse functionality
set pastetoggle=<F2>                " conveniently turn paste on and off
set shortmess=a
hi Error NONE
hi! def link jsonKeyword Identifier

" Status line
set statusline=
set statusline+=%#comment#
set statusline+=\ %F%m%r%h%w\               " file path
set statusline+=%{GitStatus()}              " git branch
set statusline+=%#warningmsg#
set statusline+=%{LinterStatus()}
set statusline+=%*
set statusline+=%#keyword#
set statusline+=%=\ %n\                     " buffer number
set statusline+=%{&ff}\                     " file format
set statusline+=%y\                         " file type
set statusline+=%{strlen(&fenc)?&fenc:&enc} " encoding
set statusline+=%5l/%L\                     " current line
set statusline+=%4v\                        " virtual column number
set statusline+=0x%04B\                     " character under cursor
set laststatus=2

" Indentation
filetype indent on
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
au Filetype javascript,json,css,scss,yaml,htmldjango setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au Filetype vim let g:vim_indent_cont = &sw

" Slimux config
nnoremap <C-c><C-c> :SlimuxREPLSendLine<CR>
vnoremap <C-c><C-c> :SlimuxREPLSendSelection<CR>
nnoremap <C-c><C-v> :SlimuxREPLConfigure<CR>
let g:slimux_select_from_current_window = 1

" Misc. mappings & abbreviations
nnoremap <leader><space> :noh<CR>
xnoremap p pgvy 
noremap % v%
nnoremap <Space> @q
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" HTML/JSX tab completion
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" EasyMotion config
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ALE config
let g:ale_set_highlights = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nnoremap <S-t> :ALEFix<CR>
let g:ale_linters = {
\   'haskell': ['ghc-mod', 'hlint'],
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'go': ['gometalinter', 'gofmt'],
\   'sh': ['shellcheck']
\}
let g:ale_fixers = {
\   'haskell': ['hlint'],
\   'python': ['yapf'],
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'go': ['gofmt'],
\   'css': ['prettier'],
\   'json': ['prettier', 'jq'],
\   'sh': ['shfmt']
\}
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0

augroup detect
    au!
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    au BufNewFile,BufFilePre,BufRead Dockerfile* set filetype=dockerfile
    au BufNewFile,BufFilePre,BufRead .zshrc set filetype=sh
    au FileType javascript let g:jsx_ext_required = 0
augroup END

augroup overlength
    au!
    au FileType python,haskell,javascript,go,sh
        \ highlight OverLength ctermbg=red ctermfg=white |
        \ match OverLength /\%81v.\+/ |
        \ nnoremap <leader><leader> :cal cursor(0, 80) \| :execute "normal! Bhxi\<lt>CR>"<CR>
augroup END

augroup comment
    au!
    au FileType python setlocal commentstring=#\ %s
    au FileType haskell setlocal commentstring=--\ %s
    au FileType go,json setlocal commentstring=//\ %s
    au FileType vim setlocal commentstring=\"\ %s
    au FileType html setlocal commentstring=<!--\ %s\ -->
augroup END

augroup execute
    au!
    au FileType python let b:exec = 'python3'
    au FileType go let b:exec = 'go run'
    au FileType haskell let b:exec = 'runhaskell'
    au FileType javascript let b:exec = 'babel-node'
    au FileType sh let b:exec = 'bash'
    au FileType perl let b:exec = 'perl'
    au FileType python,go,haskell,javascript,sh,perl
        \ map <buffer> <S-e> :w<CR>:echo system(b:exec . " " . expand("%"))<CR>

    au FileType markdown let b:dispatch = 'grip % -b' |
        \ map <buffer> <S-e> :Dispatch<CR>
augroup END
