################################################################################
##-##-##.........,....+...!..¤|'''''''''''''''''|¤..!...+....,..........##-##-##
##-##-##.........{_.~*^*~.&*^%| LaTeXcompile.sh |%^*&.~*^*~._}..........##-##-##
##-##-##.........~'^-....<'."?|,,,,,,,,,,,,,,,,,|?".'>....-^'~..........##-##-##
################################################################################
# (L)atex (C)ompiling program
# Compiles a given .tex file into .pdf format while allowing concurrent 
# editing. Sends outputs to different directories determined through the 
# config file.
#
# author:oh

#!/bin/bash

# Import bash functions
source application.sh 

# Read config variables
. "./config"

# Rework so filepath can add Latex/ pathlet when necessary
filename=$1
name=${filename%.*}
namespec=${name#*_}

# Rework to accomodate all special cases given as specpath in config
case $namespec in 
	$spec1) 
	outpath=$specpath1
	;;
	$spec2)
	outpath=$specpath2
	;;
esac

filepath="Latex/$filename"

latexmk -pvc -view=pdf -pdf -silent -outdir=$outpath $filepath

mv -t $auxpath "$outpath/$name.log" "$outpath/$name.fls" "$outpath/$name.aux" "$outpath/$name.fdb_latexmk"

if [ -f "$outpath/$name.out" ] ; then
	mv -t $auxpath "$outpath/$name.out"
fi

# Picks out two variables from varconfig.dat to name the copy
if [ $namespec = $spec2 ] ; then
	urname=$(getseparatedvalue "$variablepath" "=" "urname")
	ursurname=$(getseparatedvalue "$variablepath" "=" "ursurname")

	copyname=$urname'_'$ursurname'_copy'
	cp "$outpath/$name.pdf" "$copypath/$name.pdf"
	mv "$copypath/$name.pdf" "$copypath/$copyname.pdf"	
fi
