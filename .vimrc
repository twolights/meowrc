" Basic settings
filetype off
filetype plugin on

set nocompatible
set cindent
set enc=utf-8
set expandtab
set fileencoding=utf-8
set foldmethod=syntax
set ts=4
set hlsearch
set incsearch
set ruler
set sw=4
syntax on

" Appearance settings
set t_Co=256
highlight Comment ctermfg=cyan
highlight Search term=reverse ctermbg=4 ctermfg=7

colorscheme elflord

" Alias typos that frequently occurs
cabbrev Vs vsplit
cabbrev Sp split
cabbrev Set set
cabbrev Wq wq
cabbrev Wqa DoWqa
cabbrev Wa wa
cabbrev W w
cabbrev Q q
cabbrev Qa DoQa

" Remaps <leader>
let mapleader=','

" Cursor movements
map j gj
map k gk
nmap gm :call cursor(0, virtcol('$')/2)<CR>

" System clipboard support
vmap <silent> Y "+y
nmap YY VY

" Tab-related keybindings
let g:lastTabMark=1

function! TabMarkCurrent()
    let g:lastTabMark = tabpagenr()
endfunction

function! TabMarkNext(direction)
    call TabMarkCurrent()
    if a:direction == 1
        tabnext
    elseif a:direction == -1
        tabNext
    endif
endfunction

function! TabMarkSwitchTo(tab_no)
    call TabMarkCurrent()
    execute 'tabnext ' . a:tab_no
endfunction

function! TabMarkEdit(target_name)
    call TabMarkCurrent()
    execute 'tabedit ' . a:target_name
endfunction

function! TabMarkNew()
    call TabMarkCurrent()
    tabnew
endfunction

function! TabMarkClose()
    call TabMarkCurrent()
    tabclose
endfunction

nmap <silent> <C-E>             <Nop>
nmap <silent> <C-E>E            :call TabMarkEdit("%")<CR>
nmap <silent> <C-E>n            :call TabMarkNew()<CR>
nmap <silent> <C-E><C-N>        :call TabMarkNew()<CR>:NERDTree<CR>:wincmd l<CR>:q<CR>
nmap <silent> <C-E>l            :call TabMarkNext(1)<CR>
nmap <silent> <C-E>]            :call TabMarkNext(1)<CR>
nmap <silent> <C-E>j            :call TabMarkNext(1)<CR>
nmap <silent> <C-E>[            :call TabMarkNext(-1)<CR>
nmap <silent> <C-E>h            :call TabMarkNext(-1)<CR>
nmap <silent> <C-E>k            :call TabMarkNext(-1)<CR>
nmap <silent> <C-E><C-E>        :call TabMarkSwitchTo(g:lastTabMark)<CR>
nmap <silent> <C-E>.            :call TabMarkEdit('.')<CR>
nmap <silent> <C-E>q            :call TabMarkClose()<CR>
nmap <silent> <C-E>1            :call TabMarkSwitchTo(1)<CR>
nmap <silent> <C-E>2            :call TabMarkSwitchTo(2)<CR>
nmap <silent> <C-E>3            :call TabMarkSwitchTo(3)<CR>
nmap <silent> <C-E>4            :call TabMarkSwitchTo(4)<CR>
nmap <silent> <C-E>5            :call TabMarkSwitchTo(5)<CR>
nmap <silent> <C-E>6            :call TabMarkSwitchTo(6)<CR>
nmap <silent> <C-E>7            :call TabMarkSwitchTo(7)<CR>
nmap <silent> <C-E>8            :call TabMarkSwitchTo(8)<CR>
nmap <silent> <C-E>9            :call TabMarkSwitchTo(9)<CR>
nmap <silent> <C-E>0            :call TabMarkSwitchTo(10)<CR>
nmap <silent> <C-E>-            :call TabMarkSwitchTo(11)<CR>
nmap <silent> <C-E>=            :call TabMarkSwitchTo(12)<CR>
nmap <silent> <C-E><BACKSPACE>  :call TabMarkSwitchTo(tabpagenr("$"))<CR>

" Overrides commonly-used syntax/filetype
autocmd BufNewFile,BufRead  *.m     set syntax=objc
autocmd BufNewFile,BufRead  SCons*  set filetype=scons 
autocmd BufNewFile,BufRead  *.json  set syntax=json
autocmd BufNewFile,BufRead  *.scss  set filetype=scss
autocmd BufNewFile,BufRead  *.c     set noexpandtab
autocmd BufNewFile,BufRead  *.py    set foldmethod=indent
autocmd BufNewFile,BufRead  *.go    set filetype=go
autocmd BufNewFile,BufRead  .vimrc  set foldmethod=indent

" Replace the default fold text
set foldtext=MyFoldText()

function! MyFoldText()
    let sub = getline(v:foldstart)
    let sub = substitute(sub, '/\*\|\*/\|//\|{{{\d\= ', '', 'g')
    let sub = substitute(sub, '^    \( *\)', '\1[+] ', 'g')
    return sub . ' '
endfunction

" Override original :wqa :wqa! :qa :qa!
function! CloseAllIfNoTabsAreOpen(should_write, force)
    let tab_count = tabpagenr("$")
    if tab_count > 1
        if a:should_write
            let force_command = ":WQA!!"
        else
            let force_command = ":QA!!"
        endif
        echoerr "There are " . tab_count . " tabs open. Please type " . force_command . " if you really wanna close all tabs and quit vim."
        return
    endif
    if a:should_write
        if a:force == "!"
            wqall!
        else
            wqall
        endif
    else
        if a:force == "!"
            qall!
        else
            qall
        endif
    endif
endfunction

command! -bang DoWqa    call CloseAllIfNoTabsAreOpen(1, "<bang>")
command! -bang DoQa     call CloseAllIfNoTabsAreOpen(0, "<bang>")

cabbrev <silent> wqa    DoWqa
cabbrev <silent> qa     DoQa

cabbrev <silent> WQA!!  wqall
cabbrev <silent> QA!!   qall

" Snipmate reload
let snippets_dir='~/.vim/snippets'

function! SnippetsUpdate(snip_dir)
    call ResetSnippets()
    call GetSnippets(a:snip_dir, '_')
    call GetSnippets(a:snip_dir, &ft)
endfunction
command! ReloadSnippets :call SnippetsUpdate(snippets_dir)

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle bundles
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'tsaleh/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'godlygeek/tabular'
Bundle 'mileszs/ack.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'rodjek/vim-puppet'
Bundle 'Rip-Rip/clang_complete'
Bundle 'airblade/vim-gitgutter'
Bundle 'fsouza/go.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'

Bundle 'snipMate'
Bundle 'a.vim'
Bundle 'VisIncr'
Bundle 'cocoa.vim'
Bundle 'nginx.vim'
Bundle 'scons.vim'
Bundle 'JSON.vim'
Bundle 'python.vim'
" Bundle 'remote-PHP-debugger'
" Bundle 'PIV'

" Clears SignColumn for vim-gitgutter
highlight clear SignColumn

" Adds Objective C support to a.vim
let g:alternateExtensions_h = 'c,cpp,cxx,cc,CC,m'
let g:alternateExtensions_m = 'h'

" Remaps EasyMotion trigger
let g:EasyMotion_leader_key = 'f'

" Adds default path to clang-complete
" let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
let g:clang_library_path = '/usr/lib'

" Remaps default ctrlp.vim action to horizontal split
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-x>', '<2-LeftMouse>'],
    \ 'AcceptSelection("h")': ['<cr>', '<c-s>', '<c-cr>'],
    \ }

" Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" NERDTree tweaks
let g:NERDTreeQuitOnOpen=1
autocmd VimEnter            *       :if argc() is 0 | NERDTree | :wincmd l | :q | :0 | endif
