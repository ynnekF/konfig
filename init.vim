" Test1
call plug#begin()

" Core (treesitter, telescope, sneak, toggle-term)
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/plenary.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'
Plug 'lervag/vimtex'

" Themes
Plug 'ellisonleao/gruvbox.nvim'
Plug 'gruvbox-community/gruvbox'

call plug#end()

"Global Options
filetype plugin indent on
syntax on
syntax enable

set completeopt=noinsert,menuone,noselect 	" Modifies the auto-complete menu to behave more like an IDE.
set clipboard=unnamedplus 			" Enables the clipboard between Vim/Neovim and other applications.
set fillchars+=vert:\ 
set wrap breakindent
set background=dark
set encoding=utf-8
set conceallevel=1
set termguicolors
set scrolloff=15
set textwidth=0
set smarttab
set wildmenu
set showcmd
set hidden
set number
set title

let mapleader=";"

"Normal
nnoremap <Space> <Nop>
nnoremap j <Nop><CR> 
nnoremap k <Nop><cr>
nnoremap l <Nop><cr>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <leader><Space> <cmd>x<cr>
nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>t <cmd>ToggleTerm direction=float<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <S-Down> :m+<CR>
nnoremap <S-Up> :m-2<CR>
nnoremap > >>
nnoremap < <<

nnoremap n nzz
nnoremap N Nzz

nnoremap <S-i> o
nnoremap u 0
nnoremap o $
"Insert
"inoremap jf <ESC>
inoremap <S-Down> <Esc>:m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>

"Visual
vnoremap < <<
vnoremap > >>
vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv

"lua << EOF
"require("gruvbox").setup(
"{
"contrast = "hard",
"palette_overrides = {dark0_hard = "#0E1018"},
"overrides = {
"    NormalFloat = {fg = "#ebdbb2", bg = "#504945"},
"    Comment = {fg = "#81878f", italic = false, bold = false},
"    Define = {link = "GruvboxPurple"},
"    Macro = {link = "GruvboxPurple"},
"    ["@constant.builtin"] = {link = "GruvboxPurple"},
"    ["@storageclass.lifetime"] = {link = "GruvboxAqua"},
"    ["@text.note"] = {link = "TODO"},
"    ["@namespace.rust"] = {link = "Include"},
"    ["@punctuation.bracket"] = {link = "GruvboxOrange"},
"    texMathDelimZoneLI = {link = "GruvboxOrange"},
"    texMathDelimZoneLD = {link = "GruvboxOrange"},
"    luaParenError = {link = "luaParen"},
"    luaError = {link = "NONE"},
"    ContextVt = {fg = "#878788"},
"    CopilotSuggestion = {fg = "#878787"},
"    CocCodeLens = {fg = "#878787"},
"    CocWarningFloat = {fg = "#dfaf87"},
"    CocInlayHint = {fg = "#ABB0B6"},
"    CocPumShortcut = {fg = "#fe8019"},
"    CocPumDetail = {fg = "#fe8019"},
"    DiagnosticVirtualTextWarn = {fg = "#dfaf87"},
"    -- fold
"    Folded = {fg = "#fe8019", bg = "#0E1018", italic = true},
"    SignColumn = {bg = "#fe8019"},
"    -- new git colors
"    DiffAdd = {
"	bold = true,
"	reverse = false,
"	fg = "",
"	bg = "#2a4333"
"    },
"    DiffChange = {
"	bold = true,
"	reverse = false,
"	fg = "",
"	bg = "#333841"
"    },
"    DiffDelete = {
"	bold = true,
"	reverse = false,
"	fg = "#442d30",
"	bg = "#442d30"
"    },
"    DiffText = {
"	bold = true,
"	reverse = false,
"	fg = "",
"	bg = "#213352"
"    },
"    -- statusline
"    StatusLine = {bg = "#ffffff", fg = "#0E1018"},
"    StatusLineNC = {bg = "#3c3836", fg = "#0E1018"},
"    CursorLineNr = {fg = "#fabd2f", bg = ""},
"    GruvboxOrangeSign = {fg = "#dfaf87", bg = ""},
"    GruvboxAquaSign = {fg = "#8EC07C", bg = ""},
"    GruvboxGreenSign = {fg = "#b8bb26", bg = ""},
"    GruvboxRedSign = {fg = "#fb4934", bg = ""},
"    GruvboxBlueSign = {fg = "#83a598", bg = ""},
"    WilderMenu = {fg = "#ebdbb2", bg = ""},
"    WilderAccent = {fg = "#f4468f", bg = ""},
"    -- coc semantic token
"    CocSemStruct = {link = "GruvboxYellow"},
"    CocSemKeyword = {fg = "", bg = "#0E1018"},
"    CocSemEnumMember = {fg = "", bg = "#0E1018"},
"    CocSemTypeParameter = {fg = "", bg = "#0E1018"},
"    CocSemComment = {fg = "", bg = "#0E1018"},
"    CocSemMacro = {fg = "", bg = "#0E1018"},
"    CocSemVariable = {fg = "", bg = "#0E1018"},
"    CocSemFunction = {fg = "", bg = "#0E1018"},
"    -- neorg
"    ["@neorg.markup.inline_macro"] = {link = "GruvboxGreen"}
"}
"}
")
"vim.cmd.colorscheme("gruvbox")	
"require("toggleterm").setup()
"require'nvim-treesitter.configs'.setup {
"  enable = true,
"  ensure_installed = { "c", "lua", "vim" },
"  higlight = {
"    enable = true
"  },
"}
"EOF