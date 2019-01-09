# vim-topiary [![Build Status](https://travis-ci.org/srstevenson/vim-topiary.svg?branch=master)](https://travis-ci.org/srstevenson/vim-topiary)

[vim-topiary] trims excess whitespace from buffers on save. Three types of
whitespace are removed:

- trailing spaces and tabs at the end of lines
- blank lines at the start of the buffer
- blank lines at the end of the buffer

Additionally, multiple consecutive blank lines are collapsed to a single blank
line.

## Installation

If you already use a plugin manager such as [vim-plug], [Dein.vim], or [Vundle],
install vim-topiary in the normal manner. Otherwise, the recommended plugin
manager is [minpac]. Add the following to your vimrc (`$HOME/.vim/vimrc` for Vim
and `${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.vim` for Neovim), restart Vim,
and run `:call minpac#update()`:

```viml
call minpac#add('srstevenson/vim-topiary')
```

If you have Vim 7.4.1840 or newer, you can use the [native package
support][packages] instead of a plugin manager by cloning vim-topiary into a
directory under [`packpath`][packpath]. For Vim:

```sh
git clone https://github.com/srstevenson/vim-topiary \
    ~/.vim/pack/plugins/start/vim-topiary
```

For Neovim:

```sh
git clone https://github.com/srstevenson/vim-topiary \
    ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/plugins/start/vim-topiary
```

## Commands

vim-topiary provides the following commands:

- `:TopiaryEnable`: Enable whitespace trimming globally.
- `:TopiaryDisable`: Disable whitespace trimming globally.
- `:TopiaryToggle`: Toggle whitespace trimming globally.
- `:TopiaryEnableBuffer`: Enable whitespace trimming for the current buffer.
- `:TopiaryDisableBuffer`: Disable whitespace trimming for the current buffer.
- `:TopiaryToggleBuffer`: Toggle whitespace trimming for the current buffer.

## Key mappings

vim-topiary defines the following [`<Plug>`][plug-mappings] mappings:

- `<Plug>TopiaryEnable`: Execute `:TopiaryEnable`.
- `<Plug>TopiaryDisable`: Execute `:TopiaryDisable`.
- `<Plug>TopiaryToggle`: Execute `:TopiaryToggle`.
- `<Plug>TopiaryEnableBuffer`: Execute `:TopiaryEnableBuffer`.
- `<Plug>TopiaryDisableBuffer`: Execute `:TopiaryDisableBuffer`.
- `<Plug>TopiaryToggleBuffer`: Execute `:TopiaryToggleBuffer`.

These are not mapped to key sequences, to allow you to choose those that best
fit your workflow and don't conflict with other plugins you use.

## Configuration

To disable vim-topiary for specific filetypes, set `g:topiary_ft_disabled` in
your vimrc file to a list of filetypes. By default vim-topiary is disabled in
diff buffers:

```viml
let g:topiary_ft_disabled = ['diff']
```

You may not want to collapse multiple blank lines in all filetypes. For example
in Python top-level function and class definitions should be surrounded with two
blank lines. In this case only three or more consecutive blank lines should be
collapsed, and to two blank lines rather than one. You can specify this
behaviour for specific filetypes by setting `g:topiary_ft_allow_two_blank_lines`
in your vimrc to a list of filetypes. By default this is enabled in Python
buffers:

```viml
let g:topiary_ft_allow_two_blank_lines = ['python']
```

## Copyright

Copyright © 2016-2019 [Scott Stevenson].

vim-topiary is distributed under the terms of the [ISC licence].

[dein.vim]: https://github.com/Shougo/dein.vim
[isc licence]: https://opensource.org/licenses/ISC
[minpac]: https://github.com/k-takata/minpac
[packages]: https://neovim.io/doc/user/repeat.html#packages
[packpath]: https://neovim.io/doc/user/options.html#'packpath'
[plug-mappings]: https://neovim.io/doc/user/map.html#%3CPlug%3E
[scott stevenson]: https://scott.stevenson.io
[vim-plug]: https://github.com/junegunn/vim-plug
[vim-topiary]: https://github.com/srstevenson/vim-topiary
[vundle]: https://github.com/VundleVim/Vundle.vim
