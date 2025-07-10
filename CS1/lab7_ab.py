# Exercise A.1.1
def union(s1, s2):
    fin = set()
    for e in s1:
        fin.add(e)
    for e in s2:
        fin.add(e)
    return fin

# Exercise A.1.2
def intersection(s1, s2):
    fin = set()
    for e in s1:
        if e in s2:
            fin.add(e)
    return fin

# Exercise A.2
def mySum(*args):
    total = 0
    for i in args:
        if type(i) != int:
            raise TypeError('Arguments can only be integers.')
        if i <= 0:
            raise ValueError('Arguments must be positive.')
        total += i
    return total

# Exercise A.3
def myNewSum(*args):
    total = 0
    if len(args) == 1 and type(args[0]) == list:
        for a in args[0]:
            if type(a) != int:
                raise TypeError('Arguments can only be integers.')
            if a <= 0:
                raise ValueError('Arguments must be positive.')            
            total += a
        return total
    for i in args:
        if type(i) != int:
            raise TypeError('Arguments can only be integers.')
        if i <= 0:
            raise ValueError('Arguments must be positive.')
        total += i
    return total

def myOpReduce(lint, **kwargs):
    allowed = ['+', '*', 'max']
    if len(kwargs) == 0:
        raise ValueError('no keyword argument')
    if len(kwargs) > 1:
        raise ValueError('too many keyword arguments')
    elif 'op' not in kwargs:
        raise ValueError('invalid keyword argument')
    elif type(kwargs['op']) != str:
        raise TypeError('value for keyword argument must be a string')
    elif kwargs['op'] not in allowed:
        raise ValueError('value for keyword argument must be + * or max')
    elif kwargs['op'] == '+':
        return myNewSum(lint)
    elif kwargs['op'] == '*':
        total = 1
        for a in lint:
            total *= a
        return total
    elif kwargs['op'] == 'max':
        amax = 0
        if len(lint) > 0:
            amax = lint[0]
        for a in lint:
            if a > amax:
                amax = a
        return amax
    
# Exercise B.1
# The try/except statement is redundant, because that is what would happen
# in the case of an exception anyways. Therefore take out the try/except:
import sys
def sum_of_key_values(dict, key1, key2):
    '''Return the sum of the values in the dictionary stored at key1 and key2.'''
    return dict[key1] + dict[key2]

# Exercise B.2
# No need to put 'file=sys.stderr'; the message will be printed to the same
# place without that specification.
def sum_of_key_values(dict, key1, key2):
    '''Return the sum of the values in the dictionary stored at key1 and key2.'''
    try:
        return dict[key1] + dict[key2]
    except KeyError:   # raised if a key isn't in a dictionary
        print('key not found!')
        
# Exercise B.3
# No need for a try/except statement if you're just going to raise a KeyError
# again. Just take out the try/except:
def sum_of_key_values(dict, key1, key2):
    '''Return the sum of the values in the dictionary stored at key1 and key2.'''
    return dict[key1] + dict[key2]

# Exercise B.4
# e cannot be raised because it's not an error object. It should be printed:
def sum_of_key_values(dict, key1, key2):
    '''Return the sum of the values in the dictionary stored at key1 and key2.'''
    try:
        val1 = dict[key1]
    except KeyError as e:   
        print(e)

    try:
        val2 = dict[key2]
    except KeyError as e:
        print(e)

    return val1 + val2

# Exercise B.5
# The print statement will never be run because an exception is being raised
# right before it. The print statement should go before, or it should be
# integrated into the raised exception:
import sys

def fib(n):
    '''Return the nth fibonacci number.'''
    if n < 0:
        raise ValueError('n must be >= 0')
    elif n < 2:
        return n  # base cases: fib(0) = 0, fib(1) = 1.
    else:
        return fib(n-1) + fib(n-2)
    
# Exercise B.6
# Same as problem 5: the print statement should be included in the raised
# exception:
import sys

def fib(n):
    '''Return the nth fibonacci number.'''
    if n < 0:
        raise ValueError('n must be >= 0')
    elif n < 2:
        return n  # base cases: fib(0) = 0, fib(1) = 1.
    else:
        return fib(n-1) + fib(n-2)
    
# Exercise B.7
# It's a ValueError, not a TypeError:
from math import exp

def exp_x_over_x(x):
    '''
    Return the value of e**x / x, for x > 0.0 and
    e = 2.71828... (base of natural logarithms).
    '''
    if x <= 0.0:
        raise ValueError('x must be > 0.0')
    return (exp(x) / x)

# Exercise B.8
# Exception isn't specific enough; use TypeError or ValueError:
from math import exp

def exp_x_over_x(x):
    '''
    Return the value of e**x / x, for x > 0.0 and
    e = 2.71828... (base of natural logarithms).
    '''
    if type(x) is not float:
        raise TypeError('x must be a float')
    elif x <= 0.0:
        raise ValueError('x must be > 0.0')
    return (exp(x) / x)