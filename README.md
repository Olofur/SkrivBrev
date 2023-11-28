Repository for compiling .tex files using a bash terminal, with additional 
functionality.

To get going run the main shell script,
	. main.sh	
and choose which .tex file to compile, followed by other options.

All paths required to run the programs is given in the file 
	config

All variables required to compile the latex scripts are given in the file
	variables.dat
in the Latex directory

To be done:

Implement wordweighing functionality to extract specific adjectives(?) from 
larger texts  

Make main.sh do all things on command:
    change variables,
    add, remove or edit words in wordcloud.dat,
    generate wordclouds,
    compile all or only specific tex files from main Latex directddory

	Improve the varChange.py file to improve management of variables

	Make sure config contains all relevant paths and add lists

	Alot of functionality to be added to tex files, some being 

	  Improve ability to read variables and data from separate files

	  ? automation of cleanFigure ? 
