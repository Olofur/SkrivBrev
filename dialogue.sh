###############################################################################
##-##-##...........,....+...!..¤|'''''''''''''|¤..!...+....,...........##-##-##
##-##-##...........{_.~*^*~.&*^%| dialogue.sh |%^*&.~*^*~._}...........##-##-##
##-##-##...........~'^-....<'."?|,,,,,,,,,,,,,|?".'>....-^'~...........##-##-##
###############################################################################
# your
# text
# here
#
# author:oh
 
#!/bin/bash

source application.sh

# Read config variables
. ./config

wholelatexpath="$latexpath/*"

options=()
for f in $wholelatexpath ; do
	suffix=${f##*.}
	if [ $suffix == "tex" ] ; then
		options+=(${f})
	fi
done

echo "Select which files to process by entering their space separated integers."

file=()
select opt in "${options[@]}" ; do
	for reply in $REPLY ; do
		# First test if reply is contained in options
		file+=(${options[reply - 1]})		
	done
	[[ $options ]] && break
done

if [ $fname == "CV" ] ; then
	# Modify variables (y/n) ?
	while [ 1 == 1 ] ; do
		echo "Modify variables? (y/n)"
		read answer
		case $answer in
			y|Y) python3 varChange.py ; break ;;
			n|N) break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done

	# Remake wordclouds (y/n) ?
	while [ 1 == 1 ] ; do	
		echo "Remake wordclouds? (y/n)"
		read answer
		case $answer in
			y|Y) WordCloud/makeWordCloud.py ; break ;;
			n|N) break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done
elif [ $fname == "Cover" ] ; then
	# Reweigh textwords (y/n) ?
	while [ 1 == 1 ] ; do
		echo "Reweigh words from text? (y/n)"
		read answer
		case $answer in
			y|Y) python3 wordweight.py ; break ;;
			n|N) break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done
fi

# Continuous run (y/n) ? Recommended with only one file chosen
if [ ${#file[@]} -eq 1 ] ; then
	while [[ 1 == 1 ]] ; do
		echo "Continuous run? (y/n)"
		read answer
		case $answer in
			y|Y) CONTINUOUS=1 ; break ;;
			n|N) CONTINUOUS=0 ; break ;;
			*) echo "Please choose a valid answer." ;;
		esac
	done
fi

# Save auxillary files (y/n) ?
while [[ 1 == 1 ]] ; do
	echo "Save auxillary files? (y/n)"
	read answer
	case $answer in
		y|Y) CLEAN=0 ; break ;;
		n|N) CLEAN=1 ; break ;;
		*) echo "Please choose a valid answer." ;;
	esac
done

# Save copy (y/n) ?
while [[ 1 == 1 ]] ; do
	echo "Save copy? (y/n)"
	read answer
	case $answer in
		y|Y) COPY=1 ; 
		     echo "Enter copy name:"
		     read copyname
		     break ;;
		n|N) COPY=0 ; break ;;
		*) echo "Please choose a valid answer." ;;
	esac
done

