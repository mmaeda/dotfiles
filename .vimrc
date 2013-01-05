"=============================================================================
" 全般
"=============================================================================
syntax on
colorscheme desert

"=============================================================================
" 単純なセット項目
"=============================================================================
"set shiftwidth= 2 "tabstopと同じ値にしておけばよい
"set lsp=10 "行間 GUIにしかないらしい
set backupskip=/tmp/*,/private/tmp/* "Mac OSXでcrontabの編集が反映されないのを回避
set guioptions+=a "文字を選択しただけで、クリップボードにコピー
set expandtab  "ソフトタブを有効にする TABキーを押した際にタブ文字の代わりにスペースをいれる
set autoindent "新しい行のインデントを現在行と同じにする
set nobackup "バックアップファイル作らない
set noswapfile "スワップファイル作らない
set autoread "他で書き換えられたら自動で読み直す
"set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set nocompatible "Vi互換オフ
set nu "行番号表示
set ve=block "矩形選択時のみフリーカーソルモード
set cursorline " カーソル行をハイライト
set showcmd "入力中のコマンドをステータスに表示する
set laststatus=2 "文字コードをステータスバーに表示
set number "行番号表示
set scrolloff=10 "上下10行は必ず表示
set nowrap "折り返さない
set wildmenu "コマンドライン補完拡張モード
set wildmode=list:full " リスト表示，最長マッチ
"set visualbell "Beep音の代わりに画面フラッシュ
"set clipboard+=unnamed "クリップボード共有:w
"set clipboard+=autoselect "GUI版以外で使いたい
set clipboard=unnamed
set timeoutlen=3500 "キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set hidden "編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set history=100 "ヒストリの保存数
set formatoptions+=mM "日本語の行の連結時には空白を入力しない
set virtualedit=block "Visual blockモードでフリーカーソルを有効にする
set backspace=indent,eol,start "バックスペースでインデントや改行を削除できるようにする
set ambiwidth=double "□や○の文字があってもカーソル位置がずれないようにする
set title "タイトルを表示
"set display=lastline "画面最後の行をできる限り表示する
set formatoptions+=m "整形オプション，マルチバイト系を追加
set mouse=a "全モードでマウス有効化
set notimeout ttimeout ttimeoutlen=200 " キーコードはすぐにタイムアウト。マッピングはタイムアウトしない
set showtabline=2 "タブ表示

"インサートモードや検索をするときに日本語入力状態になるのを防ぐ
set imactivatekey=C-space
set iminsert=0
set imsearch=0
"インサートモードや検索にはいるとインプットメソッドが立ち上がってしまうのを防ぐ
inoremap <ESC> <ESC>:set iminsert=0<CR>
nnoremap / :set imsearch=0<CR>/
nnoremap ? :set imsearch=0<CR>?

" vimで自動インデント
filetype on
filetype indent on
filetype plugin on

"ステータスラインに文字コードと改行文字を表示する
if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif
function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc


"=============================================================================
" Key Mappings
"=============================================================================
nnoremap ZZ <Nop> "強制全保存終了を無効化

"ブラウザと同じ操作　スペースでダウンアップ
map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
map <PageUp> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
map <PageDown> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

nnoremap <SPACE>   <PageDown> " Spaceキーで画面スクロール
nnoremap <S-SPACE> <PageUp> " Shift+Spaceキーで画面逆スクロール


"=============================================================================
" Auto Commands
"=============================================================================
autocmd FileType * setlocal formatoptions-=ro "コメントの自動挿入しない

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END
au BufNewFile,BufRead * set iminsert=0 "日本語入力をリセット
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2 "タブ幅をリセット

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
autocmd BufWritePre * :%s/\s\+$//ge "保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する



"=============================================================================
" Encoding
"=============================================================================
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
  let &fileencodings = &fileencodings .','. s:enc_jis
  set fileencodings+=utf-8,ucs-2le,ucs-2
  if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
    set fileencodings+=cp932
    set fileencodings-=euc-jp
    set fileencodings-=euc-jisx0213
    set fileencodings-=eucjp-ms
    let &encoding = s:enc_euc
    let &fileencoding = s:enc_euc
  else
    let &fileencodings = &fileencodings .','. s:enc_euc
  endif
endif

" 定数を処分
unlet s:enc_euc
unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"=============================================================================
" Utilities
"=============================================================================
" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/

" 検索語を真ん中に表示
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge


" -----------------------------------
" <TAB>で補完 by cho45
" -----------------------------------
" Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
                return "\<TAB>"
        else
                if pumvisible()
                        return "\<C-N>"
                else
                        return "\<C-N>\<C-P>"
                end
        endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
" Autocompletion using the TAB key

" -----------------------------------
" カーソルがある行をハイライト
" -----------------------------------
command! -nargs=1 HighlightCurrentLine execute 'match <args> /<bslash>%'.line('.').'l/'
command! -nargs=0 UnHighlightCurrentLine match
" }}}


"画面分割
nnoremap ts :<C-u>split<CR>
nnoremap <expr> tS ':<C-u>split ' . GetRelativePath()
nnoremap tv :<C-u>vsplit<CR>
nnoremap <expr> tV ':<C-u>

" CTRL-hjklでウィンドウ移動
nnoremap <C-j> ;<C-w>j
nnoremap <C-k> ;<C-k>j
nnoremap <C-l> ;<C-l>j
nnoremap <C-h> ;<C-h>j

" カレントウィンドウにのみ罫線を引く
augroup cch
 autocmd! cch
 autocmd WinLeave * set nocursorline
 autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=darkgray guibg=black




" -----------------------------------
" タブ
" -----------------------------------
" タブ表示
set showtabline=2

"タブの移動
nnoremap <C-n> gt
nnoremap <C-p> gT

"プレフィックス
nnoremap t; t
nnoremap t <Nop>

"タブを閉じる
nnoremap <silent> td :<C-u>tabclose<CR>

"新しいタブで help を開く。CRで終わるバージョンは th 押下後、すぐに新しいタブを開く。
"nnoremap th :<C-u>tab help<Space>
nnoremap th :<C-u>tab help<CR>

"ウィンドウ・バッファをタブに移動する
nnoremap <silent> tm :<C-u>call MoveToNewTab()<CR>

function! MoveToNewTab()
    tab split
    tabprevious

    if winnr('$') > 1
        close
    elseif bufnr('$') > 1
        buffer #
    endif

    tabnext
endfunction

set tabline=%!MakeTabLine()

function! MakeTabLine()
    let s = ''

    for n in range(1, tabpagenr('$'))
        if n == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        let s .= '%' . n . 'T'

        let s .= ' %{MakeTabLabel(' . n . ')} '

        let s .= '%#TabLineFill#%T'
        let s .= '|'
    endfor

    let s .= '%#TabLineFill#%T'
    let s .= '%=%#TabLine#'
    let s .= '%{fnamemodify(getcwd(), ":~:h")}%<'
    return s
endfunction

function! MakeTabLabel(n)
    let bufnrs = tabpagebuflist(a:n)
    let bufnr = bufnrs[tabpagewinnr(a:n) - 1]

    let bufname = bufname(bufnr)
    if bufname == ''
        let bufname = '[No Name]'
    else
        let bufname = fnamemodify(bufname, ":t")
    endif

    let no = len(bufnrs)
    if no == 1
        let no = ''
    endif

    let mod = len(filter(bufnrs, 'getbufvar(v:val, "&modified")')) ? '+' : ''
    let sp = (no . mod) == '' ? '' : ' '

    let s = no . mod . sp . bufname
    return s
endfunction

"新しいバッファを開く
"nnoremap to :<C-u>edit<Space>
nnoremap to :<C-u>edit<CR>
"nnoremap tt :<C-u>tabnew<Space>
nnoremap tt :<C-u>tabnew<CR>

"カレントバッファのディレクトリを元に新しいバッファを開く
nnoremap <expr> tO ':<C-u>edit ' . GetRelativePath()
nnoremap <expr> tT ':<C-u>tabnew ' . GetRelativePath()

function! GetRelativePath()
    let path = expand('%:~:.:h')
    if path == '.'
        return ""
    else
        return path . '/'
    endif
endfunction



" -----------------------------------
" 検索
" -----------------------------------
set incsearch "インクリメンタルサーチ
set smartcase "大文字が含まれている場合は大小区別して検索
set hlsearch "検索結果をハイライト
set hlsearch
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#


let ruby_space_errors=1 " 無駄なスペースを見つけてハイライトしてくれる



" -----------------------------------
" Vundle プラグイン管理
" -----------------------------------
filetype off
""" pathogen をコメントアウト
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" set helpfile=$VIMRUNTIME/doc/help.txt

""" Vundle '''
set rtp+=~/.vim/vundle/
call vundle#rc()
filetype plugin on

" 利用中のプラグインをBundle
Bundle 'snippetsEmu'
Bundle 'neocomplcache'
Bundle 'unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'unite-font'
Bundle 'unite-colorscheme'
Bundle 'rails.vim'
" Bundle 'AutoComplPop'
" Bundle 'vimproject'
Bundle 'svncommand.vim'
Bundle 'Railscasts-Theme-GUIand256color'
Bundle 'snipMate'
"Bundle 'snippetsEmu.vim'
"Bundle 'The NERD Commenter'
Bundle 'surround.vim'
Bundle 'ruby-matchit'
Bundle 'genutils'
Bundle 'multvals.vim'
"Bundle 'project.tar.gz'
Bundle 'The-NERD-tree'
Bundle 'dbext.vim'
Bundle 'nathanaelkane/vim-indent-guides'


"autocommandの設定"
"タブ幅をリセット
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2
".rhtmlと.rbと.ymlでタブ幅を変更
au BufNewFile,BufRead *.rhtml set tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.yml set tabstop=2 shiftwidth=2
"Rails関連ファイルで文字コードをUFT-8に設定
au User Rails* set fenc=utf-8




" -----------------------------------
" Unite.vim
" -----------------------------------
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1

" インサート／ノーマルどちらからでも呼び出せるようにキーマップ
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer file_mru<CR>
inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction



" -----------------------------------
" VimFiler
" -----------------------------------
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0



" -----------------------------------
" QFixHowm
" -----------------------------------
"qfixappにruntimepathを通す(パスは環境に合わせてください)
set runtimepath+=~/.vim/bundle/qfixapp
"
""キーマップリーダー
let QFixHowm_Key = 'g'
"howm_dirはファイルを保存したいディレクトリを設定。
let howm_dir             = '~/Desktop/howm'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'
" 曜日の日本語表示
let QFixHowm_JpDayOfWeek = 1


" utf-8優先簡易版
let &fileencodings=substitute(substitute(&fileencodings, ',\?utf-8', '', 'g'), 'cp932', 'utf-8,cp932', '')


" neocomplcashe
let g:neocomplcache_enable_at_startup = 1


" rails.vim
let g:rails_level=4
let g:rails_default_file="app/controllers/application.rb"
let g:rails_default_database="sqlite3"

" rubycomplete.vim
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

"rubyマジックコメント
iab u8 # -*- coding: utf-8 -*-

" IndendGuides設定。階層ごとに縦線表示。
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#888888 ctermbg=255
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#444444 ctermbg=233
" let g:indent_guides_enable_on_vim_startup = 1
"vim立ち上げ時に自動的にvim-indent-guidesをオンにする。
let g:indent_guides_enable_on_vim_startup = 1
"autoで色付けするのはストップ
let g:indent_guides_auto_colors = 0
"色の変化幅（？）パーセンテージ
let g:indent_guides_color_change_percent = 30
"奇数行の色付け
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=DarkGray
"偶数行の色付け
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=Gray
"インデントの色付け幅
let g:indent_guides_guide_size = 2 
