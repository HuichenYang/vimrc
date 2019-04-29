inoremap jj <Esc>

set nocompatible

filetype plugin indent on " Load plugins according to detected filetype
syntax on

" indent, tab and spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set backspace=indent,eol,start

set hidden           " Switch between buffers without having to save first
set laststatus=2     " Always show statusline
set display=lastline " Set as much as possible of the last line

set noshowmode       " Show current mode in command-line
set showcmd          " Show already typed keys when more are expected

set ttyfast          " Faster redrawing
set lazyredraw       " Only redraw when neccessary

set splitright       " Open new windows right of the current windows

set nu               " show line numbers
set cursorline       " Find the current line

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" if has('vim')
    " Plug 'Shougo/defx.nvim', { 'do': 'UpdateRemotePlugins' }
" else
    " Plug 'Shougo/defx.nvim'
    " Plug 'roxma/nvim-yarp'
    " Plug 'roxma/vim-hug-neovim-rpc'
" endif
" Plug 'kristijanhusak/defx-icons'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" color themes
Plug 'rakr/vim-one'
Plug 'liuchengxu/space-vim-dark'
Plug 'itchyny/lightline.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Shougo/echodoc.vim'
" Plug 'Yggdroot/indentline'
Plug 'kien/rainbow_parentheses.vim'
Plug 'scrooloose/nerdcommenter'

" auto-pair [], (), <>
Plug 'jiangmiao/auto-pairs'

Plug '~/.vim/plugged/YouCompleteMe'

" for align
Plug 'junegunn/vim-easy-align'

Plug 'ludovicchabant/vim-gutentags'

Plug 'skywind3000/asyncrun.vim'

Plug 'w0rp/ale'

Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpFrowardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" Initialize plugin system
call plug#end()

" color theme
colorscheme one
set termguicolors
set background=dark
let g:lightline = { 'colorscheme': 'one' }

let g:cpp_class_scope_hightlight=1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" settings for vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" For AsyncRun
let g:asyncrun_open=6
let g:asyncrun_bell=1
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <silent> <F9> :AsyncRun g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
" nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
" nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
" nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
" nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>

" For ctags
set tags=./.tags;,.tags

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:ale_linters = {
\ 'cpp': [ 'clang', 'clang-format', 'cppcheck' ],
\   'c': [ 'clang', 'gcc', 'clang-format', 'cppcheck' ],
\}

let g:ale_sign_column_always=1
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']

nmap <leader>sp <Plug>(ale_previous_wrap)
nmap <leader>sn <Plug>(ale_next_wrap)

let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

let g:echodoc#enable_at_startup = 1

" using rainbow parentheses when vim enter
au VimEnter * RainbowParenthesesToggle

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" set the location of viminfo
set viminfo+=n~/.vim/viminfo

set encoding=UTF-8

" for vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdgm'
set conceallevel=1
set concealcursor=

let mapleader=','
let maplocalleader=','

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
