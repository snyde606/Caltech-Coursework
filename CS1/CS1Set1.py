# Ex C.1.1:  9 - 3 --> 6
# Ex C.1.2:  8 * 2.5 --> 20.0
# Ex C.1.3:  9 / 2 --> 4.5
# Ex C.1.4:  9 / -2 --> -4.5
# Ex C.1.5:  9 % 2 --> 1
# Ex C.1.6:  9 % -2 --> -1
# Ex C.1.7:  -9 % 2 --> 1
# Ex C.1.8:  9 / -2.0 --> -4.5
# Ex C.1.9:  4 + 3 * 5 --> 19
# Ex C.1.10:  (4 + 3) * 5 --> 35

# Ex C.2.1:  x = 100 --> 100
# Ex C.2.2:  x = x + 10 --> 110
# Ex C.2.3:  x += 20 --> 130
# Ex C.2.4:  x = x - 40 --> 90
# Ex C.2.5:  x -= 50 --> 40
# Ex C.2.6:  x *= 3 --> 120
# Ex C.2.7:  x /= 5 --> 24.0
# Ex C.2.8:  x %= 3 --> 0.0

# Ex C.3: Python evaluates (x - x), or (3 - 3), which returns 0. Python then
# adds this value to x. So x = x + 0. So the value of x does not change, 
# it remains 3.

# Ex C.4.1: 1j + 2.4j --> 3.4j
# Ex C.4.2: 4j * 4j --> (-16+0j)
# Ex C.4.3: (1+2j) / (3+4j) --> (0.44 + 0.08j)
# Ex C.4.4: (1+2j) * (1+2j) --> (-3+4j)
# Ex C.4.5: 1+2j * 1+2j --> (1+4j)
# Ex C.4.6: Python calculates these differently because of operator 
# precedence. In C.4.4, the parentheses cause the multiplication to apply to 
# the entire term, whereas in C.4.5 the lack of parentheses cause the 
# multiplication to apply only to 2j and 1.

# Ex C.5.1: cmath.sin(-1.0+2.0j) --> (-3.165778513216168+1.959601041421606j)
# Ex C.5.2: cmath.log(-1.0+3.4j) --> (1.2652585805200263+1.856847768512215j)
# Ex C.5.3: cmath.exp(-cmath.pi * 1.0j) --> (-1-1.2246467991473532e-16j)
# Ex C.5.4: There are likely methods in math and cmath that have the same 
# names. This means that using (from math import *) and (from cmath import *) 
# can cause unintentional use of a function if you aren't careful. Using 
# (import math) and (import cmath) forces the user to specify exactly which 
# method they're looking to use.

# Ex C.6.1: "foo" + 'bar' --> 'foobar'
# Ex C.6.2: "foo" 'bar' --> 'foobar'
# Ex C.6.3: a = 'foo' b = "bar" a + b --> 'foobar'
# Ex C.6.4: a = 'foo' b = "bar" a b --> error (see next 3 lines)
# Traceback (most recent call last):
#   Python Shell, prompt 6, line 1
# invalid syntax: <string>, line 1, pos 3

# Ex C.7: 'A\nB\nC'

# Ex C.8: '-' * 80

# Ex C.9: 'first line\nsecond line\nthird line'

# Ex C.10:
x = 3
y = 12.5
print('The rabbit is {}.'.format(x))
print('The rabbit is {} years old.'.format(x))
print('{} is average.'.format(y))
print('{1} * {0}'.format(x,y))
print('{1} * {0} is {2}.'.format(x,y,x*y))

# Ex C.11:
num = float(input("Enter a number: "))
print(num)

# Ex C.12:
def quadratic(a,b,c,x):
    return a*x*x + b*x + c
    
# Ex C.13:
def GC_content(dna):
    '''This function computes the proportion of G and C bases in the input 
    DNA string.\nThe input should be a DNA string containing only 'A', 'C', 
    'G', and 'T' characters.\nThe output is a float representing the proportion 
    of C and G bases.'''
    length = float(len(dna))
    cs = float(dna.count('C'))
    gs = float(dna.count('G'))
    return (cs+gs)/length