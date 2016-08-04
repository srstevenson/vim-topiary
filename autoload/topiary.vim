" vim-topiary: trim excess whitespace
" Maintainer: Scott Stevenson <scott@stevenson.io>
" Source:     https://github.com/srstevenson/vim-topiary

function! s:InList(item, list) abort
  return index(a:list, a:item) >= 0
endfunction

function! s:TrimEOLWhitespace() abort
  %s/\s\+$//e
endfunction

function! s:TrimLeadingBlankLines() abort
  %s/\%^\n\+//e
endfunction

function! s:TrimTrailingBlankLines() abort
  %s/\n\+\%$//e
endfunction

function! s:CollapseMultipleBlankLines() abort
  if s:InList(&filetype, g:topiary_ft_allow_two_blank_lines)
    %s/\n\{4,}/\r\r\r/e
  else
    %s/\n\{3,}/\r\r/e
  endif
endfunction

function! topiary#CheckIsList(variable) abort
  if type(a:variable) != type([])
    echo 'Error:' a:variable 'must be a list'
  endif
endfunction

function! topiary#TrimWhitespace() abort
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
