if !&compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let &runtimepath = "~/Workspace/some/vimplugin" .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_dir = g:config_home . '/dein'
let s:toml_file = s:toml_dir . '/plugins.toml'
let s:lazy_toml_file = s:toml_dir . '/lazy.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#load_toml(s:lazy_toml_file, {'lazy': 1})
  " call dein#add('~/Workspace/product/oss/easydiary', {'hook_add': "let g:easydiary_directory='~/Workspace/note/'"})
  " call dein#add('~/Workspace/some/vimplugin/nerdtree-yank-mapping/', {'depends': 'nerdtree'})
  call dein#end()
  call dein#save_state()
endif


" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" }}}


" プラグイン以外のその他設定が続く

"--------------------
" 設定
"--------------------

if has('mac')
  set sh=zsh
endif

set number 

syntax enable

set list

"----------------
"検索設定
"----------------
"インクリメンタルサーチ
set incsearch
"大文字小文字を区別しない
set ignorecase
"大文字で検索されたら対象を大文字限定にする
set smartcase
"行末まで検索したら行頭に戻る
set wrapscan

"----------------
"表示設定
"----------------
"シンタックスをオンにする
"括弧の対応を表示
set showmatch
" インデント
set autoindent
set tabstop=4
set shiftwidth=2
"TAB,EOFなどを可視化する
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
"カーソルラインを表示する
set cursorline
set display=lastline
set virtualedit=all

set expandtab
set autoread
set cmdheight=2
set noshowmode

set completeopt+=menuone,noinsert,noselect
set completeopt-=preview

inoremap <C-j> <ESC>

if has('mac')
  let g:python_host_prog  = '/usr/local/bin/python'
  let g:python3_host_prog = '/usr/local/bin/python3'
else
  let g:python_host_prog  = '/usr/bin/python'
  let g:python3_host_prog = '/usr/bin/python3'
endif

filetype plugin indent on

" shortcut
nnoremap tn :tabnew<CR>
nnoremap td :tabclose<CR>
nnoremap tj :tabprevious<CR>
nnoremap tk :tabnext<CR>

nnoremap <Space>, :tabnew ~/Workspace/dotfiles/dotfiles/.config/nvim/init.vim<CR>
nnoremap <Space>s :source ~/Workspace/dotfiles/dotfiles/.config/nvim/init.vim<CR>
nnoremap <Space>p :tabnew ~/Workspace/dotfiles/dotfiles/.config/dein/plugins.toml<CR>
nnoremap <Space>lp :tabnew ~/Workspace/dotfiles/dotfiles/.config/dein/lazy.toml<CR>

map <Leader> ,
nnoremap cd :cd %:h<CR>
tnoremap <> <ESC> <C-\><C-n>
tnoremap <silent> <C-j> <C-\><C-n>

nnoremap <C-w>, <C-w><
nnoremap <C-w>. <C-w>>

nmap j gj
nmap k gk

nnoremap * *N
nnoremap <Space>cc *Ncgn

nnoremap <Space>y :%y+<CR>

" colorscheme solarized

nnoremap <Space>gs :Gstatus<CR>
nnoremap <Space>gd :Gdiff<CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>ga :Gwrite<CR>
nnoremap <Space>gc :Gcommit<CR>

nnoremap <C-d><C-t> <ESC>I<C-R>=strftime("%H:%M")<CR>~
inoremap <C-d><C-t> <C-R>=strftime("%H:%M")<CR>~

nnoremap <C-n><C-o> :noh<CR>

nnoremap <Space>w :w<CR>

set conceallevel=0
