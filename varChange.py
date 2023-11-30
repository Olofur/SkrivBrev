###############################################################################
##-##-##..........,....+...!..¤|'''''''''''''''|¤..!...+....,..........##-##-##
##-##-##..........{_.~*^*~.&*^%| writeCover.py |%^*&.~*^*~._}..........##-##-##
##-##-##..........~'^-....<'."?|,,,,,,,,,,,,,,,|?".'>....-^'~..........##-##-##
###############################################################################
# The program lets the user edit the lines of a given config file through the 
# command line,  to replace values given to the variables. The program uses 
# a line symbol to distinguish between write protected variables and
# regular variables that are to be edited.
#
# Idea : let path be given
#        expand to custom line separator ( having another approach where
# each write protected line has a special symbol is hard because it has
# to be easily translated to LaTeX ) or maybe just have separate config files
#
# author:oh

#!/usr/bin/python

import re

path = "/Config/varconfig.dat"

newfile = []

writeProtect=True
with open(path) as fp:
	for count, line in enumerate(fp):	
		
		f = re.findall(r'([^=]+)=([^=]*)', line)
		for x in f:
			if writeProtect == False: 
				value=input("Enter value for " + x[0] + ": ")
				
				if value.strip() == "":
					newline=line.strip()
				else:
					newline = x[0] + "=" + value
				newfile.append(newline)
			else:
				newfile.append(line.strip())
	
		# All lines above the % are write protected	
		if line.strip() == '%':
			newfile.append(line.strip())
			writeProtect=False

# Open file in writemode and replace with newfile
nf = open(path, 'w')
for count, line in enumerate(newfile):
	nf.write(line + '\n')	

