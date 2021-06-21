# wezterm.kak
# Provides basic WezTerm integration for Kakoune
# Inspired by Kakoune's included windowing modules

# ensure that we're running on WezTerm
remove-hooks global wezterm-detection
hook -group wezterm-detection global ClientCreate '.*' %{
	trigger-user-hook "TERM_PROGRAM=%val{client_env_TERM_PROGRAM}"
}


define-command wezterm-terminal-vertical -params 1.. -shell-completion -docstring '
	wezterm-terminal-vertical <program> [<arguments>]: create a new terminal as a WezTerm pane
	The current pane is split into two, top and bottom
	The program passed as argument will be executed in the new terminal' \
%{
	wezterm cli split-pane --cwd %val{client_env_PWD} -- %arg{@}
}

define-command wezterm-terminal-horizontal -params 1.. -shell-completion -docstring '
	wezterm-terminal-horizontal <program> [<arguments>]: create a new terminal as a WezTerm pane
	The current pane is split into two, left and right
	The program passed as argument will be executed in the new terminal' \
%{
	wezterm cli split-pane --horizontal --cwd %val{client_env_PWD} -- %arg{@}
}

define-command wezterm-terminal-window -params 1.. -shell-completion -docstring '
	wezterm-terminal-window <program> [<arguments>]: create a new terminal as a WezTerm window
	The program passed as argument will be executed in the new terminal' \
%{
	wezterm start --cwd %val{client_env_PWD} -- %arg{@}
}

define-command wezterm-terminal-tab -params 1.. -shell-completion -docstring '
	wezterm-terminal-tab <program> [<arguments>]: create a new terminal as a WezTerm tab
	The program passed as argument will be executed in the new terminal' \
%{
	wezterm cli spawn --cwd %val{client_env_PWD} -- %arg{@}
}

define-command wezterm-terminal-popup -params 1.. -shell-completion -docstring '
	wezterm-terminal-popup <program> [<arguments>]: create a new terminal as a WezTerm popup
	The program passed as argument will be executed in the new terminal' \
%{
	wezterm cli spawn --cwd %val{client_env_PWD} -- %arg{@}
}

# TODO
# define-command wezterm-focus -params ..1 -client-completion -docstring '
# 	wezterm-focus [<client>]: focus the given client
# 	If no client is passed then the current one is used' \
# %{}

define-command -hidden wezterm -params .. -docstring '
	wezterm [<flags>] [<options>] [<subcommand>]: run WezTerm' \
%{
	nop %sh{
		wezterm "$@" < /dev/null > /dev/null 2>&1 &
	}
}

define-command wezterm-integration-enable -docstring '
	wezterm-integration-enable: enable WezTerm integration' \
%{
	remove-hooks global wezterm-integration
	hook -group wezterm-integration global User 'TERM_PROGRAM=WezTerm' %{
		alias global terminal wezterm-terminal-vertical
		alias global terminal-window wezterm-terminal-window
		alias global terminal-tab wezterm-terminal-tab
		alias global popup wezterm-terminal-popup
		# alias global focus wezterm-focus
	}
}

define-command wezterm-integration-disable -docstring '
	wezterm-integration-disable: disable WezTerm integration' \
%{
	remove-hooks global wezterm-integration
}
