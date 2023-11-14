################################################################################
##-##-##..........,....+...!..¤|''''''''''''''''|¤..!...+....,..........##-##-##
##-##-##..........{_.~*^*~.&*^%| cleanFigure.py |%^*&.~*^*~._}..........##-##-##
##-##-##..........~'^-....<'."?|,,,,,,,,,,,,,,,,|?".'>....-^'~..........##-##-##
################################################################################
# Takes a .pdf file and makes white and sufficiently near-white pixels values 
# transparent. The program then returns the cleaned image in the .png format.
#
# It is convenient to combine with a scanning software, for example through
# google drive, to get written text that can easily be inserted into latex 
# documents with minimal graphical artifacts.
#
# author:oh

from pdf2image import convert_from_path

image = convert_from_path('./Figures/signature.pdf', fmt='ppm', transparent=False)

img = image[0].convert('RGBA')

Data = img.getdata()

newData = []
for item in Data:
    if item[0] >= 240 and item[1] >= 240 and item[2] >= 240:
        newData.append((255,255,255,0)) # Transparent pixel
    else:
        newData.append(item)

img.putdata(newData)
img.save('./Figures/signature.png', 'PNG')
