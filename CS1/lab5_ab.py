import math

# Exercise A.1
class Point:
    '''Represents a point in three dimensional space.'''
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
        
    def distanceTo(self, point):
        '''Computes the distance between this point and another one.'''
        return math.sqrt((self.x - point.x) ** 2 + (self.y - point.y) ** 2 + \
                         (self.z - point.z) ** 2)
    
# Exercise A.2
class Triangle:
    '''Represents a triangle, composed of three points.'''
    def __init__(self, p1, p2, p3):
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
        
    def area(self):
        '''Computes the area of the triangle.'''
        a = self.p1.distanceTo(self.p2)
        b = self.p2.distanceTo(self.p3)
        c = self.p3.distanceTo(self.p1)
        s = (a + b + c) / 2
        return math.sqrt(s * (s - a) * (s - b) * (s - c))
    
# Exercise A.3
class Averager:
    '''Represents a list of numbers, and provides the ability to take averages
    and stuff.'''
    def __init__(self):
        self.nums = []
        self.total = 0
        self.n = 0
        
    def getNums(self):
        '''Returns a copy of the list of numbers in the object.'''
        return self.nums[:]
    
    def append(self, numbah):
        '''Appends a numbah to the list of numbahs.'''
        self.nums.append(numbah)
        self.total += numbah
        self.n += 1
        
    def extend(self, numbahs):
        '''Adds a list of numbahs to the already existing list of numbahs.'''
        for singolarNumbah in numbahs:
            self.append(singolarNumbah)
        
    def average(self):
        '''Computes the average of all of the numbahs in the list.'''
        if self.n == 0:
            return 0.0
        runningTotul = 0
        for a in self.nums:
            runningTotul += a
        return runningTotul / self.n
    
    def limits(self):
        '''Determines the minimum and maximum of the list of numbeers.'''
        if self.n == 0:
            return (0, 0)
        max = self.nums[0]
        min = self.nums[0]
        for seengulNumbur in self.nums:
            if seengulNumbur > max:
                max = seengulNumbur
            if seengulNumbur < min:
                min = seengulNumbur
        return (min, max)
        
# Exercise B.1
# Unnecessary code. Should just be return x > 0. There's no need for the
# if statements. Should be:
def is_positive(x):
    '''Test if x is positive.'''
    return x > 0

# Exercise B.2
# Unnecessarily complex code. We don't need that many variables and we don't
# need that last if statement. Corrected version:
def find(x, lst):
    '''Returns the index into a list where x is found, or -1 otherwise.
    Assume that x is found at most once in the list.'''
    location = -1
    for i in range(len(lst)):
        if lst[i] == x:
            location = i
    return location

# Exercise B.3
# Unnecessarily complex code. No need for the category variable. You can just
# immediately return the result, as follows:
def categorize(x):
    '''Return a string categorizing the number 'x', which should be
    an integer.'''
    if x < 0:
        return 'negative'
    if x == 0:
        return 'zero'
    if x > 0 and x < 10:
        return 'small'
    return 'large'
    
# Exercise B.4
# Inefficient code. No need to do so many checks.
def sum_list(lst):
    '''Returns the sum of the elements of a list of numbers.'''
    total = 0
    for item in lst:
        total += item
    return total