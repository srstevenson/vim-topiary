" vim-topiary: trim excess whitespace
" Maintainer: Scott Stevenson <scott@stevenson.io>
" Source:     https://github.com/srstevenson/vim-topiary

function! s:InList(item, list) abort
    return index(a:list, a:item) >= 0
endfunction

function! s:TrimEOLWhitespace() abort
    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    %s/\s\+$//e
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
endfunction

function! s:TrimLeadingBlankLines() abort
    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    %s/\%^\n\+//e
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
endfunction

function! s:TrimTrailingBlankLines() abort
    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    %s/\n\+\%$//e
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
endfunction

function! s:CollapseMultipleBlankLines() abort
    if s:InList(&filetype, g:topiary_ft_allow_two_blank_lines)
        " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
        %s/\n\{4,}/\r\r\r/e
        " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
    else
        " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
        %s/\n\{3,}/\r\r/e
        " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
    endif
endfunction

function! topiary#CheckIsList(variable, name) abort
    if type(a:variable) != type([])
        echomsg 'Error:' a:name 'must be a list'
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
