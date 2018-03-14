set relativenumber

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
"
" " Declare the list of plugins.
" Plug 'tpope/vim-sensible'
" Plug 'junegunn/seoul256.vim'
"
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'zhaocai/GoldenView.Vim'

"
" " List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Ruby-Vim
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set tabstop=2 shiftwidth=2 expandtab

"GoldenView
nmap <silent> <F9> <Plug>GoldenViewSwitchToggle
nnoremap <silent> <C-j> :vertical resize -15<CR>
nnoremap <silent> <C-k> :vertical resize +15<CR>

" FZF
nnoremap <C-o> :Files<CR>

" Enable Tab and Shift+Tab to indent/unindent code
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

if !exists( "*RubyEndToken" )
  function RubyEndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
      let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'

      if match(current_line, braces_at_end) >= 0
        return "\<CR>}\<C-O>O"
      elseif match(current_line, stuff_without_do) >= 0
        return "\<CR>end\<C-O>O"
      elseif match(current_line, with_do) >= 0
        return "\<CR>end\<C-O>O"
      else
        return "\<CR>" 
      endif
    endfunction

endif

imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
