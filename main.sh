#!/bin/bash

# -*- coding: utf-8 -*-
# author:oh

# Compiles .tex file into .pdf format interactively

# To run program, type
#
# >>> ./main.sh
#
# into terminal

BASEDIR=$0
BASEPATH=${BASEDIR%/*}

# Read config variables
source "$BASEPATH/config"

# Import bash functions
source "$BASEPATH/application.sh" 

# Run terminal dialogue program
. "$BASEPATH/dialogue.sh"

# For all files in $file[@] (later implemented as an array)
for f in "${file[@]}" ; do
	splitfullpath "$f"	# Sets values for $fpath, $fname, $fsuffix 

	for i in "${!altoutsnip[@]}"; do
		# All filenames are split by '_' and stored as elements in the 
		# SNIPPETS array
		IFS="_" ; read -a SNIPPETS <<< "$fname" ; IFS=" "	
		for j in "${SNIPPETS[@]}"; do
			if [ "$j" == "${altoutsnip[i]}" ] ; then
				outpath=${altoutsnippath[$i]}	
				break
			fi
		done
	done

	if [ "$CONTINUOUS" == 1 ] ; then
		latexmk -f -cd -pvc -pvctimeout -new-viewer -view=pdf -pdf -silent -outdir="../$outpath" "$f"
	else
		latexmk -f -cd -pv -new-viewer -view=pdf -pdf -silent -outdir="../$outpath" "$f"
	fi

	for item in "$outpath"/* ; do
		if [[ $item == *".pdf" || $item != *"$fname"* || -d $item ]] ; 
		then
			continue
		fi

		if [ "$CLEAN" == 1 ] ; then
			rm "$item"
		else
			mv -t "$auxpath" "$item" 
		fi
	done
	
	if [ "$COPY" == 1 ] ; then
		echo "Done! Enter name of copy:"
		read -r copyname

		if [ -z "$copyname" ] ; then
			urcompany=$(getseparatedvalue "$variablepath" "=" "urcompany")
			position=$(getseparatedvalue "$variablepath" "=" "position")
	
			copyname=$urcompany'_'$position
		fi

		cp "$outpath/$fname.pdf" "$copypath/$fname.pdf"
		mv "$copypath/$fname.pdf" "$copypath/$copyname.pdf"	
	fi
done
