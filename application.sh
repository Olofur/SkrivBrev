###############################################################################
##-##-##..........,....+...!..¤|''''''''''''''''|¤..!...+....,.........##-##-##
##-##-##..........{_.~*^*~.&*^%| application.sh |%^*&.~*^*~._}.........##-##-##
##-##-##..........~'^-....<'."?|,,,,,,,,,,,,,,,,|?".'>....-^'~.........##-##-##
###############################################################################
# Collection of bash functions used by main program.
#
# author:oh
 
#!/bin/bash

# Usage:
# $1 file path to search in
# $2 separator character
# $3 variable name to look for in file

# Looks for value match in variable file with variable name given

function getseparatedvalue () {
	ARGCOUNT=3    # Expected number of parameters

	FILE_ERR=100  # The given file does not exist
	PARAM_ERR=101 # Incorrect number of parameters given
	VAR_ERR=102   # The variable was not found in the file

	if [ $# -lt $ARGCOUNT ] ; then
		printf "Expected $ARGCOUNT arguments, got $#.\n"
		return $PARAM_ERR
	fi
	if [ ! -f $1 ] ; then
		printf "The given file can not be found.\n"
		return $FILE_ERR
	fi
	
	separator=$2
	while IFS= read -r line ; do
		variable=${line%$separator*}
		value=${line#*$separator}
		
		if [ $variable == $3 ] ; then
			# Spaces are translated to underscores for file 
			# name compatibility
			match=$(echo $value | sed -Er "s/ /_/")
		fi
	done < $1
	
	if [ -z $match ] ; then
		printf "The given variable could not be found.\n"
		return $VAR_ERR
	else
		echo $match
	fi 
}

# Usage:
# $1 directory path to search in 
# $2 pattern to search for

# Finds number of files that matches pattern in given directory

function getsections () {
	ARGCOUNT=2

	FILE_ERR=100  # The given file does not exist
	PARAM_ERR=101 # Incorrect number of parameters given
	
	if [ $# -lt $ARGCOUNT ] ; then
		printf "Expected $ARGCOUNT arguments, got $#.\n"
		return $PARAM_ERR
	fi
	if [ ! -d $1 ] ; then
		printf "The given directory can not be found.\n"
		return $FILE_ERR
	fi
	
	return $(ls -1 $1 | grep -E "$2" | wc -l)
}

# Usage:
# $1 full file path to split into its components

# Sets the values of $fpath, $fname, $fsuffix to the given components, 
# or to the empty string "" if they can not be found

function splitfullpath () {
	ARGCOUNT=1

	f=$1

	# Extract file path as text before rightmost /
	if [[ $f == ${f%/*} ]] ; then
		fpath=""
	else
		fpath=${f%/*}		
	fi

	# Extract file name as text after rightmost / and after the suffix
	fname=${f##*/}		
	fname=${fname%.*}	
	
	# Extract file suffix as text after rightmost .
	if [[ ${f##*.} == *'/'* ]] ; then
		fsuffix=""
	elif [ ${f##*.} == ${f##*/.} ] ; then
		fsuffix=""
	else 
		fsuffix=${f##*.}
	fi
	}

