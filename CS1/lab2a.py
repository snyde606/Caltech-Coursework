import random

# Ex B.1:
def complement(dna):
    result = ""
    for a in dna:
        if a == "A":
            result += "T"
        elif a == "T":
            result += "A"
        elif a == "C":
            result += "G"
        elif a == "G":
            result += "C"
    return result

# Ex B.2:
def list_complement(dna):
    count = 0
    for a in dna:
        if a == "A":
            dna[count] = "T"
        elif a == "T":
            dna[count] = "A"
        elif a == "C":
            dna[count] = "G"
        elif a == "G":
            dna[count] = "C"
        count += 1
        
# Ex B.3
def product(nums):
    total = 1
    for num in nums:
        total *= num
    return total

# Ex B.4
def factorial(trivial):
    return product(range(1, trivial+1))

# Ex B.5
def dice(m,n):
    total = 0
    for a in range(n):
        total += random.choice(range(1, m+1))
    return total

# Ex B.6
def remove_all(li, num):
    while li.count(num) != 0:
        li.remove(num)
        
# Ex B.7
def remove_all2(li, num):
    counter = li.count(num)
    for a in range(counter):
        li.remove(num)
        
def remove_all3(li, num):
    while num in li:
        li.remove(num)

# Ex B.8
def any_in(list1, list2):
    for a in list1:
        if a in list2:
            return True
    return False

# Ex C.1.a: The = operator is supposed to be used for assignment, not for
# comparisons. It should be a == 0 instead of a = 0

# Ex C.1.b: The parameter needs to be in the form of a variable, not a literal
# character. Replace 's' with s

# Ex C.1.c: In the return statement, we need to append to a string variable,
# not a literal string. Replace 's' with s

# Ex C.1.d: When adding an element to a list, it needs to be added in the form
# of a list, not a string. Change the line to lst = lst + ['bam']

# Ex C.1.e: The reverse function doesn't return another list, it only
# modifies the target variable. Fix by changing that line to simply
# lst.reverse() and then lst.append(0) on a line and return lst on the final
# line.

# Ex C.1.f: When using list.append(letters), the entire list of letters will
# be appended as a single list element. Also, list is a keyword and thus can't
# be used as a variable name. Use lst instead. Fix the other problem by adding
# letters instead, as follows: lst += letters

# Ex C.2: The assignment of c does not update upon updating a. After setting
# c to 30 in line 3, there is no subsequent reassignment, so the value cannot
# change.

# Ex C.3: add_and_double_1 returns the result, whereas add_and_double_2 simply
# prints it. So add_and_double_1 provides the information needed to complete
# the operation, but add_and_double_2 doesn't.

# Ex C.4: No parameters are set up fo sum_of_squares_2 so you cannot input 2
# and 3 in that manner. The difference between passing a value as an argument to
# a function and getting it interactively with input is that with arguments,
# they're always given upon calling the function. Getting the values
# interactively requires inputs after the function call.

# Ex C.5: Strings are immutable. You can't change a string like that. You'd
# need to create a new string.

# Ex C.6: item is a copy of the original value in lst. You aren't changing
# the actual values in lst (with the exception of list elements, because
# they're pointers).