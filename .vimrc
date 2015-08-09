" Vundle prelims {{{1
set nocompatible              " be iMproved, required
filetype off                  " required

" Configure spaces not tabss {{{1
" When the tab key is pressed then insert spaces
set expandtab
" how many spaces to insert?
set tabstop=4
" How many spaces to indent by?
set shiftwidth=4
" And always set the indent to a multiple of shiftwidth
set shiftround
" Backspace over tabs as if they were tabs and not 4 separate backspaces
set softtabstop=4

" Set the editor to show tab and EOL characters {{{1
set listchars=tab:▸-,eol:¬
"Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Copy the indent from the above line {{{1
set autoindent

" Set ignorecase {{{1
set ignorecase

" Make the command line 2 lines high {{{1
set ch=2

" Allow backspacing over indents, eol and start of an insert {{{1
set backspace=2

" Make sure unsaved buffers are allowed to be hidden without being saved {{{1
set hidden

" Make the change <motion> actions put a $ at the end instead of just deleting {{{1
set cpoptions=cesB$

" Keep a bit more history {{{1
set history=1000

" Read a file that has changed on disk {{{1
set autoread

" Turn the line numbers on {{{1
set nu
set relativenumber

" Set the leader up to be the comma {{{1
let mapleader=","

" Don't syntax highlight lines that are too long {{{1
set synmaxcol=1024

" Set up backups {{{1
if has('persistent_undo')
	set undofile
	set undolevels=1000
	set undoreload=10000
endif
" End of backups }}}
" Show matching brackets {{{1
set showmatch

" For times when you forget to set sudo {{{1
cmap w!! W !sudo tee % >/dev/null

" Create specific directories for backups & swaps etc {{{1
function! InitializeDirectories()
    let separator = "."
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
" End of creating specific directories }}}
" Fix constant spelling mistakes {{{1
    iabbrev Acheive    Achieve
    iabbrev acheive    achieve
    iabbrev Alos       Also
    iabbrev alos       also
    iabbrev Aslo       Also
    iabbrev aslo       also
    iabbrev Becuase    Because
    iabbrev becuase    because
    iabbrev Bianries   Binaries
    iabbrev bianries   binaries
    iabbrev Bianry     Binary
    iabbrev bianry     binary
    iabbrev Charcter   Character
    iabbrev charcter   character
    iabbrev Charcters  Characters
    iabbrev charcters  characters
    iabbrev Exmaple    Example
    iabbrev exmaple    example
    iabbrev Exmaples   Examples
    iabbrev exmaples   examples
    iabbrev Fone       Phone
    iabbrev fone       phone
    iabbrev Lifecycle  Life-cycle
    iabbrev lifecycle  life-cycle
    iabbrev Lifecycles Life-cycles
    iabbrev lifecycles life-cycles
    iabbrev Seperate   Separate
    iabbrev seperate   separate
    iabbrev Seureth    Suereth
    iabbrev seureth    suereth
    iabbrev Shoudl     Should
    iabbrev shoudl     should
    iabbrev Taht       That
    iabbrev taht       that
    iabbrev Teh        The
    iabbrev teh        the
    iabbrev @@         John@GrandadEvans.com
    iabbrev ccopy      Copyright 2015 John Evans, all rights reserved.
" End of typos }}}
" Map the save and new tab keys {{{1
noremap <C-s> <esc>:w<CR>
inoremap <C-s> <esc>:w<CR>
noremap <C-t> <esc>:tabnew<CR>

" Bind the :W to :w (typo) {{{1
command! W w

" Bind the Wall and Qall to the proper functions {{{1
command! Qall qall
command! Wall wall

" Edit and source ~/.vimrc {{{1
nnoremap <silent> <leader>ev :split $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" ******************** Searches ******************** {{{1

    " Show and hide search results {{{1
        " in all buffers use <leader>sh to hide the latest search results
        nnoremap <leader>sh :set nohlsearch<cr>
        " and <leader>ss to show the search results
        nnoremap <leader>ss :set hlsearch<cr>
    
    " Enable search highlighting {{{1
        set hlsearch
    
    " Search around line breaks {{{1
        set wrapscan
    
    " Search the current file for what's currently in the search register and display matches
    nnoremap <silent> <leader>gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

    " Search the current file for the word under the cursor and display matches
    nnoremap <silent> <leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

    " Search the current file for the WORD under the cursor and display matches
    nnoremap <silent> <leader>gW :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
" End of custom searches }}}
" Automatically save the states of the buffers on exit and load them on entry {{{1
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Set GUI Options {{{1
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
":set guioptions-=r  "remove right-hand scroll bar
":set guioptions-=L  "remove left-hand scroll bar
" End of GUI options}}}

" Return to last edit position when opening files (You want this!) {{{1
if has("autocmd")
    augroup last_position
        autocmd!
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END
endif

" Remember info about open buffers on close {{{1
set viminfo^=%

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac {{{1
nnoremap <M-k> mz:m-2<cr>`z
nnoremap <M-j> mz:m+<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Remove the Windows ^M - when the encodings gets messed up {{{1
" noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Set the font {{{1
if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
endif

" Initialise Vundle {{{1
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"     Taglist {{{1
Plugin 'taglist.vim'
" Set the toggle key
nnoremap <silent> <F8> :TlistToggle<CR>
" Open the taglist on vim start-up
let Tlist_Auto_Open = 0
" Press o to open in new window
" Press p to open the definition and stay in the taglist
" Open a fold +
" Close a fold -
" Open all folds *
" Clo all folds =
" use the taglist on the right

    " Automatically update the taglist to include newly opened files
    let Tlist_Auto_Update=1

    " Shows tag scope next to tag name
    let Tlist_Enable_Tag_Scope=1

    " DO NOT: Show the fold indicator column in the taglist window
    let Tlist_Enable_Fold_Column=0

    " Close tag folds for inactive buffers
    let Tlist_File_Fold_Auto_Close=1

    " Jump to taglist window on open
    let Tlist_GainFocus_On_ToggleOpen=1

    " On entering a buffer, automatically highlight the current tag
    let Tlist_Highlight_Tag_On_BufEnter=1

    " Process files even when the taglist is closed
    let Tlist_Process_File_Always=1

    " Place the taglist window on the right side
    let Tlist_Use_Right_Window=1

    " Map <leader>tt to the toggle taglist function
    nnoremap <silent> <leader>tt :TlistToggle<CR>

    " map <leader>to to the tags open function
    nnoremap <silent> <leader>to :TlistOpen<CR>

    " map <leader>tc to the tags close function
    nnoremap <silent> <leader>tc :TlistClose<CR>

    " Automatically highlight the current tag in the taglist
    let Tlist_Auto_Highlight_Tag=1

" NERDTree {{{1
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
"Map the usual nerdtree key to the toggle
nnoremap <silent> <F3> :NERDTreeToggle<CR>
" Close nerdtree if its the only window left?
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"NERDTreeFind Fins the current file in nerdtree
"NERDTreeCWD Sets Nerdtree root to be the current directory
"Bookmark <name> Bookmark as name
"Keymap:
"o open
"go open, but stay in nerdtree
"t open in new tab
"i open in split window
"gi open in new window but stay in nerdtree
"s open in new v-split
"gs open in new v-split but stay in nerdtree
"O recursively open selected dir
"x close current nodes parent
"X recursivly close all children of current node
"D delete cuurent bookmark
"P jump to root node
"p jump to current node's parent
"C change tree root to selected dir
"u move tree root up one dir
"U as above but old root is left open
"r recursively refresh current dir
"R recursively refresh root dir
"m display nerd tree menu
"cd change the CWD to the dir of selected root
"CD change tree root to CWD
"I toggle hidden files
"f toggle whether file filters are used
"F toggle whether files are displayed
"B toggle whether bookmarks table is shown
"A zoom (minimize/maximize)M nerdtree window
let NERDTreeQuitOnOpen=0
let NERDTreeShowHidden=1

" SnipMate {{{1
"Plugin 'snipMate'
"let g:snips_author = "John Evans"

" map :c-all to copy all {{{1
noremap <Leader>c-all :%y<CR>

"" map :hll to highlight long line {{{1
"nnoremap <Leader>hll :call<SID>LongLineHLToggle()<CR>

"hi OverLength ctermbg=none cterm=none
"match OverLength /\%>800v/
"fun! s:LongLineHLToggle()
"    if !exists('w:longlinehl')
"        let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
"        echo "Long lines highlighted"
"    else
"        call matchdelete(w:longlinehl)
"        unl w:longlinehl
"        echo "Long lines unhighlighted"
"    endif
"endfunction

" Show the tabline if there are 2 or more tabs {{{1
set showtabline=2

" Press Enter to insert a new line below the cursor & Shift-Enter for line below {{{1
" Press Shift Enter to insert a new line before the current line
" Both commands do not take you into INSERT mode
noremap <S-Enter> O<Esc>
noremap <CR> o<Esc>

" Highlight whitespace at the end of a line in blue {{{1
"" http://vimbits.com/bits/259
"highlight WhitespaceEOL ctermbg=Blue guibg=Blue
"match WhitespaceEOL /\s\+$/

" Mini buffer explorer {{{1
Plugin 'minibufexpl.vim'
" Use tabs and shift-tab to cycle through open buffer list
"map <Leader>mbt :MBEToggle<cr>
"s open in split
"v open in v-split
"d delete selected buffer without deleting window
":MBEbn switch to next normal buffer in current window
":MBEbp switch to previous normal buffer in current window
":MBEbf move forward in recent buffer list
":MBEbb move backwards in recent buffer list
noremap <C-TAB>   :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>
" use single click in the buffer explorer bar
let g:miniBufExplUseSingleClick = 1

" Easy window navigation {{{1
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

" Fugitive {{{1
Plugin 'fugitive.vim'
" :Git run any arbitary git command
" :Gread read from index
" :Gwrite writre to index/staging area
" :Gremove current file and buffer
" :Gmove Rename current file and buffer
" :Gblame
" :Gcommit
" :Gstatus is interactive:
" 	- add or reset the file (works isn visual mode too)
" 	p Run `git add --patch` for current file`
" 	c Invoke `git commit`
" :Gedit :file to read the indexed version of a file
" 	Gedit
" 	Gedit :0
" 	Gedit :%
" 	An of these will open up the indexed version of the current file
" :Gdiff runs  vsplit with index file on left and working copy on right
" 	While in diff you can use
" 	Gwrite - working copy - stage file
"	Gread - working copy - checkout file
"	Gwrite - index - checkout file
"	Gread - index - stage file
"
"	diffput - working copy - stage hunk
"	diffget - working copy - checkout hunk
"	diffput - index - checkout hunk
"	diffget - index - stage hunk
" 3 way conflicts:
" 	Left: version from target branch (HEAD)
" 	Middle: Working copy
" 	Right: Version from merge branch
"
" 	Keep cursor can run :diffget with buffer number of choice or
" 	Go to the window with the hunk you want and run :diffput buffer number
" 	or :Gwrite to write the full buffer to the working copy and the index
" 	(but will raise a warning
" 	use :Gwrite! to bypass this warning.
" 	commands:
" 		[c - Jump to prvious hunk
" 		]2 - Jump to next hunk
" 		dp - shorthand for `:diffput` (2 way diff)
" 		:only - close all windows apart from the current one
" Git repo
" 	:Gedit branchname:path/to/file to open RO buffer
" 	:Gedit commitId will open interactive git show
" 		Open parent commit by pressing enter on parent
" 		Press enter on a tree ref will open up that tree
" 		Press enter on diff summary line to open specified file before
" 		and after the commit
"
" 		in tree mode use :edit %:h to open parent tree
" Each git buffer that open adds to the buffer list so autoclean them
if has ("autocmd")
    augroup fugitive_autocmds
        autocmd!
        autocmd BufReadPost fugitive://* set bufhidden=delete
    augroup END
endif
" Add the branch name to the statusline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" :Glog - Load all previous revisions of file in quickfist list :Glog
" :Glog -10 - Load the last 10 revisions of current file into quicklist
" :Glog -10 -- reverse - Load the first 10 revisions in reverse chronological
" order
" :Glog -1 -- until=yesterday - Load the last version of the current file that
" was checked in before midnight last night
" :Grep will search working tree (will only work in files tracked by repo)
" :Grep 'find me'
" :Grep findMe both the same - search the working copy
" :Grep --cached findMe - search the index
" :Grep findMe branchName/TagName/SHA
" :Grep --grep-findMe -- - search in commit messages
" :Grep --grep-findMe -- % - search in commit messages that touch current file
" :Grep SfimdMe -- find in diff of commits
" :Grep SfimdMe -- % find in diff of commits that touch current file

" Solarized color scheme {{{1
"Plugin 'altercation/vim-colors-solarized'
"syntax enable
"if has('gui_running')
    "set background=light
"else
    "set background=dark
"endif
"let g:solarized_termcolors=256
"colorscheme solarized
"
Plugin 'atweiden/vim-colors-behelit'
colorscheme behelit

" Matchit {{{1
Plugin 'matchit.zip'

" Conque-term {{{1
Plugin 'rosenfeld/conque-term'
" Type :ConqueTerm <command> for current buffer
" ConqueTermSplit/VSplt
" <F9> - To send visually selected text to to existing terminal buffer
" <F10> - Send entire contents of file
" <F11> - Execute file in new terminal buffer (remember to chmod +x)
" <F8> - Reformat terminal output
" <Esc>x2 - send an <Esc> keypress
" Make sure the buffers are updated even when they are not in focus
let g:ConqueTerm_ReadUnfocused = 1
" Aautomatically enter insert mode when you enter the buffer
let g:ConqueTerm_InsertOnEnter = 1
" Edit terminal screen
let g:ConqueTerm_ToggleKey = '<F8>'
" Allow <C-w> in insert mode (to switch buffers)
let g:ConqueTerm_CWInsert = 1
" Execute file
let g:ConqueTerm_ExecFileKey = '<F11>'
" Send entire file contents
let g:ConqueTerm_SendFileKey = '<F10>'
" Send selected text
let g:ConqueTerm_SendVisKey = '<F9>'
" Send function keys to terminal (set 1 to enable)
let g:ConqueTerm_SendFunctionKeys = 0
" Choose how to identify terminal type (defaults to vt100 but can try xterm)
let g:ConqueTerm_TERM = 'vt100'
" You can also access the CoonqueTerm API
" Open a new command:
" 	let my_terminal = conqueterm#open('ipython', ['split', 'resize 20'], 1)
" Open new sub-process (usefull foe async intercation):
" 	let my_subprocess = conque_term#subprocess('tail -f /var/log/foo.log')
" other functions are
" 	write
" 	writeln
" 	read
" 	set_callback
" 	close
" 		all of these need a conqueterm object (read the docs)

" Vim-dirdiff {{{1
"Plugin 'will133/vim-dirdiff'

" NERDCommentor {{{1
Plugin 'scrooloose/nerdcommenter'
" Defaults
" [count]<leader>cc|NERDComComment| comment out the current line or selected
" text
" [count]<leader>cn|NERDComNestedComment| same as above but force nesting
" [count]<leader>c|NERDComToggleComment| Toggles the comment state of the
" selected line(s)
" [count]<leader>ci|NERDComInvertComment| Toggle lines individually
" [count]<leader>cs|NERDComSexyComment| comment them out sexily
" [count]<leader>cy|NERDComYankComment| cc but lines are yanked first
" [count]<leader>c$|NERDComEOLComment| Comment from cursor to EOL
" [count]<leader>cA|NERDComAppendComment| Adds a comment delimiters to the EOL
" and goes into insert mode between them
" |NERDComIsertComment| Adds comment delimiters at cursor and insert position
" between them
" <leader>ca|NERDComAltDelim| Switches to alternatice set of delimiters
" [count]<leader>cl
" [count]<leader>cb|NERDComAlignedComment| Same as NERDComComment excpet
" delimiters are aligned down loeft hand side OR both sides
" [count]<leader>cu|NERDComUncommentLine| uncomment the line(s)
"
" Remove the extra space when uncommenting
let NERDRemoveExtraSpaces = 1

" Align {{{1
"Plugin 'align'

" Emmet_vim {{{1
Plugin 'mattn/emmet-vim'

" WebAPI-vim {{{1
Plugin 'mattn/webapi-vim'

" override configuration
let g:user_emmet_settings = {
			\    'indentation' : '    '
			\}
" Set the expand key
let g:user_emmet_leader_key = '<C-Z>'

" PHP_Indenting-for-vim {{{1
Plugin '2072/PHP-Indenting-for-VIm'
" Use indentation for switch/case statements
:let g:PHP_vintage_case_default_indent = 1

" Syntastic {{{1
Plugin 'scrooloose/syntastic'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aouto_loc_list           = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wg              = 0

let g:syntastic_python_checkers          = ['pylint']
let g:syntastic_php_checkers             = ['php', 'phpcs', 'phpmd']
" To run explicit checkers run :SyntasticCheck phpcs phpmd
"tell it when to run the checks
let g:syntastic_mode_map = {
			\ "mode": "active",
			\ "active_filetypes": ["php", "Javascript"],
			\ "passive_filetypes": []
			\}

" Vim-auto-save (disabled but try with tmux2) {{{1
"Plugin '907th/vim-auto-save'
"" Enable auto_save on start
"let g:auto_save = 1
"" Do not check the update time
"let g:auto_save_no_updatetime = 1

" Initial settings to be revised after reading the manual {{{1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" CSS_Color {{{1
Plugin 'css_color.vim'

" IndentLine.vim {{{1
Plugin 'indentLine.vim'
" Possible to change the color of the lines
let g:indentLine_color_term = 239
let g:indentLine_color_gui  = '#A4E57E'
" And also the character
let g:indentLine_cha = ':'

" File-line {{{1
Plugin 'bogado/file-line'

" Navajo-night colour scheme {{{1
Plugin 'navajo-night'

" Vim-JSON {{{1
Plugin 'elzr/vim-json'
" Turn off concealement (hiding the quotation marks)
let g:vim_json_syntax_conceal = 0

" VIM-airline {{{1
Plugin 'bling/vim-airline'"
"let g:airline#extensions#tabline#enabled = 1
" use the powerline fonts
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " Show the statusline all of the time oand not just when a split is showing
  set laststatus=2
  
" Vim-gitgutter {{{1
Plugin 'airblade/vim-gitgutter'
" I don't want gitgutter to set up any key bindings as I want to handle these
" with Fugitive
let g:gitgutter_map_keys = 0
" and turn off line highlighting
let g:gitgutter_highlight_lines = 0

" PHP-cs-fixer {{{1
Plugin 'stephpy/php-cs-fixer'
" If php-cs-fixer is in $PATH, you don't need to define line below
" let g:php_cs_fixer_path = "~/php-cs-fixer.phar" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "php-2"              " which level ?
let g:php_cs_fixer_config = "default"             " configuration
let g:php_cs_fixer_php_path = "/usr/bin/php"               " Path to PHP
" If you want to define specific fixers:
"let g:php_cs_fixer_fixers_list = "linefeed,short_tag,indentation"
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

" Emmet {{{1
"let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.dotfiles/emmet.json')), "\n"))

" VIM-phpqa.git {{{1
Plugin 'joonty/vim-phpqa.git'
" All of your Plugins must be added before the following line

" JSHint {{{1
Bundle "wookiehangover/jshint.vim"

" YA.js (disabled) {{{1
" This keep dropping random characters everywhere and it makes it very
" difficule to code
" Install some decent javascript syntax colouring
"Plugin 'othree/yajs.vim' }}}
" Tabularize {{{1

    Plugin 'godlygeek/tabular'


" Gundo {{{1
    Plugin 'sjl/gundo.vim'
    nnoremap <F6> :GundoToggle<CR>
    " Press Enter on an entry to select the entry
    " Press "p" in order to preview the undo entry
    "
    " Open Gundo on the right
    let g:gundo_right = 1

" ShowMarks {{{1
    "Plugin 'showmarks'
    " <leader>mt toggles showmarks on and off
    " <leader>mh hides an individual mark
    " <leader>ma hides all marks in the current buffer
    " <leader>mm places the mext available mark
Plugin 'kshenoy/vim-signature'

" Sunburst colorscheme {{{1
    Plugin 'zanloy/vim-colors-sunburst'
    colorscheme sunburst

" PHPUnit-QF {{{11
Bundle 'joonty/vim-phpunitqf.git'


" End of Vundle stuff {{{1
    call vundle#end()            " required
    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
    " see :h vundle for more details or wiki for FAQ
    " Put your non-Plugin stuff after this line
    
" Set a mapping up to convert the current word into uppercase {{{1
inoremap <c-u> <esc>viWUEa
nnoremap <c-u> viWUE

" Map the H to the start of the line (as h is left, H is a stronger left) {{{1
nnoremap H ^
nnoremap L $

" Map jk in insert mode instead of pressing escape {{{1
inoremap jk <esc>
" Disables the default <esc> key in insert mode so that I have to use the
" above
inoremap <esc> <nop>

" Disable the arrow keys {{{1
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

" Easy tab switching {{{1
" If I start working with tabs these shortcuts will allow for faster
" navigation
noremap <C-S-]> gt
noremap <C-S-[> gT
noremap <C-1> 1gt
noremap <C-2> 2gt
noremap <C-3> 3gt
noremap <C-4> 4gt
noremap <C-5> 5gt
noremap <C-6> 6gt
noremap <C-7> 7gt
noremap <C-8> 8gt
noremap <C-9> 9gt
noremap <C-0> :tablast<CR>

" Strip trailing spaces from the end of lines {{{1
"
" This is used in php, js, md & py files
"""""""""""""""""""""""""""""""""""""""""""""
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s = @/
    let l  = line(".")
    let c  = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and
    " cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" Set the indent on yml files to 2 spaces
augroup filetype_yaml
    if has("autocmd")
        autocmd!

        autocmd BufWritePre *.yml :call <SID>StripTrailingWhitespaces()

        autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
        autocmd FileType yaml nnoremap <buffer> set tabstop=2
        autocmd FileType yaml nnoremap <buffer> set shiftwidth=2
    endif
augroup END

" PHP specific auto commands {{{1
augroup filetype_php
    if has("autocmd")
        autocmd!

        " Before a file is written strip any traililng whitespace
        autocmd BufWritePre *.php :call <SID>StripTrailingWhitespaces()

        " When a file is written I want to run the unit tests for this file if
        " it is a test file. If not I want to run tests for the whole project.
        "
        " This will sooner or later be linked to a list of files that will
        " contain test files that effect the current file
        " Then on save the respective test file(s) will be run
        "autocmd BufWritePre *.php :call  Test %

        autocmd FileType php :iabbrev <buffer> fn function<cr>{<cr>XContent<cr>}jkk0C
        autocmd FileType php :iabbrev <buffer> pubf public function<cr>{<cr>XContent<cr>}jkk0C
        autocmd FileType php :iabbrev <buffer> prof protected function<cr>{<cr>XContent<cr>}jkk0C
        autocmd FileType php :iabbrev <buffer> prif private function<cr>{<cr>XContent<cr>}jkk0C
        autocmd FileType php :iabbrev <buffer> pubsf public static function<cr>{<cr>XContent<cr>}jkk0C
        autocmd FileType php :iabbrev <buffer> prosf protected static function<cr>{<cr>XContent<cr>}jkk0C
        autocmd FileType php :iabbrev <buffer> prisf private static function<cr>{<cr>XContent<cr>}jkk0C
        autocmd FileType php :iabbrev <buffer> cl class<cr>{<cr>XContent<cr>}jkk0C

        autocmd FileType php :iabbrev <buffer> return No! Use "rn" abbreviation moron!
        autocmd FileType php :iabbrev <buffer> ns namespace
        autocmd FileType php :iabbrev <buffer> rn return

        "autocmd FileType php :inoremap <silent> \: \:
    endif

augroup END

" Javascript specific auto commands {{{1
augroup filetype_js
    if has("autocmd")
        autocmd!

        autocmd BufWritePre *.js :call <SID>StripTrailingWhitespaces()

        autocmd FileType js :iabbrev <buffer> return No! Use "rn" abbreviation moron!
        autocmd FileType js :iabbrev <buffer> fn function
        autocmd FileType js :iabbrev <buffer> return No! No! No!
        autocmd FileType js :iabbrev <buffer> rn return
    endif
augroup END

" Vim specific auto commands {{{1
augroup filetype_vim
    if has("autocmd")
        autocmd!

        autocmd FileType vim :set foldmethod=marker
    endif
augroup END

" Markdown specific auto commands {{{1
augroup filetype_markdown
    if has("autocmd")
        autocmd!

        autocmd BufWritePre *.md :call <SID>StripTrailingWhitespaces()

        " Markdown select (motion) for previous header
        autocmd FileType markdown <buffer> :onoremap  ih :<c-u>execute "normal! ?^[-=\\{2,}]\\+$\r:nohlsearch\rkvg_"<cr>

        " Markdown select the uquals signs as well
        autocmd FileType markdown <buffer> :onoremap  ah :<c-u>execute "normal! ?^[-=\\{2,}]\\+$\r:nohlsearch\rg_vk0"<cr>
    endif
augroup END

" Toggle word wrap {{{1
" Create mapping for <leader>ww = word wrap
nnoremap <leader>ww :set wrap!<cr>
