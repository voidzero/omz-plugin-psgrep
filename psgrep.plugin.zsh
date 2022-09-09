# vim: ft=zsh ts=4 sw=4 sts=4 noet

psgrep() {
	integer ret
	typeset args
	(( ${#@} )) && args="$*" || ret=1 args="--help"

	case $args in
		-h|--help|-u|--usage)
			echo "psgrep: search for processes, excluding grep from the output" >&2
			echo "Usage: psgrep [search string]" >&2
			return $ret
			;;
	esac

	ps aux | grep "[${args[1]}]${args[2,-1]}"
	return $?
}

