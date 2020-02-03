" Main config
filetype off
syntax enable                       " enable syntax processing
colorscheme Tomorrow-Night-Eighties
set backspace=indent,eol,start
set number relativenumber           " show hybrid line numbers
set showcmd                         " show command in bottom bar
set cursorline                      " highlight current line
set wildmenu                        " visual autocomplete for command menu
set showmatch                       " highlight matching parenthesis-like character
set incsearch                       " search as characters are entered
set hlsearch                        " highlight matches
set mouse=a                         " mouse functionality
set pastetoggle=<F2>                " conveniently turn paste on and off
set shortmess=a
filetype plugin on

" Highlighting
hi DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
hi DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
hi LineNr                ctermfg=8
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
au Filetype haskell,xml,java,json,javascript.jsx,typescript,css,scss,yaml,htmldjango setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
au Filetype vim let g:vim_indent_cont = &sw

" Misc. mappings
nnoremap <Leader><Space> :noh<CR>
xnoremap p pgvy
nnoremap <Space> @q
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz

" Abbreviations
cnoreabbrev W w
cnoreabbrev W! w!
cnoreabbrev Q q
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev wQ wq
cnoreabbrev WQ wq

" slimux config
nnoremap <C-c><C-c> :SlimuxREPLSendLine<CR>
vnoremap <C-c><C-c> :SlimuxREPLSendSelection<CR>
nnoremap <C-c><C-v> :SlimuxREPLConfigure<CR>
let g:slimux_select_from_current_window = 1

" emmet-vim config
let g:user_emmet_leader_key='<Tab>'

" ale config
nnoremap <silent> <C-j> :ALENext<cr>
nnoremap <silent> <C-k> :ALEPrevious<cr>
nnoremap <S-t> :ALEFix<CR>
let g:ale_set_highlights = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_go_golangci_lint_options = '--fast'
let g:ale_linters = {
\   'go': ['golangci-lint'],
\   'sh': ['shellcheck'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}
let g:ale_fixers = {
\   'go': ['gofmt'],
\   'sh': ['shfmt'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'css': ['prettier'],
\   'less': ['prettier'],
\   'svg': ['tidy'],
\   'json': ['prettier', 'jq'],
\}

" vim-go config
let g:go_fmt_fail_silently = 1
let g:go_highlight_diagnostic_errors=0
let g:go_highlight_diagnostic_warnings=0

" vim-jsx config
let g:jsx_ext_required = 0

" vim-easymotion config
map <Leader>f <Plug>(easymotion-fl)
map <Leader>F <Plug>(easymotion-Fl)
map <Leader>t <Plug>(easymotion-tl)
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" vimwiki config
let g:vimwiki_list = [{'path': '~/proj/cheatsheets/', 'syntax': 'markdown', 'ext': '.md'}]

" vim-hardtime config
let g:hardtime_default_on = 1

augroup detect
    au!
    au BufEnter,BufRead,BufNewFile *.md set filetype=markdown
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    au BufNewFile,BufFilePre,BufRead *.tmpl set filetype=gohtmltmpl |
        \ set noet ci pi sts=0 sw=4 ts=4
    au BufNewFile,BufFilePre,BufRead Dockerfile* set filetype=dockerfile
augroup END

augroup overlength
    au!
    au FileType haskell
        \ highlight OverLength ctermbg=red ctermfg=white |
        \ match OverLength /\%81v.\+/ |
        \ nnoremap <Leader><Leader> :cal cursor(0, 80) \| :execute "normal! Bhxi\<lt>CR>"<CR>
augroup END

augroup comment
    au!
    au FileType python,sh,yaml setlocal commentstring=#\ %s
    au FileType haskell setlocal commentstring=--\ %s
    au FileType go,json setlocal commentstring=//\ %s
    au FileType vim setlocal commentstring=\"\ %s
    au FileType html setlocal commentstring=<!--\ %s\ -->
    au FileType dosini setlocal commentstring=;\ %s
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
        \ noremap <buffer> <Leader>r :w<CR>:echo system(b:exec . " " . expand("%"))<CR>

    au FileType markdown let b:dispatch = 'grip % -b' |
        \ noremap <buffer> <Leader>r :Dispatch<CR>
augroup END
