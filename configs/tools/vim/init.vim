" ============================================================================
" AUTO-INSTALL VIM-PLUG (DISABLED)
" ============================================================================
" Automatically downloads and installs vim-plug plugin manager on first run
" Uncomment to enable automatic installation

" let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
" if empty(glob(data_dir . '/autoload/plug.vim'))
"   silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" ============================================================================
" PLUGIN MANAGEMENT
" ============================================================================
call plug#begin()
" Syntax highlighting and parsing
" Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
" Plug 'nvim-treesitter/playground'

" Fuzzy finder and file navigation
" Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" Plug 'nvim-lua/plenary.nvim'
Plug 'preservim/nerdtree'

" Terminal integration
" Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Auto-close brackets and quotes
" Plug 'jiangmiao/auto-pairs'

" Quick navigation with two-character search
" Plug 'justinmk/vim-sneak'

" Color Schemes
Plug 'ellisonleao/gruvbox.nvim'
Plug 'gruvbox-community/gruvbox'
call plug#end()

" ============================================================================
" GENERAL SETTINGS
" ============================================================================
filetype plugin indent on
syntax on
syntax enable

" Completion Menu
set completeopt=noinsert,menuone,noselect

" Clipboard Integration
set clipboard=unnamedplus

" UI Appearance
set background=dark
set fillchars+=vert:\    " Vertical split character
set wrap breakindent     " Wrap lines with indentation
set termguicolors        " Enable 24-bit RGB colors
set scrolloff=15         " Keep 15 lines visible above/below cursor
set number               " Show line numbers
set title                " Set window title
set showcmd              " Show command in status line
set wildmenu             " Enhanced command-line completion
" set laststatus=0         " Hide status line at the bottom

" Text Formatting
set encoding=utf-8
set conceallevel=1       " Conceal text (useful for markdown/latex)
set textwidth=0          " No automatic line wrapping
set smarttab

" Buffer Management
set hidden               " Allow switching buffers without saving

" ============================================================================
" LEADER KEY
" ============================================================================
let mapleader=";"


" ============================================================================
" NORMAL MODE KEYBINDINGS
" ============================================================================
" File Operations
nnoremap <leader><Space> <cmd>x<cr>      " Save and exit

" Terminal Toggle
nnoremap <leader>t <cmd>ToggleTerm direction=float<CR>

" Telescope Fuzzy Finder
nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>



" Disable Default Keys
nnoremap <Space> <Nop>
nnoremap j <Nop><CR> 
nnoremap k <Nop><cr>
nnoremap l <Nop><cr>

" Buffer Navigation
nnoremap <S-Tab> :bprevious<CR>
nnoremap <Tab> :bnext<CR>

" Line Navigation
nnoremap u 0              " Jump to start of line
nnoremap o $              " Jump to end of line
nnoremap <S-Down> :m+<CR> " Move line down
nnoremap <S-Up> :m-2<CR>  " Move line up

" Indentation
nnoremap > >>
nnoremap < <<

" Search Navigation
nnoremap n nzz            " Next search result (centered)
nnoremap N Nzz            " Previous search result (centered)

" Insert Line Below
nnoremap <S-i> o

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ============================================================================
" INSERT MODE KEYBINDINGS
" ============================================================================

" Quick Escape (Disabled)
"inoremap jf <ESC>

" Line Movement in Insert Mode
inoremap <S-Down> <Esc>:m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>

" ============================================================================
" VISUAL MODE KEYBINDINGS
" ============================================================================

" Indentation
vnoremap < <<
vnoremap > >>

" Line Movement
vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv

" ============================================================================
" THEME CONFIGURATION (LUA)
" ============================================================================
lua << EOF
require("gruvbox").setup({
   -- Base Configuration
   contrast = "hard",
   palette_overrides = {
      dark0_hard = "#0E1018"
   },
   
   -- Custom Highlight Overrides
   overrides = {
      -- General UI
      NormalFloat = {fg = "#ebdbb2", bg = "#504945"},
      Comment = {fg = "#81878f", italic = false, bold = false},
      
      -- Syntax Highlighting
      Define = {link = "GruvboxPurple"},
      Macro = {link = "GruvboxPurple"},
      ["@constant.builtin"] = {link = "GruvboxPurple"},
      ["@storageclass.lifetime"] = {link = "GruvboxAqua"},
      ["@text.note"] = {link = "TODO"},
      ["@namespace.rust"] = {link = "Include"},
      ["@punctuation.bracket"] = {link = "GruvboxOrange"},
      
      -- LaTeX Math Delimiters
      texMathDelimZoneLI = {link = "GruvboxOrange"},
      texMathDelimZoneLD = {link = "GruvboxOrange"},
      
      -- Lua Error Handling
      luaParenError = {link = "luaParen"},
      luaError = {link = "NONE"},
      
      -- Context and Suggestions
      ContextVt = {fg = "#878788"},
      CopilotSuggestion = {fg = "#878787"},
      
      -- CoC (Conquer of Completion) Integration
      CocCodeLens = {fg = "#878787"},
      CocWarningFloat = {fg = "#dfaf87"},
      CocInlayHint = {fg = "#ABB0B6"},
      CocPumShortcut = {fg = "#fe8019"},
      CocPumDetail = {fg = "#fe8019"},
      
      -- Diagnostics
      DiagnosticVirtualTextWarn = {fg = "#dfaf87"},
      
      -- Folding
      Folded = {fg = "#fe8019", bg = "#0E1018", italic = true},
      SignColumn = {bg = "#fe8019"},
      
      -- Git Diff Colors
      DiffAdd = {
         bold = true,
         reverse = false,
         fg = "",
         bg = "#2a4333"
      },
      DiffChange = {
         bold = true,
         reverse = false,
         fg = "",
         bg = "#333841"
      },
      DiffDelete = {
         bold = true,
         reverse = false,
         fg = "#442d30",
         bg = "#442d30"
      },
      DiffText = {
         bold = true,
         reverse = false,
         fg = "",
         bg = "#213352"
      },
      
      -- Status Line
      StatusLine = {bg = "#fe8019", fg = "#0E1018"},
      StatusLineNC = {bg = "#3c3836", fg = "#0E1018"},
      CursorLineNr = {fg = "#fabd2f", bg = ""},
      
      -- Sign Column Colors
      GruvboxOrangeSign = {fg = "#dfaf87", bg = ""},
      GruvboxAquaSign = {fg = "#8EC07C", bg = ""},
      GruvboxGreenSign = {fg = "#b8bb26", bg = ""},
      GruvboxRedSign = {fg = "#fb4934", bg = ""},
      GruvboxBlueSign = {fg = "#83a598", bg = ""},
      
      -- Wilder Menu (Command-line Completion)
      WilderMenu = {fg = "#ebdbb2", bg = ""},
      WilderAccent = {fg = "#f4468f", bg = ""},
      
      -- CoC Semantic Tokens
      CocSemStruct = {link = "GruvboxYellow"},
      CocSemKeyword = {fg = "", bg = "#0E1018"},
      CocSemEnumMember = {fg = "", bg = "#0E1018"},
      CocSemTypeParameter = {fg = "", bg = "#0E1018"},
      CocSemComment = {fg = "", bg = "#0E1018"},
      CocSemMacro = {fg = "", bg = "#0E1018"},
      CocSemVariable = {fg = "", bg = "#0E1018"},
      CocSemFunction = {fg = "", bg = "#0E1018"},
      
      -- Neorg (Note-taking)
      ["@neorg.markup.inline_macro"] = {link = "GruvboxGreen"}
   }
})

-- Apply Colorscheme
vim.cmd("colorscheme gruvbox")
EOF

" ============================================================================
" TREESITTER CONFIGURATION (DISABLED)
" ============================================================================
" Uncomment to enable Treesitter syntax highlighting
"require'nvim-treesitter.configs'.setup {
"   enable = true,
"   ensure_installed = { "c", "lua", "vim" },
"   highlight = {
"      enable = true
"   },
"}