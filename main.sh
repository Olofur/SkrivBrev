#!/bin/bash

# -*- coding: utf-8 -*-
# author:oh

# Main latex compiling program

# Import bash functions
# shellcheck source=application.sh
source ./application.sh 

# Read config variables
# shellcheck source=config
source ./config

# Run terminal dialogue program
# shellcheck source=dialogue.sh
source ./dialogue.sh

${file:?}
${fname:?}
${altoutcond:?}
${altoutpath:?}
${auxpath:?}
${variablepath:?}
${copypath:?}

# For all files in $file[@]
for f in "${file[@]}" ; do
	splitfullpath "$f"	# Sets values for $fpath, $fname, $fsuffix 

	for i in "${!altoutcond[@]}"; do
		if [ "$fname" == "${altoutcond[$i]}" ] ; then
			outpath=${altoutpath[$i]}	
		fi
	done

	if [ "$CONTINUOUS" == 1 ] ; then
		latexmk -f -pvc -pvctimeout -new-viewer -view=pdf -pdf -silent -outdir="$outpath" "$f"
	else
		latexmk -f -pv -new-viewer -view=pdf -pdf -silent -outdir="$outpath" "$f"
	fi

	wholeoutpath="$outpath/*"
	for item in $wholeoutpath ; do
		if [[ $item != *'.pdf' && $item == *$fname* ]] ; then
			if [ "$CLEAN" == 1 ] ; then
				rm "$item"
			else
				mv -t "$auxpath" "$item" 
			fi
		fi	
	done

	# If no copy name is given pick out two variables from varconfig.dat 
	# to name the copy
	if [ -z "$copyname" ] ; then
		urname=$(getseparatedvalue "$variablepath" "=" "urname")
		ursurname=$(getseparatedvalue "$variablepath" "=" "ursurname")
	
		copyname=$urname'_'$ursurname'_copy'
	fi

	cp "$outpath/$fname.pdf" "$copypath/$fname.pdf"
	mv "$copypath/$fname.pdf" "$copypath/$copyname.pdf"	
	
done
