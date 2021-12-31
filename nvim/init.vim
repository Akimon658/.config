colorscheme slate

hi LineNr ctermfg=240
hi LspErrorVirtualText ctermbg=9
hi ModeMsg ctermfg=248
hi Nontext ctermfg=240
hi Pmenu ctermbg=236 ctermfg=248
hi PmenuSel ctermbg=240 ctermfg=255
hi SpecialKey ctermfg=240
hi StatusLine cterm=NONE ctermbg=12 ctermfg=252
hi TabLine cterm=NONE ctermbg=238 ctermfg=248
hi TabLineFill cterm=NONE ctermbg=238
hi Underlined ctermfg=6

inoremap ( ()<LEFT>
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ` ``<LEFT>

function! NewlineWithIndent()
	let nlAndIndent = "\n\t\n\<UP>\<END>"
	let open = getline(".")[col(".")-2]
	let close = getline(".")[col(".")-1]

	if close == "}" && open == "{"
		return nlAndIndent
	elseif close == ")" && open == "("
		return nlAndIndent
	elseif close == "]" && open == "["
		return nlAndIndent
	else
		return "\n"
	endif
endfunction
inoremap <silent> <expr> <CR> NewlineWithIndent()

autocmd! BufNewFile,BufRead !*.go,!*.md,!*.txt inoremap ' ''<LEFT>

autocmd! BufNewFile,BufRead *.go packadd vim-goimports

set autoindent
set lcs=eol:↲,tab:>_,trail:･
set list
set number
set shiftwidth=4
set showmatch
set splitright
set tabstop=4

autocmd! BufNewFile,BufRead *.json set filetype=jsonc

syntax on

tnoremap <silent> <Esc> <C-\><C-n>
