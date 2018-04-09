if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/bundles/repos/github.com/Shougo/dein.vim
set runtimepath+=~/.cache/dein/bundles/repos/github.com/Shougo/deoplete.nvim
set runtimepath+=~/.cache/dein/bundles/repos/github.com/zchee/deoplete-jedi

" to install plugings -> :call dein#install()
" to update plugings  -> :call dein#update()
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein/bundles')

  call dein#add('~/.cache/dein/bundles/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim', {'on_i': 1})

  " vim language pack, on demand loaded
  call dein#add('sheerun/vim-polyglot')

  " vim syntax checking, lazy load on write
  call dein#add('vim-syntastic/syntastic', {'on_w': 1})

  " manually close matching braces with default Ctrl-L
  call dein#add('tranvansang/vim-close-pair', {'on_i': 1})

  " additional c++ syntax highlighting lazy load on filetype
  call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft': [ 'cc', 'cpp', 'h', 'hpp' ]})

  " autocompletion for c/c++, lazy load on filetype
  call dein#add('Rip-Rip/clang_complete', {'on_ft': [ 'c', 'cc', 'cpp', 'h', 'hpp' ] })

  " auto completion for python, lazy load on filytype
  call dein#add('zchee/deoplete-jedi', {'on_ft': [ 'py' ] })

  " auto completion for java, lazy load on filetype
  call dein#add('artur-shaik/vim-javacomplete2', {'on_ft': [ 'java' ] })

  " go autocomplete
  call dein#add('zchee/deoplete-go', {'build': 'make', 'on_ft': [ 'go' ] })

  " haskell
  call dein#add('neovimhaskell/haskell-vim', {'on_ft' : [ 'hs' ] })

  " racket (scheme)
  call dein#add('wlangstroth/vim-racket', {'on_ft' : [ 'rkt', 'rktl'] })

  " command line fuzzy finder, use :FZF in vim to start
  call dein#add('junegunn/fzf')

  " Themes
  call dein#add('szorfein/darkest-space')
  call dein#add('nightsense/simplifysimplify')
  call dein#add('rakr/vim-one')
  call dein#add('dylanaraps/wal.vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

" syntax
if !exists("g:syntax_on")
    syntax enable
endif

"colorscheme one 
"set background=dark
colorscheme wal
"set termguicolors " doesn't work with pywal

" keep a certain number of commands and search patterns in the history
" default in neovim is max (10000)
set history=1000

" displays cursor position in bottom right corner
set ruler

" displays incomplete command in bottom right corner to the left of ruler
set showcmd

set number

" multi-line tabbing in visual tab
vmap <Tab> >
vmap <S-Tab> <

" set indent and spacing
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set smartindent

autocmd Filetype make setlocal noexpandtab
autocmd Filetype c setlocal ts=4 sw=4 sts=4
autocmd Filetype cc setlocal ts=4 sw=4 sts=4
autocmd Filetype cpp setlocal ts=4 sw=4 sts=4
autocmd Filetype h setlocal ts=4 sw=4 sts=4
autocmd Filetype hpp setlocal ts=4 sw=4 sts=4
autocmd Filetype go setlocal ts=4 sw=4 sts=4
autocmd Filetype java setlocal ts=4 sw=4 sts=4
autocmd Filetype python setlocal ts=4 sw=4 sts=4
au BufEnter,BufRead *.py setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" don't redraw as much
set lazyredraw

" remap beginning/end of line keys from ^ $ to B E 
" this is to make it similar to beginning/end of word keys b e
nnoremap ^ <nop>
nnoremap $ <nop>
nnoremap B ^
nnoremap E $

" gitgutter config
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0 

" deoplete
set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" omnifunction trigger
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" deoplete settings for clang_complete
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'

" deoplete key config
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Vim needs to be built with Python scripting support, and must be
" able to find Merlin's executable on PATH.
if executable('ocamlmerlin') && has('python')
  let s:ocamlmerlin = substitute(system('opam config var share'), '\n$', '', '''') . "/ocamlmerlin"
  execute "set rtp+=".s:ocamlmerlin."/vim"
  execute "set rtp+=".s:ocamlmerlin."/vimbufsync"
endif

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:syntastic_enable_racket_racket_checker = 1

" statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?' '.l:branchname.' ':''
endfunction

set laststatus=2
set statusline= 
set statusline+=\ %{StatuslineGit()}
set statusline+=//
set statusline+=\ %f " filepath
set statusline+=\ //
set statusline+=\ %y " filetype
set statusline+=\ //
set statusline+=\ %{&fileformat}
set statusline+=\ //
set statusline+=\ %{&fileencoding?fileencoding:&encoding}
set statusline+=%= " rightside
set statusline+=%p%%
set statusline+=\ //
set statusline+=\ %l/%c
set statusline+=\ 
