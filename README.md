# omz-plugin-psgrep

## Hello, world!

This is a plugin for [oh-my-zsh](https://ohmyz.sh/).  Its purpose is to hide
its own process from the results of a `ps aux | grep PATTERNS`.

The function returns the status given by grep: a 0 if a match was found, a 1
otherwise.

## Syntax

`psgrep PATTERNS`

`PATTERNS` will be passed on to grep, enclosing the first character in square brackets.

## How it works

When a user normally issues, for example, `ps grep | grep zsh`, the output
always contains this process.  Example:

```
user@somehost ~ % ps aux | grep zsh
user     2348  0.0  0.0  12328  5652 pts/9    Ss   Apr13   0:02 -zsh
user    76086  0.0  0.0   7620   812 pts/0    S+   20:23   0:00 grep --color=auto zsh
user    85126  0.0  0.0  11152  4396 ?        Ss   Oct16   0:00 -zsh
user@somehost ~ %
```

The `psgrep` plugin will hide this output by using an interesting method.  When
expanded it will look like this:

```
user@somehost ~ % ps aux | grep '[z]sh'
user     2348  0.0  0.0  12328  5652 pts/9    Ss   Apr13   0:02 -zsh
user    85126  0.0  0.0  11152  4396 ?        Ss   Oct16   0:00 -zsh
user@somehost
```

Here, when `ps aux` is executed, grep will expand the given pattern to look for
`zsh`, while the grep command itself shows in the result of `ps` as `[z]sh`.
Obviously this is not a match, so, the process is effectively hidden.

This is very useful when you want to check if a process even exists at all
(e.g. `psgrep foobar || echo "foobar is not running."`)

## Installation

To install this plugin:
1.  Install Zsh and oh-my-zsh;

2.  Clone this repo to the `custom` directory of your OMZ installation.
    Usually this will be located at `$HOME/.oh-my-zsh/custom/plugins`.  Here's
    a quick way to take care of this:

    ```
    rm -rf $HOME/.oh-my-zsh/custom/plugins/psgrep
    git clone git@github.com:voidzero/omz-plugin-psgrep.git $HOME/.oh-my-zsh/custom/plugins/psgrep
    ```
3.  Add `psgrep` to your plugins list in ~/.zshrc.  A nifty trick might be to
    harness the power of Zsh in the following way, which will load all of the
    plugins in your custom directory without having to manually type them all
    out:

    ```
    plugins=(git ${:-$HOME/.oh-my-zsh/custom/plugins/*(NF:t)})
    ```

    Or, list them by hand, boring but effective:

    ```
    plugins=(git psgrep)
    ```
4.  Open a new shell to be able to use `psgrep`. Enjoy!

## Future

Maybe it would be nice to have psgrep pass on stated options to grep, for
example `psgrep -v` to pass on `-v` to grep in order to reverse-grep, or
`psgrep -P` to enable perl-regexp. Right now psgrep does not do any of these
things, it only handles `-h, --help` and `-u, --usage`.
