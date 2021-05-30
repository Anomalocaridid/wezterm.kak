# wezterm.kak
Provides basic [WezTerm](https://github.com/wez/wezterm) integration for Kakoune. Modeled after Kakoune's default windowing modules.

# Installation
With plug.kak add the following to your kakrc:

    plug Anomalocaridid/wezterm.kak demand "wezterm" %{
        hook -once global KakBegin .* wezterm-integration-enable
    }

Otherwise, add it to your autoload folder or source it manually, making sure to add `require-module wezterm` to your kakrc.

# Features
Currently, only splitting the window into panes is supported. I was unable to find a way to use WezTerm\`s command-line i`nterface to focus a given client or open a command in a new tab. Since WezTerm is fairly new, that functionality may not even be currently supported yet.

## Commands
* `wezterm-integration-enable` - aliases `wezterm-terminal-vertical` to the  `terminal` command and `wezterm-terminal-window` to the `terminal-window` command
* `wezterm-terminal-vertical` - splits the current window vertically and runs a given program
* `wezterm-terminal-horizontal` - splits the current window horizontally and runs a given program
* `wezterm-terminal-window` - opens a new instance of WezTerm and runs the given command in it

# TODO
* Add the command `wezterm-focus` that focuses a given client and alias it to `focus` in `wezterm-integration-enable`
* Add a command `wezterm-terminal-tab` to run a program in a new tab and alias it to `terminal-tab` in `wezterm-integration-enable`
