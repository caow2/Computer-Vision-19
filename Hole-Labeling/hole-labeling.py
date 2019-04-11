import numpy as np
import pandas as pd

# Wen Cao
# Implementation of Hole Labeling Algorithm by utilizing Union Find

## UNION FIND ##
def find(x, parents):
    i = x
    while parents[i] != -1:
        i = parents[i]
    return i

def union(x, y, parents):
    j = find(x, parents)
    k = find(y, parents)

    if j != k:
    	parents[j] = k
    return parents


## LABELING ##
# Get the neighbor labels for this row and column
def neighbors(img, row, col):
    nbset = set()
    maxRow, maxCol = np.shape(img)

    # Index checking
    lRow = (0 if row == 0 else row - 1)
    lCol = (0 if col == 0 else col - 1)
    uRow = (row if row == maxRow - 1 else row + 1)
    uCol = (col if col == maxCol - 1 else col + 1)

    for r in range(lRow, uRow + 1):
        for c in range(lCol, uCol + 1):
            if img[r,c] > 0:
                nbset.add(img[r, c])
    return nbset

# Two pass approach for connected component labeling
def labeling(img):
    # Initialization
    label = 1
    maxLabel = 30
    maxRow, maxCol = np.shape(img)
    parents = [-1 for num in range(maxLabel)]
    outImg = np.zeros((maxRow, maxCol), dtype=np.int32) # Ignore 0 as a label

    # First pass
    for row in range(0, maxRow):
        for col in range(0, maxCol):
            if img[row, col] == 1:
                nbs = neighbors(outImg, row, col)
                if len(nbs) == 0:
                    M = label
                    label += 1
                else:
                    M = min(nbs)
                outImg[row, col] = M

                for x in nbs:
                    if x != M:
                        parents = union(x, M, parents)

    # Second pass - Label according to a consecutive order: 1, 2, ...
    labels = {} # dictionary to map the parent label to a new label in consecutive order
    label = 1
    for row in range(0, maxRow):
        for col in range(0, maxCol):
            if img[row, col] == 1:
                parent = find(outImg[row, col], parents)
                if parent not in labels: # new parent label - assign it the next available label in consecutive order
                    labels[parent] = label
                    label += 1
                outImg[row,col] = labels[parent]

    return outImg

## TESTING FUNCTIONS ##
# Multi Line String to it's Matrix representation and vice versa
def stringToMatrix(string):
	m = map(list, string.splitlines())
	return np.array(list(m), dtype=np.int32)

def matrixToString(matrix):
	maxRow, maxCol = np.shape(matrix)
	result = ''
	for row in range(0, maxRow):
		line = ''
		for col in range(0, maxCol):
			line += str(matrix[row, col]).ljust(3) #pretty format string
		line += '\n'
		result += line
	return result

# Test multi line strings
def test(str):
	matrix = stringToMatrix(str)
	labeled = labeling(matrix)
	return matrixToString(labeled)


## TESTS ##
print(test("""00000000000000000000001111000000
01001111111111111000000001000000
01010000000000001001111111111110
01010011111101001001000000000010
01010100000101001001011111111010
01011001010101001001010000001010
01000001011101001001010111001010
01001001000001001001010111001010
01001000111111001001010001001010
01001011100001001111010001001010
01001100001111000000011111001010
01000000000001000000000000001010
01111111111111111111111111111010
00000000000000000000000000000010
00111111111111111111111111000100
00000000000000000000000000111000
00000111111111111111111110001000
00011111100000000000000001101000
00100000000000000000000110101000
00100000001111111111110001101000
00100001110000000000001100001000
00100010000000111110000011001000
00100100111111111111110011001000
00100100000000000000000110001000
00100010000000000000000100011000
00100001111111111111111000111000
00110000000000000000000011111000
00111100000000000000011111111001
00011111111111111111111111110011
00000000000000000000000000000111
00000000000000000001111111111111"""))

print(test("""00000000000
01010101001
01110111001
00100010000
00111110011
00001000011
11101111100"""))

print(test("""010101010101010
101010101010001
010101010101010
101010101010001
010101010101010"""))

print(test("""010101010101
000000000000
101010101010
000000000000
010101010101
000000000000
101010101010"""))

