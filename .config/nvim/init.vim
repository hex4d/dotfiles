if !&compatible
  set nocompatible
endif

" rese augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_dir = g:config_home . '/dein'
let s:toml_file = s:toml_dir . '/plugins.toml'
let s:lazy_toml_file = s:toml_dir . '/lazy.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#load_toml(s:lazy_toml_file, {'lazy': 1})
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

set sh=zsh

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

inoremap jj <ESC>
inoremap <C-j> <ESC>

let g:python_host_prog  = '/usr/local/bin/python3'
let g:python3_host_prog = '/usr/local/bin/python3'

filetype plugin indent on

" タブに関するショートカット
nnoremap tn :tabnew<CR>
nnoremap td :tabclose<CR>
nnoremap tj :tabprevious<CR>
nnoremap tk :tabnext<CR>

" コンフィグに関するショートカット
nnoremap <Space>, :tabnew ~/.config/nvim/init.vim<CR>
nnoremap <Space>s :source ~/.config/nvim/init.vim<CR>
nnoremap <Space>p :tabnew ~/.config/dein/plugins.toml<CR>
nnoremap <Space>lp :tabnew ~/.config/dein/lazy.toml<CR>

" その他ショートカット
map <Leader> ,
nnoremap <Space>cd :cd %:h<CR>
tnoremap <silent> <ESC> <C-\><C-n>
tnoremap <silent> <C-j> <C-\><C-n>

nnoremap <C-w>, <C-w><
nnoremap <C-w>. <C-w>>

nmap j gj
nmap k gk



