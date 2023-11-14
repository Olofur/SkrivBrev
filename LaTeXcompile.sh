################################################################################
##-##-##.........,....+...!..¤|'''''''''''''''''|¤..!...+....,..........##-##-##
##-##-##.........{_.~*^*~.&*^%| LaTeXcompile.sh |%^*&.~*^*~._}..........##-##-##
##-##-##.........~'^-....<'."?|,,,,,,,,,,,,,,,,,|?".'>....-^'~..........##-##-##
################################################################################
# Compiles a given .tex file into .pdf format while allowing concurrent 
# editing. Sends outputs to different predetermined directories.
#
# author:oh

#!/bin/bash

. "./Config/pathconfig.txt"

# Rework so filepath can add Latex/ when necessary
filename=$1
name=${filename%.*}
namespec=${name#*_}

filepath="Latex/$filename"

# Rework to accomodate all special cases given in pathconfig
case $namespec in 
	$spec1) 
	opath=$outpath1
	;;
	$spec2)
	opath=$outpath2
	;;
	*) 
	opath=$outpath1
	;;
esac
apath=$auxpath
conpath=$configpath

latexmk -pvc -view=pdf -pdf -silent -outdir=$opath $filepath	

mv -t $apath "$opath/$name.log" "$opath/$name.fls" "$opath/$name.aux" "$opath/$name.fdb_latexmk"

if [ -f "$opath/$name.out" ] ; then
	mv -t $apath "$opath/$name.out"
fi

if [ $namespec = $spec2 ] ; then
	cpath=$copypath
	while IFS= read -r line ; do
		var=${line%=*}
		val=${line#*=}
		if [ $var = "urname" ] ; then
			urname=$(echo $val | sed -Er "s/ /_/")
		elif [ $var = "ursurname" ] ; then
			ursurname=$(echo $val | sed -Er "s/ /_/")
		fi
	done < "$conpath/varconfig.dat"
	
	copyname=$urname'_'$ursurname'_copy'
	cp "$opath/$name.pdf" $cpath
	mv "$cpath/$name.pdf" "$cpath/$copyname.pdf"	
fi
