call plug#begin('~/.vim/plugged')

" LSP / autocompletado
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Explorer, status bar, fzf
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Snippets
Plug 'honza/vim-snippets'

" Colores
Plug 'morhetz/gruvbox'

" Debugger con coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-neotest/nvim-nio'

call plug#end()

" Opciones básicas
syntax on
set number
set relativenumber
set cursorline
set expandtab shiftwidth=4 tabstop=4 smartindent
set clipboard=unnamedplus
set wildmenu
set background=dark

" Colores
colorscheme gruvbox

" Atajos
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>

" Debugger
lua require('dap-config')

" -----------------------------
" Atajos Debugger (nvim-dap)
" -----------------------------
nnoremap <F5> :lua require'dap'.continue()<CR>
nnoremap <F10> :lua require'dap'.step_over()<CR>
nnoremap <F11> :lua require'dap'.step_into()<CR>
nnoremap <F12> :lua require'dap'.step_out()<CR>

nnoremap <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <leader>du :lua require'dapui'.toggle()<CR>
