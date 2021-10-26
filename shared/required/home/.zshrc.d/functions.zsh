search_env_for {
	local search_regex="$1";
	search_regex=${search_regex:-".*"};
	cat <(ls -A ~/bin 2> /dev/null) <(ls -A /usr/local/bin 2> /dev/null) \
    <(alias 2> /dev/null) <(env 2> /dev/null) <(print -l ${(ok)functions} 2> /dev/null) \
    <(setopt 2> /dev/null) | egrep -i "$search_regex";
}

show_cmds_like {
	local pattern="$1";
	[[ -z "$pattern" ]] && { echo "Must specify a command pattern!" >&2 return 1 }
	local alias=`alias 2> /dev/null| egrep -i "$pattern"`;
	[[ -z "$alias" ]] || { echo "$alias" }
	local fn_names=($(print -l ${(ok)functions} | egrep -i "$pattern" | gsed -E "s/declare -f (.*)/\1/" | xargs));
	for fn_name in ${fn_names[@]} do
		echo "$(which $fn_name)";
	done
}

