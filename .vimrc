" vimrc

"===================
" 全般
"===================
set t_Co=256
set nocompatible
set backspace=start,eol,indent
set nowrap          
set number         
set ruler         
set showmatch       " 対応するカッコを表示
set nobackup        " バックアップファイルを作成しない
set noundofile      " .un~ファイルを作成しない

syntax enable
noremap  <BS>
noremap!  <BS>
noremap <S-O> o<ESC>
noremap <C-j> 5j
noremap <C-k> 5k

:colorscheme molokai    

"========================
" Tab, インデント
"========================
set expandtab       
set tabstop=4
set shiftwidth=4

set autoindent   
set smartindent


"========================
" 検索
"========================
set incsearch      
set wrapscan       

set laststatus=2   


"========================
" 文字 
"========================
" 全角スペース
highlight ZenkakuSpace cterm=underline ctermfg=red guibg=white
match ZenkakuSpace /　/

" 文字コード
set encoding=utf8
set fileencoding=utf-8


"========================
" タブページ (http://qiita.com/wadako111/items/755e753677dd72d8036d)
"========================
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

" Tab jump
for n in range(1, 9)
  " t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>


" dein.vim
let g:use_dein = 1
if g:use_dein && v:version >= 703
    let s:dein_dir = expand('~/.vim/dein')
    let s:rc_dir = expand('~/.vim/rc')
    let s:dein_github = s:dein_dir . '/repos/github.com'
    let s:dein_repo_dir = s:dein_github . '/Shougo/dein.vim'

    if &runtimepath !~# '/dein.vim'
        if !isdirectory(s:dein_repo_dir)
            execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
        endif
        let &runtimepath = &runtimepath . "," . s:dein_repo_dir
    endif

    if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir)

        let s:toml = s:rc_dir . '/dein.toml'
        let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

        call dein#load_toml(s:toml, {'lazy': 0})
        call dein#load_toml(s:lazy_toml, {'lazy': 1})

        call dein#local('~/git_repos/', {'frozen': 1}, ['*.vim'])

        call dein#end()
        call dein#save_state()
    endif

    if dein#check_install()
        " 未インストールのプラグインをインストール
        call dein#install()
    endif
endif

filetype plugin on
filetype indent on

"========================
" Unite.vim
"========================
let g:unite_enable_start_insert=0   
noremap <C-U><C-B> :Unite buffer<CR>
noremap <C-U><C-F> :VimFilerBufferDir -split -simple -winwidth=20 -no-quit<CR>
noremap <C-U><C-M> :Unite buffer file_mru<CR>
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
let g:unite_split_rule = 'botright'
noremap <C-U><C-O> :Unite -vertical -winwidth=30 outline<CR>

" neocomplcache
set completeopt=menuone   
let g:neocomplcache_enable_at_startup=1  
let g:neocomplcache_enable_underbar_completion = 1  
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
let g:neocomplcache_enable_insert_char_pre = 1  
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

" lightline
let g:lightline = { 'colorscheme': 'landscape'}

" caw.vim
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

