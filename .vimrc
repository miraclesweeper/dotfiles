" Need to execute the PluginInstall command if this variable is settings to 1.
let is_need_plugin_install=0

" Disable viminfo file.
set viminfo=

" Disable backup file.
set nobackup

" Disable swap file creation.
set noswapfile

" Disable startup messages.
set shortmess+=I

" Set the character encoding.
set encoding=utf-8

" Display line numbers.
set number

" Set the vertical rulers.
set colorcolumn=100

" Enable extended command line completion.
set wildmenu

" Ignore case when completing files and directories.
set wildignorecase

" Turn off IME input of insert mode at startup.
set iminsert=0

" Turn off IME input of search function at startup.
set imsearch=0

" Enable insensitive search.
set ignorecase

" Insert space characters whenever tab key is pressed.
set expandtab

" Set the number of space characters that will be inserted when tab key is
" pressed.
set softtabstop=4

" Set the number of space characters that will be inserted at the time of the
" automatic indentation.
set shiftwidth=4

" Automatically inserts one extra level of indentation in some cases.
set smartindent

" Indent even for wrapped lines.
set breakindent

" Allow opening a new file when the current buffer has unsaved changes.
set hidden

" Disable error sounds and screen flashing.
set noeb vb t_vb=

" Set the background color.
set background=dark

" Enable color syntax highlighting.
syntax on

" Automatically deletes whitespace at the end of each line.
au BufWritePre * :%s/\s\+$//ge

" Automatically convert tabs to spaces.
au BufWritePre * :%s/\t/        /ge

" Disable the automatic insertion of line break to end of file.
au BufWritePre * :set binary noeol

" Key map for switching to the previous buffer.
nnoremap<Space>n :bprevious<CR>

" Key map for switching to the next buffer.
nnoremap<Space>m :bnext<CR>

" Key map for closing the current buffer.
nnoremap<Space>, :bdelete<CR>

" If Vundle is not installed, getting from GitHub.
if !isdirectory($HOME.'/.vim/bundle/Vundle.vim')
  !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
  let is_need_plugin_install=1
endif

" Set the runtime path to include Vundle.
set rtp+=~/.vim/bundle/Vundle.vim

" Initialize the Vundle.
call vundle#begin()

" Let Vundle manage self.
Plugin'VundleVim/Vundle.vim'

" Let Vundle manage color scheme.
Plugin'morhetz/gruvbox'

" Let Vundle manage wonderful statusline.
Plugin'vim-airline/vim-airline'
let airline_left_sep=''
let airline_right_sep=''
let airline#extensions#tabline#enabled=1

" Let Vundle manage Kotlin support.
Plugin'udalov/kotlin-vim'
au BufRead *.kt set filetype=kotlin

" Let Vundle manage Swift syntax.
Plugin'apple/swift',{'rtp':'utils/vim','name':'swift-syntax'}
au BufRead *.swift set filetype=swift

" Finalize the Vundle.
call vundle#end()

" Execute the PluginInstall command if needed.
if is_need_plugin_install==1
  exe 'PluginInstall'
  q
endif

" Set the color scheme.
colorscheme gruvbox