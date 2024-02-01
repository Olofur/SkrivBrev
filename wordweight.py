###############################################################################
##-##-##..........,....+...!..¤|'''''''''''''''|¤..!...+....,..........##-##-##
##-##-##..........{_.~*^*~.&*^%| wordweight.py |%^*&.~*^*~._}..........##-##-##
##-##-##..........~'^-....<'."?|,,,,,,,,,,,,,,,|?".'>....-^'~..........##-##-##
###############################################################################
# The script reads a text file, splits it into its words and then counts the
# occurance of each word. It also notes which of these words are adjectives.
#
# author:oh

#!/usr/bin/python

# 1. Read text file
# 2. Split words and count each words weight occurance
# 3. Find out which words are adjectives
# 4. Pick out the most common adjectives
# 5. Output them into word file to be read by OH_Cover.tex

import os
import re

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

import nltk
#nltk.download("averaged_perceptron_tagger")

def textclean(listofwords):
	for x in listofwords:
		for char in x:
			if char in ")(/\\'"	
				pass # remove char from x
	print(listofwords)


with open("wordtext.txt", encoding="utf-8") as f:
	text = f.read().lower()
	split_text = textclean(text.split())
	pos_tagged_text = nltk.pos_tag(split_text)  # JJ: adjective

	words = [w for w in set(split_text)]
	count = [0 for w in set(split_text)]
	pos_tag = dict(set(pos_tagged_text))
		
	for w in split_text:
		i = words.index(w)
		count[i] += 1
	wordcount = sorted(zip(count, words))

	freq_limit = 2	
	trimmed_wordcount = [w for w in wordcount if w[0] > freq_limit]
	
	trimmed_count, trimmed_words = zip(*trimmed_wordcount)

	trimmed_colors=[]
	for w in trimmed_words:
		match pos_tag[w]:
			case "JJ":
				trimmed_colors.append("tab:red")
			case _:
				trimmed_colors.append("tab:orange")

	plt.bar(trimmed_words, trimmed_count, color=trimmed_colors)
	plt.show()

