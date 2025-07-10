# Ex A.1
def list_reverse(lst):
    '''Returns a reversed version of the input list without modifying the actual
    list variable.'''
    temp = lst[:]
    temp.reverse()
    return temp

# Ex A.2
def list_reverse2(lst):
    '''Returns a reversed version of the input list without modifying the actual
    list variable.'''    
    temp = lst[:]
    for a in range(len(lst)-1,-1,-1):
        temp[len(lst)-1-a] = lst[a]
    return temp

# Ex A.3
def file_info(fname):
    '''Returns a tuple containing the number of lines, number of words, and
    number of characters in the input file, in that order.'''
    file = open(fname, 'r')
    lines = 0
    words = 0
    chars = 0
    while True:
        line = file.readline()
        if line == '':
            break
        lines += 1
        words += len(line.split())
        chars += len(line)
    file.close()
    return (lines, words, chars)

# Ex A.4
def file_info2(fname):
    '''Returns a dictionary containing the number of lines, number of words, and
    number of characters in the input file, with the keys 'lines', 'words', 
    and 'characters' respectively.'''    
    tup = file_info(fname)
    return {'lines' : tup[0], 'words' : tup[1], 'characters' : tup[2]}

# Ex A.5
def longest_line(fname):
    '''Returns the length of the longest line and the the longest line in the
     input file, as a tuple.'''
    file = open(fname, 'r')
    big = 0
    words = ''
    while True:
        line = file.readline()
        if line == '':
            break
        if len(line) > big:
            big = len(line)
            words = line
    file.close()
    return (big, words)

# Ex A.6
def sort_words(suckSteelSwine):
    '''Returns a sorted list of words based on the input string'''
    ayyLmaoGoodVarName = suckSteelSwine.split(' ')
    ayyLmaoGoodVarName.sort()
    return ayyLmaoGoodVarName

# Ex A.7: 11011010 = 2 + 2^3 + 2^4 + 2^6 + 2^7 = 218
# The largest possible 8 digit binary number is 2^0 + 2^1 + 2^2 + 2^3 + 2^4 + 
# 2^5 + 2^6 + 2^7 = 255

# Ex A.8
def binaryToDecimal(helpimabug):
    '''Converts the input list of 1s and 0s representing a binary number into
     a decimal number, and returns the decimal number.'''
    count = len(helpimabug)-1
    total = 0
    for a in helpimabug:
        total += a * 2 ** count
        count -= 1
    return total

# Ex A.9
def decimalToBinary(goodCodingPractices):
    '''Converts the decimal input to a binary number, represented by a list of
    0s and 1s.'''
    if goodCodingPractices == 0:
        return [0]
    elif goodCodingPractices == 1:
        return[1]
    finesse = []
    check = 1
    while True:
        if check * 2 > goodCodingPractices:
            break
        check *= 2
    finesse.append(1)
    goodCodingPractices -= check
    check /= 2
    while check > 0:
        if check <= goodCodingPractices:
            finesse.append(1)
            goodCodingPractices -= check
        else:
            finesse.append(0)
        if check == 1:
            check = 0
        check /= 2
    return finesse

# Ex B.1
# Mistake 1: spaces after commas
# Mistake 2: spaces between operators
# Mistake 3: not descriptive enough function name
def sumOfCubes(a, b, c):
    return a * a * a + b * b * b + c * c * c

# Ex B.2
# Mistake 1: arguments are too wordy
# Mistake 2: space after #
# Mistake 3: name of function
# Mistake 4: clarity of comment
def sumOfCubes(a, b, c, d):
    # returns the sum of cubes of arguments a, b, c, and d
    return a * a * a + b * b * b + c * c * c + d * d * d

# Ex B.3
# Mistake 1: appropriate white space
# Mistake 2: inconsistent indentation
def sum_of_squares(x, y):
    return x * x + y * y

def sum_of_three_cubes(x, y, z):
    return x * x * x + y * y * y + z * z * z