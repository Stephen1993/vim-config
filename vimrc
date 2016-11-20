" ----------------------------------------------------------------------------
" Author:  Stephen
" Version: 1.1
" ----------------------------------------------------------------------------

set nocompatible " vim是vi的加强版，次句是关闭兼容模式，使用vim的所有扩展功能，必须是第一个设定的选项

"Load plugins
if filereadable(expand("~/.vim/vimrc.bundles"))
  source ~/.vim/vimrc.bundles
endif

filetype plugin indent on " 允许使用插件
syntax enable

" ----------------------------------------------------------------------------
"基本配置
" ----------------------------------------------------------------------------
syntax on " 语法高亮
au BufNewFile,BufRead *.vue set filetype=html " 设置vue格式被解析为html
colorscheme solarized     " 设置主题
set background=dark       " 设置主题样式-dark样式
set t_Co=256              " 修改终端支持256色
set history=200           " 记录历史命令长度
set autoread              " 文件在vim之外修改过，自动重新读入
set shortmess=atI         " 不显示援助乌干达儿童提示
set nobackup              " 禁止生成临时文件
set noswapfile            " 不生成swap文件
set cursorcolumn          " 高亮当前列
set cursorline            " 高亮当前行
" set t_ti= t_te=           " 退出vim后，内容仍然显示在终端
set mouse=a               " 鼠标模式
set selection=inclusive   " set selection=exclusive, 指定在选择文本时，光标所在位置也属于被选中的范围
set selectmode=mouse,key  " 这三行一起使用，允许用鼠标进行区域选择
set title                 " 改变终端title
set novisualbell          " 关闭闪烁
set noerrorbells          " 关闭闪烁
set t_vb=                 " vim命令出错时会有响声，该设置关闭响声
set tm=500
set nostartofline         " keep cursor postion when switching between buffers
set number                " show line number
set nowrap                " 当一行放不下代码时，取消自动换行
set list                  " 显示多余的前置或者后置空格
set listchars=tab:›\ ,trail:•,extends:❯,precedes:❮ " 在set list下高亮显示tab和空格
set showmatch             " 设置匹配模式，显示匹配的括号
set mat=2                 " How many tenths of a second to blink when matching brackets
set hlsearch              " 高亮查询的单词
" set ignorecase            " 搜索模式忽略大小写
" set smartcase             " 在set ignorecase下，如果搜索模式包含大些字符则不忽略大小写
set incsearch             " 实时显示匹配
set foldenable            " 允许代码折叠
set foldmethod=indent     " options: manual, indent, expr, syntax, diff, marker, indent为按照缩进层次自动折叠
set foldlevel=99          " 根据指定的级别折叠缩进
set smartindent           " 智能缩进, 每一行跟前一行有相同的缩进
set autoindent            " 自动缩进, 新增的行和前一行有相同的缩进形式
set tabstop=4             " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4          " number of spaces to use for autoindenting
set softtabstop=4         " Number of spaces that a <Tab> counts for while performing editing operations
set smarttab              " 按tab键智能加入空格
set expandtab             " when typing <Tab>, use <space> instead
set shiftround            " 使用 >> 或 << 时， 依shiftwidth 调整宽度
" set hidden                " 允许在有未保存的修改时切换缓冲区，此时的修改由vim 负责保存
set wildmode=longest:full,full " 在命令行打开文件或者输入命令时按tab自动补全
set ttyfast               " 指示一个快速的终端连接
set relativenumber        " show relative line number
set ruler                 " show the current line number and column number在右下脚
" set showcmd               " 在屏幕右下脚显示正在输入的命令
" set noshowmode            " 显示当前处于什么模式下
set scrolloff=7           " 光标上下的最少行

" File encode:encode for varied filetype
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=en
set termencoding=utf-8

set ffs=unix,dos,mac      " Use Unix as the standard file type
set formatoptions+=m
set formatoptions+=B      " When joining lines, don't insert a space between two multi-byte characters.
set completeopt=longest,menu " behaviour of insert mode completion
set wildmenu              " auto complete command 并列出 list
set wildignore=**.o,*~,.swp,*.bak,*.pyc,*.class " Ignore compiled files, 忽略这些文件，不会参与自动补全

set viminfo^=%            " Remember info about open buffers on close
set magic                 " For regular expressions turn magic on

set backspace=eol,start,indent               " Configure backspace so it acts as it should act
set whichwrap+=h,l    " 当光标在行首/行尾时，允许使用h,l移动到上一行行尾/下一行行首
set pastetoggle=<F5>                         " 切换'paste'的键盘码

"let &colorcolumn="80,".join(range(120,999),",")
" let &colorcolumn="120" " 120列高亮

autocmd InsertEnter * :set norelativenumber " no relativenumber in insert mode
autocmd InsertLeave * :set relativenumber   " show relativenumber when leave insert mode

"create undo file
if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
  set undodir=~/.undodir/
endif

"if has('statusline')
"    set laststatus=2                         " 是否显示状态栏, 2-一直显示
"    set statusline=%<%f\                     " Filename
"    set statusline+=%w%h%m%r                 " Options
"    set statusline+=%{fugitive#statusline()} " Git Hotness
"    set statusline+=\ [%{&ff}/%Y]            " Filetype
"    set statusline+=\ [%{getcwd()}]          " Current dir
"    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
"endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
au InsertLeave * set nopaste

"close popup menu when leave insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType javascript,json,css,scss,html set tabstop=2 shiftwidth=2 expandtab ai

autocmd BufReadPre * if getfsize(expand("%")) > 10000000 | syntax off | endif

" ----------------------------------------------------------------------------
" Key Mappings: http://haoxiang.org/2011/09/vim-modes-and-mappin/
" ----------------------------------------------------------------------------
" 表示用vim保存文件不需要必要的权限
" command! W w !sudo tee % > /dev/null
" 上下移动快捷键
noremap j gj
noremap k gk
" 分屏后的屏幕移动快捷键
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
" 移动到行首和行尾快捷键
noremap H ^
noremap L $
noremap <C-a> <Home>
noremap <C-e> <End>
noremap Y y$
" I can type :help on my own, thanks.
noremap <F1> <Esc>
"no Highlight
noremap <silent><leader>/ :nohls<CR>
"Use 'm/M' to move among buffers
noremap m :bp<CR>
noremap M :bn<CR>

" Quick move in insert mode
inoremap <C-o> <Esc>o
inoremap <C-a> <Home>
inoremap <C-e> <End>

"goto older/newer position in change list
nnoremap <silent> ( g;
nnoremap <silent> ) g,
" Speed up scrolling of the viewport slightly
" nnoremap Y 2<C-e>
" nnoremap y 2<C-y>
" nnoremap ; :
" nnoremap ' :b
" Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" remap U to <C-r> for easier redo
nnoremap U <C-r>

"replace currently selected text with default register without yanking it
vnoremap p "_dP
" use ctrl-c to copy to system clipboard
vnoremap <C-c> "*y
" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv
" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" better command line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

if has('macunix')
  " pbcopy for OSX copy/paste
  vnoremap <C-x> :!pbcopy<CR>
  vnoremap <C-c> :w !pbcopy<CR><CR>
endif

hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
