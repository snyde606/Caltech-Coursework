import random

def make_random_code():
    '''Generates a random 4 character code composed of R, G, B, Y, O, or W'''
    code = ""
    for a in range(4):
        code += random.choice(["R", "G", "B", "Y", "O", "W"])
    return code

def count_exact_matches(str1, str2):
    '''Counts the number of exact matches between two strings, considering both
    character and order.'''
    count = 0
    for a in range(4):
        if str1[a] ==  str2[a]:
            count += 1
    return count

def count_letter_matches(str1, str2):
    '''Counts the number of character matches between two strings.'''
    count = 0
    strl1 = list(str1)
    strl2 = list(str2)
    for a in strl1:
        if a in strl2:
            count += 1
            strl2.remove(a)
    return count

def compare_codes(code, guess):
    '''Returns a string of length 4 depending on how similar the two input 
    strings are. A b for every exact match and a w for every not exact match.'''
    bpegs = count_exact_matches(code, guess)
    wpegs = count_letter_matches(code, guess) - bpegs
    npegs = 4 - bpegs - wpegs
    result = ""
    for a in range(bpegs):
        result += "b"
    for a in range(wpegs):
        result += "w"
    for a in range(npegs):
        result += "-"
    return result
    
def run_game():
    '''Runs an instance of the mastermind game.'''
    print("New game.")
    turn = 1
    result = ""
    code = make_random_code()
    while result != "bbbb":
        guess = input("Enter your guess: ")
        result = compare_codes(code, guess)
        print("Result: {}".format(result))
        if result == "bbbb":
            print("Congratulations! You cracked the code in {} moves!".format(\
                str(turn)))
        else:
            turn += 1