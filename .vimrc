" vim: foldmethod=none

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
cabbrev Wqa wqa
cabbrev Wa wa
cabbrev W w
cabbrev Q q
cabbrev Qa qa

" Remaps <leader>
let mapleader=','

" Cursor movements
map j gj
map k gk
nmap gm :call cursor(0, virtcol('$')/2)<CR>

" MacOS X clipboard support
vmap Y :w !pbcopy<CR><CR>
nmap YY VY

" Tab-related keybindings
nmap <C-E>      <Nop>
nmap <C-E>n     :tabnew<CR>
nmap <C-E><C-N> :tabnew<CR>
nmap <C-E>l     :tabn<CR>
nmap <C-E>j     :tabn<CR>
nmap <C-E><C-E> :tabn<CR>
nmap <C-E>.     :tabedit .<CR>
nmap <C-E>h     :tabN<CR>
nmap <C-E>k     :tabN<CR>
nmap <C-E>q     :tabclose<CR>
nmap <C-E>1     :tabn 1<CR>
nmap <C-E>2     :tabn 2<CR>
nmap <C-E>3     :tabn 3<CR>
nmap <C-E>4     :tabn 4<CR>
nmap <C-E>5     :tabn 5<CR>
nmap <C-E>6     :tabn 6<CR>
nmap <C-E>7     :tabn 7<CR>
nmap <C-E>8     :tabn 8<CR>
nmap <C-E>9     :tabn 9<CR>
nmap <C-E>0     :tablast<CR>

" Overrides commonly-used syntax/filetype
autocmd BufNewFile,BufRead *.m set syntax=objc
autocmd BufNewFile,BufRead SCons* set filetype=scons 
autocmd BufNewFile,BufRead *.json set syntax=json
autocmd BufNewFile,BufRead *.scss set filetype=scss
autocmd BufNewFile,BufRead *.c set noexpandtab
autocmd BufNewFile,BufRead *.py set foldmethod=indent
autocmd BufNewFile,BufRead *.go set filetype=go

" Replace the default fold text
set foldtext=MyFoldText()

function MyFoldText()
    let sub = getline(v:foldstart)
    let sub = substitute(sub, '/\*\|\*/\|//\|{{{\d\= ', '', 'g')
    let sub = substitute(sub, '^    \( *\)', '\1[+] ', 'g')
    return sub . ' '
endfunction

" Snipmate reload
let snippets_dir='~/.vim/snippets'

function! SnippetsUpdate(snip_dir)
    call ResetSnippets()
    call GetSnippets(a:snip_dir, '_')
    call GetSnippets(a:snip_dir, &ft)
endfunction
command ReloadSnippets :call SnippetsUpdate(snippets_dir)

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
