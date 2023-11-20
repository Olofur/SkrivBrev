################################################################################
##-##-##.........,....+...!..¤|''''''''''''''''''|¤..!...+....,.........##-##-##
##-##-##.........{_.~*^*~.&*^%| makeWordCloud.py |%^*&.~*^*~._}.........##-##-##
##-##-##.........~'^-....<'."?|,,,,,,,,,,,,,,,,,,|?".'>....-^'~.........##-##-##
################################################################################
# The program reads a .dat file containing words and corresponding positive 
# weights. It then constructs a .pdf containing a wordcloud of the weighted
# words with given fonts and font colors.
#
# author:oh

import os
import re
from PIL import Image

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from wordcloud import WordCloud

import random

# Transfer these to separate file
FILE_PATH="./wordcloud.dat"
SECTION_PATH="../Latex/Sections"
SAVE_PATH="../Latex/wordcloud.png"
FONT_PATH="./Fonts/arial.ttf"

PATTERN="cvsection"
COLOR_FUNC=lambda *args, **kwargs: (144,195,234)

df = pd.read_table(FILE_PATH, sep=",", usecols=["Property:"])

cnt = 1
for x in os.listdir(SECTION_PATH):
	# Check if x matches the pattern
	m = re.search(PATTERN, x)
	if m == None:	
		continue

	# All words are given the frequency 1
	freq = {}
	for item in df.values:
		freq.update({item[0,]: 1})

	# Shuffle dictionary to increase variation in wordclouds
	keys = list(freq.keys())
	random.shuffle(keys)

	# Generate wordcloud
	wordcloud = WordCloud(font_path=FONT_PATH, scale=1, min_font_size=6, 
			      max_words=50, background_color=None, 
			      color_func=COLOR_FUNC, mode="RGBA",
			      repeat=True).generate_from_frequencies(freq)

	SAVE_PATH="../Latex/Figures/wordcloud" + str(cnt) + ".png"
	wordcloud.to_file(SAVE_PATH)
	
	cnt += 1

# Show graphics
#plt.imshow(wordcloud)
#plt.axis("off")
#plt.show()
