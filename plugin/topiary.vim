" vim-topiary: trim excess whitespace
" Maintainer: Scott Stevenson <scott@stevenson.io>
" Source:     https://github.com/srstevenson/vim-topiary

if exists('g:loaded_topiary') || &compatible
    finish
endif
let g:loaded_topiary = 1

if exists('g:topiary_enabled')
    call topiary#CheckIsNumber(g:topiary_enabled, 'g:topiary_enabled')
else
    let g:topiary_enabled = 1
endif

if exists('g:topiary_ft_disabled')
    call topiary#CheckIsList(g:topiary_ft_disabled, 'g:topiary_ft_disabled')
else
    let g:topiary_ft_disabled = ['diff']
endif

if exists('g:topiary_ft_allow_two_blank_lines')
    call topiary#CheckIsList(g:topiary_ft_allow_two_blank_lines,
                \ 'g:topiary_ft_allow_two_blank_lines')
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
