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

" NeoBundle
set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/neobundle.vim.git
    "[deprecated]: call neobundle#rc(expand('~/.vim/.bundle'))
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'

    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'Shougo/vimshell'
    NeoBundle 'Shougo/vimproc'
    NeoBundle 'Shougo/vimfiler'
    NeoBundle 'itchyny/lightline.vim'
    NeoBundle 'h1mesuke/unite-outline'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'tyru/caw.vim.git'
    NeoBundle 'derekwyatt/vim-scala'
    call neobundle#end()
endif

filetype plugin on
filetype indent on

" lightline
let g:lightline = { 'colorscheme': 'landscape'}

" caw.vim
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

