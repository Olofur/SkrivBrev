#!/usr/bin/python

# -*- coding_ utf-8 -*-
# author:oh

'Change variable in config file'

# Idea : let path be given
#        expand to custom line separator ( having another approach where
# each write protected line has a special symbol is hard because it has
# to be easily translated to LaTeX ) or maybe just have separate config files

import re

path = "/Config/varconfig.dat"

newfile = []

write_protect = True
with open(path) as fp:
	for count, line in enumerate(fp):

		f = re.findall(r'([^=]+)=([^=]*)', line)
		for x in f:
			if write_protect is False:
				value = input("Enter value for " + x[0] + ": ")

				if value.strip() == "":
					newline = line.strip()
				else:
					newline = x[0] + "=" + value
				newfile.append(newline)
			else:
				newfile.append(line.strip())

		# All lines above the % are write protected
		if line.strip() == '%':
			newfile.append(line.strip())
			write_protect = False

# Open file in writemode and replace with newfile
nf = open(path, 'w')
for count, line in enumerate(newfile):
    nf.write(line + '\n')
