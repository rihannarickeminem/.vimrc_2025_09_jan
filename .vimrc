  let g:mapleader = "\<Space>"

call plug#begin('~/.vim/autoload')

" Make sure you use single quotes

Plug 'tpope/vim-sensible'
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Plug 'sjl/gundo.vim'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let g:go_imports_autosave = 0

Plug 'drmikehenry/vim-fontsize'

nmap <silent> <Leader>=  <Plug>FontsizeBegin
nmap <silent> <Leader>+  <Plug>FontsizeInc
nmap <silent> <Leader>-  <Plug>FontsizeDec
nmap <silent> <Leader>0  <Plug>FontsizeDefault

" {{{
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

  " nnoremap <silent> <leader><space> :GFiles<CR>
  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>a :Buffers<CR>
  nnoremap <silent> <leader>A :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> <leader>. :AgIn 

  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

  " https://vi.stackexchange.com/questions/31012/what-does-plug-do-in-vim
  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)
  imap <C-x><C-w> <plug>(fzf-complete-word)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction

  function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
  endfunction
  command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
" }}}
nnoremap <silent><leader>f :FZF -q <C-R>=expand("<cword>")<CR><CR>
function! s:getVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)

    if len(lines) == 0
        return ""
    endif

    let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]

    return join(lines, "\n")
endfunction

vnoremap <silent><leader>f <Esc>:FZF -q <C-R>=<SID>getVisualSelection()<CR><CR>
let g:fzf_history_dir = '~/.local/share/fzf-history'
let $FZF_DEFAULT_COMMAND = 'ag --ignore dist -g ""'

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
Plug 'zivyangll/git-blame.vim'

Plug 'tpope/vim-vividchalk'
Plug 'sainnhe/everforest'

Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ruanyl/vim-fixmyjs'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'sjl/gundo.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'benjifisher/matchit.zip'
" Plug 'ternjs/tern_for_vim'
" Plug 'moll/vim-node'
Plug 'lambdalisue/vim-fullscreen'
Plug 'KabbAmine/vCoolor.vim'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
" Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'posva/vim-vue'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = ['coc-tsserver']


" это чтобы сделать подсветку тайпскрипта
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript
augroup END
" https://github.com/leafgarland/typescript-vim/issues/158

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'peitalin/vim-jsx-typescript'
" Initialize plugin system
call plug#end()

" https://github.com/sainnhe/everforest/blob/master/doc/everforest.txt
" Important!!
        if has('termguicolors')
          set termguicolors
        endif

        " For dark version.
        " set background=dark

        " For light version.
        set background=light

        " Set contrast.
        " This configuration option should be placed before `colorscheme everforest`.
        " Available values: 'hard', 'medium'(default), 'soft'
        let g:everforest_background = 'medium'

        " For better performance
        let g:everforest_better_performance = 1

        colorscheme everforest
" colorscheme evening
" colorscheme vividchalk
" colorscheme macvim

" autocmd ColorScheme * highlight CocHighlightText     ctermfg=LightMagenta    guifg=LightMagenta
highlight CocUnusedHighlight term=underline cterm=underline 
" меняем подсветку с серым фоном , а то на ней не видно текст белый
" https://github.com/neoclide/coc-highlight/issues/6

let g:vcoolor_custom_picker = 'zenity --title "custom" --color-selection --show-palette --color '

let g:vcool_ins_rgba_map = '<A-z>'
" set so=5
" let g:syntastic_javascript_checkers = ['standard']

" autocmd bufwritepost *.js silent !standard --fix %
set autoread
" let g:signify_vcs_list

set go-=m
set go-=T

set expandtab tabstop=2 shiftwidth=2

""" for macos toggle
" silent! map <D-u> :NERDTreeToggle<CR>
" silent! map <D-i> :NERDTreeFind<CR>
""" for macos toggle
map <C-k> :NERDTreeToggle<CR>
map <C-j> :NERDTreeFind<CR>
" silent! nmap <M-S-u> :NERDTreeToggle<CR>
" map <silent> <C-n> :NERDTreeFocus<CR>
" silent! nmap <M-S-i> :NERDTreeFind<CR>
" silent! map <F3> :NERDTreeFind<CR>

" let g:NERDTreeMapActivateNode="<F3>"
" let g:NERDTreeMapPreview="<F4>"
" nnoremap <F5> :GundoToggle<CR>
nnoremap <F5> :UndotreeToggle<cr>

set backupcopy=yes

set hlsearch

set pastetoggle=<F10>
set number relativenumber

" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END
" nnoremap <leader>s :syntax on<CR>
" nnoremap <leader>S :syntax off<CR>

" let g:ackprg = 'ag --vimgrep --smart-case'                                                   

if executable('ag')
  " added here for mac
  " let $PATH='/usr/local/bin:' commented on linux mint 19.1 cinnamon -
  " without it working
  " added here for mac
  let g:ackprg = 'ag --vimgrep'
endif

cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

nnoremap <leader>s :syntax on<CR>
nnoremap <leader>S :syntax off<CR>

if exists(":nohls")
  nnoremap <silent> <C-L> :nohls<CR><C-L>
endif

nnoremap <leader>% :MtaJumpToOtherTag<cr>

set incsearch

set nobackup
set nowritebackup
set noswapfile
let g:fixmyjs_use_local = 1

set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}
" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  for bufnr in bufnrlist
    " separate buffer entries
    if tip!=''
      let tip .= " \n "
    endif
    " Add name of buffer
    let name=bufname(bufnr)
    if name == ''
      " give a name to no name documents
      if getbufvar(bufnr,'&buftype')=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    endif
    let tip.=name
    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor
  return tip
endfunction
set guitabtooltip=%{GuiTabToolTip()}
nnoremap <silent> <C-n> :set relativenumber!<cr>
" set filetypes as typescript.jsx
" autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.jsx

" ack -l 'pattern' | xargs perl -pi -E 's/pattern/replacement/g'
" need to install  the `ack` with `sudo apt-get install ack-grep`
" npm install -g snazzy && standard --verbose | snazzy




" Open files in horizontal split
nnoremap <silent> <Leader>s :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>

" Open files in vertical horizontal split
nnoremap <silent> <Leader>v :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>

" https://vi.stackexchange.com/questions/3093/how-can-i-change-the-font-size-in-gvim

function! RandomString(n)
  let ret = ""
  for i in range(a:n)
    let j = rand()
    let c = nr2char(char2nr('a') + (j % 26))
    let ret .= c
  endfor
  return ret
endfunction

" imap <expr> cll "console.log('" . RandomString(20) . "')<Esc><S-f>(a"
imap <expr> cll "console.log('" . RandomString(20) . "  :', )<Esc><S-f> a"
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll yiwocll<Esc>p
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" https://vi.stackexchange.com/questions/16906/how-to-format-json-file-in-vim
" formatting json file %!jq .
