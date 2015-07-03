" Vundle prelims
set nocompatible              " be iMproved, required
filetype off                  " required

" When the tab key is pressed then insert spaces
set expandtab
" how many spaces to insert?
set tabstop=4
" How many spaces to indent by?
set shiftwidth=4
" And always set the indent to a multiple of shiftwidth
set shiftround

" Copy the indent from the above line
set autoindent

" Search around line breaks
set wrapscan

set ignorecase

" Make the command line 2 lines high
set ch=2

" Allow backspacing over indents, eol and start of an insert
set backspace=2

" Make sure unsaved buffers are allowed to be hidden without being saved
set hidden

" Make the change <motion> actions put a $ at the end instead of just deleting
set cpoptions=cesB$

" Keep a bit more history
set history=1000

" Enable search highlighting
set hlsearch

" Read a file that has changed on disk
set autoread

" Turn the line numbers on
set nu
set relativenumber

" Set the leader up to be the comma
let mapleader=","

" Don't syntax highlight lines that are too long
set synmaxcol=1024

" Set up backups
if has('persistent_undo')
	set undofile
	set undolevels=1000
	set undoreload=10000
endif

" Show matching brackets
set showmatch

" For times when you forget to set sudo
cmap w!! W !sudo tee % >/dev/null


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

"=============================================================================
" Fix constant spelling mistakes
"=============================================================================

    iab Acheive    Achieve
    iab acheive    achieve
    iab Alos       Also
    iab alos       also
    iab Aslo       Also
    iab aslo       also
    iab Becuase    Because
    iab becuase    because
    iab Bianries   Binaries
    iab bianries   binaries
    iab Bianry     Binary
    iab bianry     binary
    iab Charcter   Character
    iab charcter   character
    iab Charcters  Characters
    iab charcters  characters
    iab Exmaple    Example
    iab exmaple    example
    iab Exmaples   Examples
    iab exmaples   examples
    iab Fone       Phone
    iab fone       phone
    iab Lifecycle  Life-cycle
    iab lifecycle  life-cycle
    iab Lifecycles Life-cycles
    iab lifecycles life-cycles
    iab Seperate   Separate
    iab seperate   separate
    iab Seureth    Suereth
    iab seureth    suereth
    iab Shoudl     Should
    iab shoudl     should
    iab Taht       That
    iab taht       that
    iab Teh        The
    iab teh        the


" Map the save and new tab keys
noremap <C-s> <esc>:w<CR>
inoremap <C-s> <esc>:w<CR>
noremap <C-t> <esc>:tabnew<CR>

" Bind the :W to :w (typo)
command! W w

nnoremap <silent> <leader>ev :split $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" Search the current file for what's currently in the search register and display matches
nnoremap <silent> <leader>gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the word under the cursor and display matches
nnoremap <silent> <leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nnoremap <silent> <leader>gW :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Automatically save the states of the buffers on exit and load them on entry
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
":set guioptions-=r  "remove right-hand scroll bar
":set guioptions-=L  "remove left-hand scroll bar

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
noremap 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nnoremap <M-k> mz:m-2<cr>`z
nnoremap <M-j> mz:m+<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm




if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif


" Set the font
if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"http://vim.wikia.com/wiki/Easier_buffer_switching
"""""""""""""""""""
"     Taglist
"""""""""""""""""""
Plugin 'taglist.vim'
" Set the toggle key
nnoremap <silent> <F8> :TlistToggle<CR>
" Open the taglist on vim start-up
let Tlist_Auto_Open = 1
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
    "nnoremap <silent> <leader>tt :TlistToggle<CR>

    " map <leader>to to the tags open function
    nnoremap <silent> <leader>to :TlistOpen<CR>

    " map <leader>tc to the tags close function
    nnoremap <silent> <leader>tc :TlistClose<CR>

    " Automatically highlight the current tag in the taglist
    let Tlist_Auto_Highlight_Tag=1



""""""""""""""""""""
" NERDTree
""""""""""""""""""""
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


"""""""""""""""""""""""
" SnipMate
"""""""""""""""""""""""
Plugin 'snipMate'
let g:snips_author = "John Evans"

" map :c-all to copy all
noremap <Leader>c-all :%y<CR>

" map :hll to highlight long line
nnoremap <Leader>hll :call<SID>LongLineHLToggle()<CR>

hi OverLength ctermbg=none cterm=none
match OverLength /\%>800v/
fun! s:LongLineHLToggle()
    if !exists('w:longlinehl')
        let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
        echo "Long lines highlighted"
    else
        call matchdelete(w:longlinehl)
        unl w:longlinehl
        echo "Long lines unhighlighted"
    endif
endfunction

" Show the tabline if there are 2 or more tabs
"set showtabline=2

" Press Enter to insert a new line below the cursor
" Press Shift Enter to insert a new line before the current line
" Both commands do not take you into INSERT mode
noremap <S-Enter> O<Esc>
noremap <CR> o<Esc>


" Highlight whitespace at the end of a line in blue
" http://vimbits.com/bits/259
highlight WhitespaceEOL ctermbg=Blue guibg=Blue
match WhitespaceEOL /\s\+$/


"""""""""""""""""""""""
" Mini buffer explorer
"""""""""""""""""""""""
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
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

" If you like control + arrow key to navigate windows
" then perform the remapping
"
noremap <C-Down>  <C-W>j
noremap <C-Up>    <C-W>k
noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l

noremap <C-TAB>   :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>
" use single click in the buffer explorer bar
let g:miniBufExplUseSingleClick = 1

"""""""""""""""""""""""
" Fugitive
"""""""""""""""""""""""
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
autocmd BufReadPost fugitive://* set bufhidden=delete
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


Plugin 'altercation/vim-colors-solarized'
"syntax enable
set background=dark
"colorscheme solarized


Plugin 'matchit.zip'


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
"
"


"Plugin 'will133/vim-dirdiff'


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

Plugin 'align'
Plugin 'AutoAlign'

Plugin 'mattn/emmet-vim'
Plugin 'mattn/webapi-vim'
" override configuration
let g:user_emmet_settings = {
			\    'indentation' : '    '
			\}
" Set the expand key
let g:user_emmet_leader_key = '<C-Z>'


Plugin '2072/PHP-Indenting-for-VIm'
" Use indentation for switch/case statements
:let g:PHP_vintage_case_default_indent = 1

"Plugin 'tagbar' I use taglist


Plugin 'scrooloose/syntastic'
"Plugin '907th/vim-auto-save'
"" Enable auto_save on start
"let g:auto_save = 1
"" Do not check the update time
"let g:auto_save_no_updatetime = 1

" Initial settings to be revised after reading the manual
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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


Plugin 'css_color.vim'
Plugin 'indentLine.vim'
" Possible to change the color of the lines
let g:indentLine_color_term = 239
let g:indentLine_color_gui  = '#A4E57E'
" And also the character
let g:indentLine_cha = ':'

Plugin 'bogado/file-line'
Plugin 'navajo-night'
"Plugin 'gitDiff.vim'
Plugin 'markdown'
Plugin 'Rename'
" VIM-PHP_Refactoring-Toolbox conflicts with easyGrep with one of shortcuts
" \rvl
"Plugin 'VIM-PHP-Refactoring-Toolbox'
"Plugin 'easyGrep'

"Plugin 'greplace.vim'
" Candystripe colorscheme
Plugin 'modess/vim-phpcolors'
"Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
" ds<surround-to-delete> will delete  the surround
" cs<surround-to-delete><surround-to-replace-with>
" ys<motion><surround-to-insert>
" yss<surround-to-insert> works on line excluding leading whitespace
" ySS<surround-to-insert> surrounds the line and indents it
"
" Closing surrounds like })>] work as is but openings {(<[ insert a space to
" the inside
"
Plugin 'elzr/vim-json'
" Turn off concealement (hiding the quotation marks)
let g:vim_json_syntax_conceal = 0
Plugin 'bling/vim-airline'"
"let g:airline#extensions#tabline#enabled = 1
" use the powerline fonts
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " Show the statusline all of the time oand not just when a split is showing
  set laststatus=2

Plugin 'airblade/vim-gitgutter'
" I don't want gitgutter to set up any key bindings as I want to handle these
" with Fugitive
let g:gitgutter_map_keys = 0
" and turn off line highlighting
let g:gitgutter_highlight_lines = 0

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


" All of your Plugins must be added before the following line
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

colorscheme candystripe


" Show an ASCII art cat whenever vim starts
echo ">^.^<"

" Set a mapping up to convert the current word into uppercase
inoremap <c-u> <esc>viWUEa
nnoremap <c-u> viWUE