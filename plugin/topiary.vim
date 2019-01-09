" vim-topiary: trim excess whitespace
" Maintainer: Scott Stevenson <scott@stevenson.io>
" Source:     https://github.com/srstevenson/vim-topiary

if exists('g:loaded_topiary') || &compatible
    finish
endif
let g:loaded_topiary = 1

function! s:IsList(variable) abort
    " Determine if a variable is a list.
    "
    " Parameters
    " ----------
    " variable : Any
    "     Value of the variable.
    "
    " Returns
    " -------
    " Boolean
    "     v:true if the variable is a list, v:false otherwise.
    return type(a:variable) ==# type([])
endfunction

function! s:IsNumber(variable) abort
    " Determine if a variable is a number.
    "
    " Parameters
    " ----------
    " variable : Any
    "     Value of the variable.
    "
    " Returns
    " -------
    " Boolean
    "     v:true if the variable is a number, v:false otherwise.
    return type(a:variable) ==# type(0)
endfunction

if exists('g:topiary_enabled')
    if !s:IsNumber(g:topiary_enabled)
        echoerr 'vim-topiary: g:topiary_enabled must be a number'
    endif
else
    let g:topiary_enabled = 1
endif

if exists('g:topiary_ft_disabled')
    if !s:IsList(g:topiary_ft_disabled)
        echoerr 'vim-topiary: g:topiary_ft_disabled must be a list'
    endif
else
    let g:topiary_ft_disabled = ['diff']
endif

if exists('g:topiary_ft_allow_two_blank_lines')
    if !s:IsList(g:topiary_ft_allow_two_blank_lines)
        echoerr 'vim-topiary: g:topiary_ft_allow_two_blank_lines must be a list'
    endif
else
    let g:topiary_ft_allow_two_blank_lines = ['python']
endif

augroup topiary
    autocmd!
    autocmd BufWritePre * call topiary#TrimWhitespace()
augroup END

command -bar TopiaryDisable call topiary#Disable()
command -bar TopiaryEnable call topiary#Enable()
command -bar TopiaryToggle call topiary#Toggle()

command -bar TopiaryDisableBuffer call topiary#DisableBuffer()
command -bar TopiaryEnableBuffer call topiary#EnableBuffer()
command -bar TopiaryToggleBuffer call topiary#ToggleBuffer()

nnoremap <silent> <Plug>TopiaryDisable :TopiaryDisable<CR>
nnoremap <silent> <Plug>TopiaryEnable :TopiaryEnable<CR>
nnoremap <silent> <Plug>TopiaryToggle :TopiaryToggle<CR>

nnoremap <silent> <Plug>TopiaryDisableBuffer :TopiaryDisableBuffer<CR>
nnoremap <silent> <Plug>TopiaryEnableBuffer :TopiaryEnableBuffer<CR>
nnoremap <silent> <Plug>TopiaryToggleBuffer :TopiaryToggleBuffer<CR>
