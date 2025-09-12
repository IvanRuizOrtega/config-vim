" ------------------------------
" Plugins con vim-plug
" ------------------------------
call plug#begin('~/.vim/plugged')

" Config básica
Plug 'tpope/vim-sensible'

" Íconos, tree, airline
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Comentarios, indent, git
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine'
Plug 'zivyangll/git-blame.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" LSP / autocompletado
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colores
Plug 'morhetz/gruvbox'

" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-neotest/nvim-nio'

call plug#end()

" ------------------------------
" Opciones básicas
" ------------------------------
syntax enable
set number
set relativenumber
set cursorline
set expandtab shiftwidth=4 tabstop=4 smartindent
set wildmenu
set background=dark
colorscheme gruvbox
let mapleader=" "   " usa espacio como <leader>

" Clipboard: usar el clipboard del sistema
set clipboard=unnamedplus

" Forzar a Neovim a usar xclip como proveedor de clipboard
if executable('xclip')
  let g:clipboard = {
        \   'name': 'xclip',
        \   'copy': {
        \      '+': ['xclip', '-selection', 'clipboard'],
        \      '*': ['xclip', '-selection', 'primary'],
        \    },
        \   'paste': {
        \      '+': ['xclip', '-selection', 'clipboard', '-o'],
        \      '*': ['xclip', '-selection', 'primary', '-o'],
        \   },
        \   'cache_enabled': 0,
        \ }
endif

" ------------------------------
" Atajos de antes (NERDTree, FZF, git, commentary)
" ------------------------------
nnoremap <silent><F2> :NERDTreeToggle<CR>
nnoremap <silent><F3> :NERDTreeFind<CR>
nnoremap sf :Files<CR>
nnoremap st :Rg<Space>
nnoremap bo :Buffers<CR>
nnoremap sl :BLines<CR>
nnoremap <space>c :Commentary<CR>
vnoremap <space>c :Commentary<CR>
nnoremap Gc :<C-u>call gitblame#echo()<CR>

" ------------------------------
" Debugger (nvim-dap)
" ------------------------------
lua require('dap-config')

nnoremap <F5> :lua require'dap'.continue()<CR>
nnoremap <F10> :lua require'dap'.step_over()<CR>
nnoremap <F11> :lua require'dap'.step_into()<CR>
nnoremap <F12> :lua require'dap'.step_out()<CR>
nnoremap <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <leader>du :lua require'dapui'.toggle()<CR>

" ------------------------------
" Coc.nvim configuración básica
" ------------------------------
set updatetime=300
set signcolumn=yes
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)
