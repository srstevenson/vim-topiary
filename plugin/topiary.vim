" vim-topiary: trim excess whitespace
" Maintainer: Scott Stevenson <scott@stevenson.io>
" Source:     https://github.com/srstevenson/vim-topiary

if exists('g:loaded_topiary') || &compatible
  finish
else
  let g:loaded_topiary = 1
endif

if exists('g:topiary_ft_disabled')
  call topiary#CheckIsList('g:topiary_ft_disabled')
else
  let g:topiary_ft_disabled = ['diff']
endif

if exists('g:topiary_ft_allow_two_blank_lines')
  call topiary#CheckIsList('g:topiary_ft_allow_two_blank_lines')
else
  let g:topiary_ft_allow_two_blank_lines = ['python']
endif

augroup topiary
  autocmd!
  autocmd BufWritePre * call topiary#TrimWhitespace()
augroup END
