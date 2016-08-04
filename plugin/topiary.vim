" vim-topiary: trim excess whitespace
" Maintainer: Scott Stevenson <scott@stevenson.io>
" Source:     https://github.com/srstevenson/vim-topiary

if !exists('g:topiary_ft_disabled')
  let g:topiary_ft_disabled = ['diff']
endif

if !exists('g:topiary_ft_allow_two_blank_lines')
  let g:topiary_ft_allow_two_blank_lines = ['python']
endif

augroup topiary
  autocmd!
  autocmd BufWritePre * call topiary#TrimWhitespace()
augroup END
