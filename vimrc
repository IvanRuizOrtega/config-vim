"" PreInstall
"" SO Install GitHub, nodejs and npm 
"" Paste in .vimrc 

set number
set mouse=a
syntax enable
set showcmd
set encoding=utf8
set showmatch
set relativenumber


call plug#begin()

 " List your plugins here
  Plug 'tpope/vim-sensible'

 " Íconos para NERDTree y archivos
  Plug 'ryanoasis/vim-devicons'

 "LCP
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'

" Use release branch (recommended)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
 
" Snnipets
 " Track the engine.
  Plug 'SirVer/ultisnips'

 " Snippets are separated from the engine. Add this if you want them:
  Plug 'honza/vim-snippets' 

" Commentaries
 Plug 'tpope/vim-commentary'
" LineFunctions
 Plug 'Yggdroot/indentLine'

" FileManagement
 Plug 'vim-airline/vim-airline'
 Plug 'preservim/nerdtree'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'

" Management versions 
 Plug 'zivyangll/git-blame.vim'

call plug#end()
"" Management versions 
nnoremap Gc :<C-u>call gitblame#echo()<CR>

"" Delete spaces
autocmd BufWritePre * :%s/\s\+$//e

"" Colors ----
syntax enable 
set background=dark
colorscheme zaibatsu
" Colores personalizados de la ventana flotante de CoC
highlight CocErrorFloat guifg=#FF5555 guibg=#282C34
highlight CocWarningFloat guifg=#FFFF55 guibg=#282C34
highlight CocInfoFloat guifg=#55FFFF guibg=#282C34
highlight CocHintFloat guifg=#55FF55 guibg=#282C34

" Color del fondo de las ventanas flotantes
highlight CocFloating guibg=#282C34

" Color de selección en menú de autocompletado
highlight CocMenuSel guibg=#3E4452 guifg=#FFFFFF

" NERDTree y vim-devicons
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Colores personalizados para NERDTree
autocmd FileType nerdtree highlight NERDTreeDir guifg=#fabd2f
autocmd FileType nerdtree highlight NERDTreeFile guifg=#b8bb26
autocmd FileType nerdtree highlight NERDTreeExecFile guifg=#83a598

"" Desactiva swap y backups en archivos grandes ---
set noswapfile
set nobackup
set nowritebackup

" Desactiva el plugin de syntax si el archivo es enorme
autocmd BufReadPre * if getfsize(expand('%')) > 10000000 | syntax off | endif

" Incrementa el scroll por línea (opcional)
set lazyredraw

" Habilita el folding por sintaxis
set foldmethod=indent

" Abre los folds cerrados por defecto
set foldlevelstart=0

" Habilita el fold
set foldenable

" Máximo nivel de nesting de folds
set foldnestmax=3

" Opcional: usa la tecla espacio para abrir/cerrar folds
nnoremap <space> za

"" FileManagement ----
let g:airline#extensions#tabline#enabled = 1
let NERDTreeQuitOnOpen=1
nnoremap <silent><F2> :NERDTreeFind <CR> 
nnoremap <silent><F2> :NERDTreeToggle <CR> 

" Buscar archivos
nnoremap sf :Files<CR>
" Buscar en archivos git
" nnoremap <silent> <leader>g :GFiles<CR>
" Buscar texto con ripgrep
nnoremap st :Rg<Space>
" Buscar en buffers abiertos
nnoremap bo :Buffers<CR>
" Buscar en las líneas del buffer actual
nnoremap sl :BLines<CR>


"" ---- Commentaries ----
nnoremap <space>c :Commentary <CR> 
vnoremap <space>c :Commentary <CR> 
 

"" --- Prettier ---
"" Command: CocInstall coc-prettier coc-pyright coc-tsserver coc-html coc-css coc-phpls coc-eslint coc-json
""" Abrir :CocConfig y pegar {
  ""// Activa el formateo al guardar para TODOS los lenguajes.
  "coc.preferences.formatOnSave": true,
  "coc.preferences.formatOnSaveFiletypes": ["*"],

  ""// Ejemplo de configuración para Prettier (JS, TS, HTML, CSS, JSON, etc.)
  "prettier.printWidth": 79,
  "prettier.singleQuote": true,
  "prettier.trailingComma": "es5",

  ""// Configuración para Python con Black
  "python.formatting.provider": "black",
  "python.formatting.blackArgs": ["--line-length", "79"],

  ""// Configuración para PHP (usando php-cs-fixer y la regla PSR12)
  "php-cs-fixer.rules": "@PSR12"
""}
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <C-P> :Prettier <CR> 


""------ Snippets ----
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


""------ Neoclide ----

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
