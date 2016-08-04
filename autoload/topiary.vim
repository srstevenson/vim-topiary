" vim-topiary: trim excess whitespace
" Maintainer: Scott Stevenson <scott@stevenson.io>
" Source:     https://github.com/srstevenson/vim-topiary

function! s:InList(item, list)
  return index(a:list, a:item) >= 0
endfunction

function! s:TrimEOLWhitespace()
  %s/\s\+$//e
endfunction

function! s:TrimLeadingBlankLines()
  %s/\%^\n\+//e
endfunction

function! s:TrimTrailingBlankLines()
  %s/\n\+\%$//e
endfunction

function! s:CollapseMultipleBlankLines()
  if s:InList(&filetype, g:topiary_ft_allow_two_blank_lines)
    %s/\n\{4,}/\r\r\r/e
  else
    %s/\n\{3,}/\r\r/e
  endif
endfunction

function! topiary#TrimWhitespace()
  if s:InList(&filetype, g:topiary_ft_disabled)
    return
  endif

  let l:view = winsaveview()
  call s:TrimEOLWhitespace()
  call s:TrimLeadingBlankLines()
  call s:TrimTrailingBlankLines()
  call s:CollapseMultipleBlankLines()
  call winrestview(l:view)
endfunction
