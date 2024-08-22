#!/bin/bash

# -*- coding: utf-8 -*-
# author:oh

# Dialogue program for compiling latex files

source ./application.sh

# Read config variables
source ./config

wholelatexpath="$latexpath/*"

options=()
for f in $wholelatexpath ; do
	suffix=${f##*.}
	if [ "$suffix" == "tex" ] ; then
		options+=("${f##*/}")
	fi
done

echo "Select file to process by entering their space separated integers."

file=()
select _ in "${options[@]}" ; do
	for reply in "${REPLY[@]}" ; do
		# Test if reply is contained in options
		file+=("${options[reply - 1]}")		
	done
	[[ "${options}" ]] && break
done
echo "$file"
file="$latexpath/$file"

splitfullpath "$file"	# Sets values for $fpath, $fname, $fsuffix 

if [[ "$fname" == *"_CV" ]] ; then
	# Modify variables (y/n) ?
	while :; do
		echo "Modify variables? (y/n)"
		read -r answer
		case $answer in
			y|Y) python3 "../python/other/var_change.py" ; break ;;
			n|N) break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done

	# Remake wordclouds (y/n) ?
	while :; do	
		echo "Remake wordclouds? (y/n)"
		read -r answer
		case $answer in
			y|Y) python3 "../python/other/make_word_cloud.py"
			     break ;;
			n|N) break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done
elif [[ "$fname" == *"_Cover" ]] ; then
	# Modify variables (y/n) ?
	while :; do
		echo "Modify variables? (y/n)"
		read -r answer
		case $answer in
			y|Y) python3 "../python/other/var_change.py" ; break ;;
			n|N) break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done
	
	# Reweigh textwords (y/n) ?
	while :; do
		echo "Reweight words from text? (y/n)"
		read -r answer
		case $answer in
			y|Y) python3 "../python/other/word_weight.py" ; break ;;
			n|N) break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done
fi

# Continuous run (y/n) ? Recommended with only one file chosen
if [ ${#file[@]} -eq 1 ] ; then
	while :; do
		echo "Continuous run? (y/n)"
		read -r answer
		case $answer in
			y|Y) CONTINUOUS=1 ; break ;;
			n|N) CONTINUOUS=0 ; break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done
fi

# Save auxillary files (y/n) ?
while :; do
	echo "Save auxillary files? (y/n)"
	read -r answer
	case $answer in
		y|Y) CLEAN=0 ; break ;;
		n|N) CLEAN=1 ; break ;;
		*) echo "Please choose a valid answer." ;;
	esac
done

# Save copy (y/n) ?
if [[ "$fname" == *"_Cover" ]] ; then
	COPY=1
else
	while :; do
		echo "Save copy? (y/n)"
		read -r answer
		case $answer in
			y|Y) COPY=1 ; break ;;
			n|N) COPY=0 ; break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done
fi

export file
export CONTINUOUS
export CLEAN
export COPY

