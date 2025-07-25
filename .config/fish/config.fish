if status is-interactive
    # Commands to run in interactive sessions can go here
end

# No helpful startup message

set fish_greeting

## !! substitution
#

function __history_previous_command
    switch (commandline -t)
	case "!"
		commandline -t $history[1]; commandline -f repaint
	case "*"	
		commandline -i !
	end
end

function __history_previous_command_arguments
	switch (commandline -t)
	case "!"
		commandline -t ""
		commandline -f history-token-search-backward
	case "*"
		commandline -i '$'
	end
end	

function _plugin-bang-bang_key_bindings --on-variable fish_key_bindings
    bind --erase !
    bind --erase '$'
    switch "$fish_key_bindings"
    case 'fish_default_key_bindings'
        bind --mode default ! __history_previous_command
        bind --mode default '$' __history_previous_command_arguments
    case 'fish_vi_key_bindings' 'fish_hybrid_key_bindings'
        bind --mode insert ! __history_previous_command
        bind --mode insert '$' __history_previous_command_arguments
    end
end

_plugin-bang-bang_key_bindings

## History
#

function history
	builtin history --show-time='%F %T '
end

alias ls='exa --color=always --group-directories-first --icons'
