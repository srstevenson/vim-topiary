" vim-topiary: trim excess whitespace
" Maintainer: Scott Stevenson <scott@stevenson.io>
" Source:     https://github.com/srstevenson/vim-topiary

function! s:InList(item, list) abort
    " Determine if item is in list.
    "
    " Parameters
    " ----------
    " item : Any
    "     Item to check for.
    " list : List
    "     List whose elements to check.
    "
    " Returns
    " -------
    " Number
    "     1 if item is in list, 0 otherwise.
    return index(a:list, a:item) >= 0
endfunction

function! s:TrimEOLWhitespace() abort
    " Delete whitespace from the end of every line in the buffer.

    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    %s/\s\+$//e
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
endfunction

function! s:TrimLeadingBlankLines() abort
    " Delete blank lines from the head of the buffer.

    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    %s/\%^\n\+//e
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
endfunction

function! s:TrimTrailingBlankLines() abort
    " Delete blank lines from the tail of the buffer.

    " vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    %s/\n\+\%$//e
    " vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
endfunction

function! s:CollapseMultipleBlankLines() abort
    " Collapse multiple blank lines to a single blank line if filetype
    " is not in g:topiary_ft_allow_two_blank_lines, else collapse more
    " than two blank lines to two blank lines.

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
    " Print an error message if variable is not of type List.
    "
    " Parameters
    " ----------
    " variable : Any
    "     Value of the variable.
    " name : String
    "     Name of the variable.
    if type(a:variable) != type([])
        echoerr 'vim-topiary:' a:name 'must be a list'
    endif
endfunction

function! topiary#CheckIsNumber(variable, name) abort
    " Print an error message if variable is not of type Number.
    "
    " Parameters
    " ----------
    " variable : Any
    "     Value of the variable.
    " name : String
    "     Name of the variable.
    if type(a:variable) != type(0)
        echoerr 'vim-topiary:' a:name 'must be a number'
    endif
endfunction

function! topiary#TrimWhitespace() abort
    " Trim whitespace from the current buffer, if vim-topiary is enabled in
    " the buffer, or globally if there is no buffer local configuration, and
    " if the buffer is not of a blacklisted filetype.
    if exists('b:topiary_enabled')
        let l:enabled = b:topiary_enabled
    else
        let l:enabled = g:topiary_enabled
    endif

    if l:enabled
        if s:InList(&filetype, g:topiary_ft_disabled)
            return
        endif

        let l:view = winsaveview()
        call s:TrimEOLWhitespace()
        call s:TrimLeadingBlankLines()
        call s:TrimTrailingBlankLines()
        call s:CollapseMultipleBlankLines()
        call winrestview(l:view)
    endif
endfunction

function! topiary#ToggleBuffer() abort
    " Toggle whitespace trimming for the current buffer.
    let l:enabled = !get(b:, 'topiary_enabled', g:topiary_enabled)
    call setbufvar(bufnr(''), 'topiary_enabled', l:enabled)
endfunction

function! topiary#EnableBuffer() abort
    " Enable whitespace trimming for the current buffer.
    call setbufvar(bufnr(''), 'topiary_enabled', 1)
endfunction

function! topiary#DisableBuffer() abort
    " Disable whitespace trimming for the current buffer.
    call setbufvar(bufnr(''), 'topiary_enabled', 0)
endfunction

function! topiary#Toggle() abort
    " Toggle whitespace trimming globally.
    let g:topiary_enabled = !g:topiary_enabled
endfunction

function! topiary#Enable() abort
    " Enable whitespace trimming globally.
    let g:topiary_enabled = 1
endfunction

function! topiary#Disable() abort
    " Disable whitespace trimming globally.
    let g:topiary_enabled = 0
endfunction
