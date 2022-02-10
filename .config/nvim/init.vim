" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
call plug#begin(stdpath('data') . '/plugged')

" File explorer/browser(enabled on-demand)
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Completion like VSCode.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" a class/functions/variables outline viewer
Plug 'preservim/tagbar'

" Lean & mean status/tabline
Plug 'vim-airline/vim-airline'

" theme
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()

" ------------------------------------------------------------
" coc-nvim configuration
" ------------------------------------------------------------

" this are used in the keybindings, not by themselves
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ------------------------------------------------------------
" vim-airline configuration
" ------------------------------------------------------------
let g:airline_powerline_fonts = 1
" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" ------------------------------------------------------------
" gruvbox configuration
" ------------------------------------------------------------
colorscheme gruvbox

hi Normal guibg=None "Make transparent background
" ------------------------------------------------------------
" Nvim configuration
" ------------------------------------------------------------

" Highlight a selection on yank
au TextYankPost * silent! lua vim.highlight.on_yank()
set number              " Enable line numbers
set relativenumber      " Enable line numbers relative to with the cursor
set mouse=a             " Enable mouse drag on window splits
set splitbelow          " Always split below
set tabstop=4           " number of visual spaces per TAB
set shiftwidth=4        " Number of spaces to use for autoindent
set expandtab           " Make tabs spaces

if has("nvim-0.5.0")
    set signcolumn=number   " Merge signcolumn and number column into one
endif

if (has("termguicolors"))
    set termguicolors
endif

" ------------------------------------------------------------
" Key mappings
" ------------------------------------------------------------

"____________________________________________________________
" NERDTree
" _____________________________________________________________
nmap        <F2>     :NERDTreeToggle<CR>

" Start NERDTree when nvim launches and put cursor on other window
autocmd VimEnter * NERDTree | wincmd p

let NERDTreeWinSize = 25 "Set the panel width

" tagbar
nmap        <F8>      :TagbarToggle<CR>

"toggle search highlighting
nnoremap <F3>   :set hlsearch!<CR>

" coc-nvim
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

