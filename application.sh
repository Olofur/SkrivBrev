################################################################################
##-##-##..........,....+...!..¤|''''''''''''''''|¤..!...+....,..........##-##-##
##-##-##..........{_.~*^*~.&*^%| application.sh |%^*&.~*^*~._}..........##-##-##
##-##-##..........~'^-....<'."?|,,,,,,,,,,,,,,,,|?".'>....-^'~..........##-##-##
################################################################################
#
#
# author:oh
 
#!/bin/bash

# Usage:
# $1 file path to search in
# $2 separator character
# $3 variable name to look for in file

ARGCOUNT=3    # Expected number of parameters

FILE_ERR=100  # The given file does not exist
PARAM_ERR=101 # Incorrect number of parameters given
VAR_ERR=102   # The variable was not found in the file

function getseparatedvalue () {
	if [ $# -lt 3 ] ; then
		printf "Expected 3 arguments, got $#."
		return $PARAM_ERR
	fi
	if [ ! -f $1 ] ; then
		printf "The given file can not be found."
		return $FILE_ERR
	fi
	
	separator=$2
	while IFS= read -r line ; do
		variable=${line%"$separator"*}
		value=${line#*"$separator"}
		
		if [ $variable = $3 ] ; then
			# Spaces are translated to underscores for file 
			# name compatibility
			match=$(echo $value | sed -Er "s/ /_/")
		fi
	done < $1
	
	if [ -z $match ] ; then
		printf "The given variable could not be found."
		return $VAR_ERR
	else
		echo $match
	fi 
}

