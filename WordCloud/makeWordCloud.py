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

from os import path
from PIL import Image

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from wordcloud import WordCloud

FILE_PATH="wordcloud.dat"
SAVE_PATH="wordcloud.png"
FONT_PATH="./Fonts/arial.ttf"
COLOR_FUNC=lambda *args, **kwargs: (124,165,204)

df = pd.read_table(FILE_PATH, sep=",", usecols=["Property","Weight"])

freq = {}
for item in df.values:
	freq.update({item[0,]: item[1,]})

wordcloud = WordCloud(font_path=FONT_PATH, scale=1, min_font_size=6, 
		      max_words=50, background_color=None, 
		      color_func=COLOR_FUNC, mode="RGBA",
		      repeat=True).generate_from_frequencies(freq)

wordcloud.to_file(SAVE_PATH)

plt.imshow(wordcloud)
plt.axis("off")
plt.show()
