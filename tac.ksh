#!/usr/bin/env ksh93
# tac.ksh - Print a file, from the finish to the start.
# 
# Copyright (c) 2024 Luiz Antônio Rangel
#
# SPDX-Licence-Identifier: WTFPL

progname="$0"

function main {
	# I do not think this is the best way.
	load_file="${@:--}"
	typeset -a fbuf
	integer n m 

	if (( $# > 1 )); then
		print_help
	fi

	for ((n=0;; n++)); do
		if read line; then
			fbuf[$n]="$line"
		else
			break
		fi
	done < <(cat "$load_file")

	for ((m=${#fbuf[@]}; m>=0; m--)); do
		printf '%s\n' "${fbuf[$m]}"
	done
	unset load_file fbuf n m

	return 0
}

function print_help {
	printf 'usage: %s file ...\n' "$progname" 1>&2
	exit 1
}

main "$@"
