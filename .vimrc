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
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
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
au Filetype haskell,typescript,typescriptreact,java,css,scss,yaml,htmldjango setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
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

" vim-go config
let g:go_fmt_fail_silently = 1
let g:go_highlight_diagnostic_errors=0
let g:go_highlight_diagnostic_warnings=0

" yats.vim config
hi link tsxTag tsxTagName
hi link tsxCloseTag tsxTagName
hi link tsxCloseString tsxTagName

" vim-easymotion config
map <Leader>f <Plug>(easymotion-fl)
map <Leader>F <Plug>(easymotion-Fl)
map <Leader>t <Plug>(easymotion-tl)
map <Leader>T <Plug>(easymotion-Tl)
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" NERDTree config
map <C-n> :NERDTreeToggle<CR>
" open automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" vim-markdown config
let g:vim_markdown_folding_disabled = 1
map <C-t> :TableFormat<CR>

augroup detect
    au!
    au BufEnter,BufRead,BufNewFile *.md set filetype=markdown
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    au BufNewFile,BufFilePre,BufRead *.tmpl set filetype=gohtmltmpl |
        \ set noet ci pi sts=0 sw=4 ts=4
    au BufNewFile,BufFilePre,BufRead Dockerfile* set filetype=dockerfile
augroup END

augroup comment
    au!
    au FileType python,sh,yaml setlocal commentstring=#\ %s
    au FileType haskell setlocal commentstring=--\ %s
    au FileType go,json,typescriptreact setlocal commentstring=//\ %s
    au FileType vim setlocal commentstring=\"\ %s
    au FileType html setlocal commentstring=<!--\ %s\ -->
    au FileType dosini setlocal commentstring=;\ %s
augroup END

" coc config
let g:coc_disable_startup_warning = 1

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
