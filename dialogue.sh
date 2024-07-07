#!/bin/bash

# -*- coding: utf-8 -*-
# author:oh

# Dialogue program for compiling latex files

source ./application.sh

# Read config variables
source ./config

${latexpath:?}
${auxpath:?}
${fname:?}

wholelatexpath="$latexpath/*"

options=()
for f in $wholelatexpath ; do
	suffix=${f##*.}
	if [ "$suffix" == "tex" ] ; then
		options+=("${f}")
	fi
done

echo "Select which files to process by entering their space separated integers."

file=()
select _ in "${options[@]}" ; do
	for reply in "${REPLY[@]}" ; do
		# First test if reply is contained in options
		file+=("${options[reply - 1]}")		
	done
	"${file[@]}" && break
done

if [ "$fname" == "CV" ] ; then
	# Modify variables (y/n) ?
	while :; do
		echo "Modify variables? (y/n)"
		read -r answer
		case $answer in
			y|Y) python3 varChange.py ; break ;;
			n|N) break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done

	# Remake wordclouds (y/n) ?
	while :; do	
		echo "Remake wordclouds? (y/n)"
		read -r answer
		case $answer in
			y|Y) WordCloud/makeWordCloud.py ; break ;;
			n|N) break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done
elif [ "$fname" == "Cover" ] ; then
	# Reweigh textwords (y/n) ?
	while :; do
		echo "Reweigh words from text? (y/n)"
		read -r answer
		case $answer in
			y|Y) python3 wordweight.py ; break ;;
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
while :; do
	echo "Save copy? (y/n)"
	read -r answer
	case $answer in
		y|Y) COPY=1 ; 
		     echo "Enter copy name:"
		     # read -r copyname
		     break ;;
		n|N) COPY=0 ; break ;;
		*) echo "Please choose a valid answer." ;;
	esac
done

export file
export CONTINUOUS
export CLEAN
export COPY

