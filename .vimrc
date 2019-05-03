"set nocp lz
set nocompatible lazyredraw
set viminfo+=n/workspace/.viminfo

call plug#begin()

" Fast loading plugins
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
command -nargs=* -complete=file D Dispatch <args>
Plug 'rking/ag.vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'tpope/vim-sensible'
Plug 'tomtom/tcomment_vim'
Plug 'lervag/vim-latex'
Plug 'nathanaelkane/vim-indent-guides'

" On-demand loading for slow loading plugins
Plug 'vim-scripts/Conque-GDB', {'on':['ConqueGdb', 'ConqueTerm']}
command -nargs=* -complete=file Gdb ConqueGdb <args>
let g:ConqueGdb_GdbExe = expand('$VDFSTREE/tests/gdb.sh')

Plug 'junegunn/vim-easy-align', {'on':'EasyAlign'}
Plug 'scrooloose/nerdtree', {'on':['NERDTreeToggle']}
"Plug 'tisyang/taglist', {'on':'TlistToggle'}
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'scrooloose/syntastic', {'on':[]}
Plug 'vim-airline/vim-airline', {'on':[]}
Plug 'vim-airline/vim-airline-themes', {'on':[]}
Plug 'SirVer/ultisnips', {'on':[]}
Plug 'honza/vim-snippets', {'on':[]}
Plug 'Valloric/YouCompleteMe', {'on':[], 'do':'python3 install.py --clang-completer'}
Plug 'airblade/vim-gitgutter', {'on':[]}
let g:gitgutter_max_signs = 5800

function LoadYcmEtc()
  call plug#load('ultisnips', 'vim-snippets', 'vim-gitgutter', 'syntastic',
      \ 'YouCompleteMe', 'vim-airline', 'vim-airline-themes',
      \ 'vim-easy-align')
  call youcompleteme#Enable()
endfunction

" Only load YCM and friends once
augroup load_ycm_etc
  autocmd!
  " Still beats Java IDE start up time :)
  autocmd FileType java call LoadYcmEtc() | autocmd! load_ycm_etc
  autocmd InsertEnter * call LoadYcmEtc() | autocmd! load_ycm_etc
augroup END

Plug 'xolox/vim-misc', {'on':[]}
Plug 'xolox/vim-notes', {'on':[]}
command -nargs=? Note call plug#load('vim-misc', 'vim-notes') | Note <args>

" Using git URL
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
"Plug 'nsf/gocode', { 'tag':'go.weekly.2012-03-13', 'rtp':'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir':'~/.fzf', 'do':'yes \| ./install' }
Plug 'junegunn/fzf', {'on':'FZF', 'dir':'~/.fzf', 'do':'yes \| ./install'}

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'
"Plug '~/src/vim-taglist', {'on':'TlistToggle'}

call plug#end()

" builtin man pages
command -nargs=1 M runtime ftplugin/man.vim | Man <args>

"set sw=2 ai si et sta nu
set sw=2 ai et sta nu tw=72

" scons is python
au BufNewFile,BufRead *.sc set filetype=python

"temp note stuff
"set tw=72 wrap
"set linebreak

"set tags=./tags,../tags,../../tags,../../../tags,../../../../tags,tags
let mapleader=","
let maplocalleader=","

"let g:notes_smart_quotes = 0
let g:notes_suffix = '.txt'
let g:notes_directories = ['~/Documents/Notes']

syntax on
filetype plugin indent on

set t_Co=256
"let g:solarized_termcolors=256
let g:ConqueTerm_TERM='xterm-256color'
let g:ConqueTerm_StartMessages = 0
set background=dark
silent! colors jellybeans
"colors seoul256

" airline stuff
let g:airline_theme='distinguished'
"let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:syntastic_mode_map = {"mode":"passive", "active_filetypes":[], "passive_filetypes":[]}
let g:syntastic_enable_highlighting = 0

let g:UltiSnipsExpandTrigger="<c-j>"

let g:latex_toc_resize = 0
let g:latex_toc_width = 38

let g:ycm_extra_conf_globlist = [expand('$VMTREE/\*')]
let g:ycm_autoclose_preview_window_after_completion = 1

let g:Lf_CacheDirectory = '/workspace'

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Toggle taglist
map <silent> <F8> :TlistToggle<CR>

" ycm
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" easy align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" gitv
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>

"Ag
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>
