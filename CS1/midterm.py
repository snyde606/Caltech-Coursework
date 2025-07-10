# Name: Jacob Snyder
# Login: jjsnyder

# ---------------------------------------------------------------------- 
# Part 1: Pitfalls
# ---------------------------------------------------------------------- 

# Problem 1.1: 
# A multi-line string requires triple quotes. Therefore the docstring 
# at the beginning of the function is a syntax error.
# The parameter lst cannot be defined in the function definition as a string, 
# with quotes around it.
# In the first if statement, the = operator is being used in place of the == 
# operator. The = operator is for assignment, not comparisons.
# The while loop doesn't have a : at the end of the line to indicate the start
# of the loop.
# The else keyword is too far indented; it it supposed to be at the same 
# indentation as the if keyword preceding it.

# Problem 1.2:
# The function isPalindrome isn't returning anything, it's just printing the 
# result.
# The list reverse method doesn't return anything, so you can't use that to 
# make a comparison.
# In getPalindromesFromFile, a for loop doesn't iterate a file object across 
# lines. You'd have to use readline or readlines to get the lines and deal 
# with each one individually.
# In getPalindromesFromFile, the line ps += word will not append word to the 
# list ps, you need to use the .append() function: ps.append(word)
# In getPalindromesFromFile, the line palindromes.append(ps) doesn't add the 
# elements of ps to palindromes, it appends the entire list as a single element
# of palindromes. It should be palindromes += ps instead.

# Problem 1.3:
# Variable names are too short - they aren't helpful or descriptive
# Docstring is unhelpful as to purpose of the function
# There aren't any spaces before or after operators
# Non-consistent spacing following if and elif statements
# Greater than 80 character line

# ---------------------------------------------------------------------- 
# Part 2: Simple functions.
# ---------------------------------------------------------------------- 

import random, sys

#
# Problem 2.1
#

def draw_box(n):
    '''

    Return a string which, if printed, would draw a box on the terminal.  The
    exterior of the box should be made from '+' '-' and '|' characters.  The
    interior will have dimensions nxn and the characters will be one of the
    characters 'x', 'y', 'o', or '.', which will occur in order (even between
    lines).  There is a blank line before and after the box contents in the
    returned string.

    Examples:

    >>> print(draw_box(1))

    +-+
    |x|
    +-+

    >>> print(draw_box(2))

    +--+
    |xy|
    |o.|
    +--+

    >>> print(draw_box(3))

    +---+
    |xyo|
    |.xy|
    |o.x|
    +---+

    >>> print(draw_box(4))

    +----+
    |xyo.|
    |xyo.|
    |xyo.|
    |xyo.|
    +----+

    >>> print(draw_box(5))

    +-----+
    |xyo.x|
    |yo.xy|
    |o.xyo|
    |.xyo.|
    |xyo.x|
    +-----+

    >>> print(draw_box(10))

    +----------+
    |xyo.xyo.xy|
    |o.xyo.xyo.|
    |xyo.xyo.xy|
    |o.xyo.xyo.|
    |xyo.xyo.xy|
    |o.xyo.xyo.|
    |xyo.xyo.xy|
    |o.xyo.xyo.|
    |xyo.xyo.xy|
    |o.xyo.xyo.|
    +----------+

    Arguments:
      n -- a positive integer representing the side length of the box.

    Return value: none.
    '''

    assert n > 0
    choices = ['x', 'y', 'o', '.']
    finalString = '\n+'
    for a in range(n):
        finalString += '-'
    finalString += '+\n'
    for element in range(n * n):
        if element % n == 0:
            finalString += '|'
        finalString += choices[element % 4]
        if element % n == n - 1:
            finalString += '|\n'
    finalString += '+'
    for a in range(n):
        finalString += '-'
    finalString += '+\n'
    return finalString

def test_draw_box():
    print(draw_box(1))
    print(draw_box(2))
    print(draw_box(3))
    print(draw_box(4))
    print(draw_box(5))
    print(draw_box(10))

#
# Problem 2.2
#

def roll():
    '''
    Roll two six-sided dice and return their result.
    Arguments: none
    Return value: the result (an integer between 2 and 12).
    '''

    return random.randint(1, 6) + random.randint(1, 6)

def craps(verbose):
    '''
    Play one round of craps.

    Arguments: 
      verbose: print out the progress of the game while playing

    Return value: 
      True if the player wins, else False
    '''
    
    point = -1
    while True:
        rolled = roll()
        if verbose:
            print('You rolled {}.'.format(rolled))
        if point == -1:
            if rolled == 7 or rolled == 11:
                if verbose:
                    print('You win!')
                return True
            elif rolled == 2 or rolled == 3 or rolled == 12:
                if verbose:
                    print('You lose!')
                return False
            else:
                point = rolled
                if verbose:
                    print('Your point is: {}'.format(rolled))
        elif rolled == point:
            if verbose:
                print('You hit your point! You win!')
            return True
        elif rolled == 7:
            if verbose:
                print('You missed your point! You lose!')
            return False

def craps_edge(n):
    '''
    Estimate and return the house edge for craps.
    See https://wizardofodds.com/games/craps/appendix/1/ for an
    analytical derivation.  The result is 1 41/99 % or 1.4141... %.

    Argument: n: the number of rounds played (>= 0)
    Return value: the house edge in percent
    '''

    assert n >= 0
    wins = 0
    losses = 0
    for a in range(n):
        if craps(False):
            wins += 1
        else:
            losses += 1
    pwin = wins / n
    plose = losses / n
    return -(pwin + plose * (-1)) * 100

#
# Problem 2.3
#

def remove_indices(lst, indices):
    '''
    Return a copy of a list with the elements at the given indices removed.
    Valid negative indices (between -1 and -(length of list)+1) can be used.
    Out-of-bound indices are ignored.

    Argument:
      lst -- the input list
      indices -- a list of integers representing locations in the list to remove

    Return value:
      The new list.  The old list is not altered in any way.
    '''

    newList = []
    for a in lst:
        newList.append(a)
    count = 0
    for index in indices:
        if index < 0:
            index += len(lst)
        if index < 0 or index >= len(lst):
            return lst
        newList.pop(index - count)
        count += 1
    return newList

def get_bet_info(bets, cwins):
    '''
    Select the next bet information for a gambling system.

    Arguments:
      bets  -- the list of bets set by the gambling system
      cwins -- the consecutive wins (0, 1) previously

    Result:
      a two tuple containing:
      -- the bet amount;
      -- the indices of the 'bets' array where the bet amount was taken from
    '''
    assert len(bets) > 0
    for bet in bets:
        assert bet > 0
    assert cwins in [0, 1, 2]

    if cwins == 0:
        return (bets[0], [0])
    elif cwins == 1:
        if len(bets) >= 2:
            return (bets[0] + bets[-1], [0, -1])
        else:
            return (bets[0], [0])
    else:
        if len(bets) >= 3:
            return (bets[0] + bets[-1] + bets[1], [0, -1, 1])
        elif len(bets) >= 2:
            return (bets[0] + bets[1], [0, 1])
        else:
            return (bets[0], [0])

def make_one_bet(bankroll, bets, cwins, next_is_win):
    '''
    Play a gambling system for a single bet.

    Arguments:
      bankroll    -- the player's money
      bets        -- the list of bets set by the gambling system
      cwins       -- the consecutive wins previously
      next_is_win -- the next result of the game being played

    Result:
       A tuple consisting of:
       1) the updated bankroll
       2) the updated bets list
       3) the updated consecutive wins (max 2)
    '''

    assert bankroll >= 0
    assert len(bets) > 0
    for bet in bets:
        assert bet > 0
    assert cwins in [0, 1, 2]
    assert next_is_win in [True, False]

    binfo = get_bet_info(bets, cwins)
    bet = binfo[0]
    if bet > bankroll:
        return (bankroll, [], 0)
    if next_is_win:
        if cwins != 2:
            cwins += 1
        return (bankroll + bet, remove_indices(bets, binfo[1]), cwins)
    else:
        bets.append(bet)
        return (bankroll - bet, bets, 0)


#
# Test code supplied to students.
#

def random_bool():
    '''Return a random True/False value.'''
    return random.choice([True, False])

def one_round(bankroll, bets, verbose):
    '''
    Play a gambling system for a single round.
    Halt if either the desired amount of money is made, or if
    the player's bankroll hits zero.  Return the final bankroll.

    Arguments:
      bankroll    -- the player's money
      bets        -- the list of bets set by the gambling system
      verbose     -- if True, print out debugging information

    Return value: total profit (negative if there was a loss)
    '''

    assert bankroll >= 0
    assert len(bets) > 0
    for bet in bets:
        assert bet > 0

    orig_bankroll = bankroll
    cwins = 0

    if verbose:
        print('bankroll: {}, bets: {}, cwins: {}'.format(bankroll, bets,
            cwins))

    while True:
        # Test the gambling system on craps.
        #result = craps(False)
        # Alternatively, test it on a random uniformly-distributed boolean 
        # result (like flipping heads or tails).
        result = random_bool()
        if verbose:
            print('result: {}'.format(result))
        (bankroll, bets, cwins) = make_one_bet(bankroll, bets, cwins, result)
        if verbose:
            print('bankroll: {}, bets: {}, cwins: {}'.format(bankroll, bets,
                cwins))
        if bets == []:
            break
    profit = bankroll - orig_bankroll
    return profit

def run_gambling_system(verbose):
    '''
    Run multiple iterations of the gambling system,
    carrying on the bankroll from one iteration to the next.
    '''

    niters = 1000
    bankroll = 700
    orig_bankroll = bankroll
    for _ in range(niters):
        bets = [10, 10, 15]
        profit = one_round(bankroll, bets, verbose)
        if verbose:
            print('PROFIT: {}\n'.format(profit))
        bankroll += profit
        if verbose:
            print('BANKROLL: {}'.format(bankroll))
        if bankroll <= 0:
            break
    total_profit = bankroll - orig_bankroll
    if verbose:
        print('TOTAL PROFIT: {}'.format(total_profit))
    return total_profit

def run_gambling_system_multiple_times(n, verbose):
    '''
    Run multiple independent iterations of the gambling system,
    estimating and printing the average profit.
    '''

    total_profit = 0
    for _ in range(n):
        net_profit = run_gambling_system(verbose)
        if verbose:
            print(net_profit)
        total_profit += net_profit
    avg_profit = total_profit / n
    print('AVERAGE PROFIT: {}'.format(avg_profit))

# Example of use:
# run_gambling_system_multiple_times(10000, False)

# ---------------------------------------------------------------------- 
# Miniproject: 2048 game.
# ---------------------------------------------------------------------- 

#
# Problem 3.1
#

def make_board():
    '''
    Create a game board in its initial state.
    The board is a dictionary mapping (row, column) coordinates 
    (zero-indexed) to integers which are all powers of two (2, 4, ...).
    Exactly two locations are filled.
    Each contains either 2 or 4, with an 80% probability of it being 2.

    Arguments: none
    Return value: the board
    '''
    
    poss = []
    for i in range(4):
        for j in range(4):
            poss.append((i, j))
    random.shuffle(poss)
    board = {}
    if random.random() > 0.8:
        board[poss[0]] = 4
    else:
        board[poss[0]] = 2
    if random.random() > 0.8:
        board[poss[1]] = 4
    else:
        board[poss[1]] = 2    
    return board

#
# Problem 3.2
#

def get_row(board, row_n):
    '''
    Return a row of the board as a list of integers.
    Arguments:
      board -- the game board
      row_n -- the row number

    Return value: the row
    '''

    assert 0 <= row_n < 4
    row = []
    for a in range(4):
        if (row_n, a) not in board:
            row.append(0)
        else:
            row.append(board[(row_n, a)])
    return row

def get_column(board, col_n):
    '''
    Return a column of the board as a list of integers.
    Arguments:
      board -- the game board
      col_n -- the column number

    Return value: the column
    '''

    assert 0 <= col_n < 4
    col = []
    for a in range(4):
        if (a, col_n) not in board:
            col.append(0)
        else:
            col.append(board[(a, col_n)])
    return col

def put_row(board, row, row_n):
    '''
    Given a row as a list of integers, put the row values into the board.

    Arguments:
      board -- the game board
      row   -- the row (a list of integers)
      row_n -- the row number

    Return value: none; the board is updated in-place.
    '''

    assert 0 <= row_n < 4
    assert len(row) == 4
    for a in range(4):
        if row[a] != 0:
            board[(row_n, a)] = row[a]
        else:
            if (row_n, a) in board:
                del board[(row_n, a)]

def put_column(board, col, col_n):
    '''
    Given a column as a list of integers, put the column values into the board.

    Arguments:
      board -- the game board
      col   -- the column (a list of integers)
      col_n -- the column number

    Return value: none; the board is updated in-place.
    '''

    assert 0 <= col_n < 4
    assert len(col) == 4
    for a in range(4):
        if col[a] != 0:
            board[(a, col_n)] = col[a]
        else:
            if (a, col_n) in board:
                del board[(a, col_n)]

#
# Problem 3.3
#

def make_move_on_list(numbers):
    '''
    Make a move given a list of 4 numbers using the rules of the
    2048 game.

    Argument: numbers -- a list of 4 numbers
    Return value: the list after moving the numbers to the left.
    '''

    assert len(numbers) == 4
    final = []
    count = 0
    for a in numbers:
        if a != 0:
            final.append(a)
            count += 1
    for b in range(4 - count):
        final.append(0)
    if final[0] == final[1]:
        final[0] = final[0] * 2
        final[1] = final[2]
        final[2] = final[3]
        final[3] = 0
    if final[1] == final[2]:
        final[1] = final[1] * 2
        final[2] = final[3]
        final[3] = 0
    if final[2] == final[3]:
        final[2] = final[2] * 2
        final[3] = 0
    return final

#
# Problem 3.4
#

def make_move(board, cmd):
    '''
    Make a move on a board given a movement command.
    Movement commands include:

      'w' -- move numbers upward
      's' -- move numbers downward
      'a' -- move numbers to the left
      'd' -- move numbers to the right

    Arguments:
      board  -- the game board
      cmd    -- the command letter

    Return value: none; the board is updated in-place.
    '''

    assert cmd in ['w', 'a', 's', 'd']
    if cmd == 'w':
        for col in range(4):
            target = get_column(board, col)
            target = make_move_on_list(target)
            put_column(board, target, col)
    elif cmd == 'a':
        for row in range(4):
            target = get_row(board, row)
            target = make_move_on_list(target)
            put_row(board, target, row)       
    elif cmd == 's':
        for col in range(4):
            target = get_column(board, col)
            target.reverse()
            target = make_move_on_list(target)
            target.reverse()
            put_column(board, target, col)
    elif cmd == 'd':
        for row in range(4):
            target = get_row(board, row)
            target.reverse()
            target = make_move_on_list(target)
            target.reverse()
            put_row(board, target, row)

#
# Problem 3.5
#

def game_over(board):
    '''
    Determine whether the game is over or not by testing if there are any 
    available moves and whether there are any empty spaces.
    
    Arguments:
      board  -- the game board
      
    Return value: boolean indicating whether the game is over or not
    '''
    
    for cmd in ['w', 'a', 's', 'd']:
        test = board.copy()
        make_move(test, cmd)
        if test != board:
            return False
    if len(board) == 16:
        return True
    else:
        return False

#
# Problem 3.6
#

def update(board, cmd):
    '''
    Make a move on a board given a movement command.  If the board
    has changed, then add a new number (2 or 4, 90% probability it's 
    a 2) on a randomly-chosen empty square on the board.  
    If there are no empty squares, the game is over, so return False.

    Arguments:
      board  -- the game board
      cmd    -- the command letter

    Return value: none; the board is updated in-place.
    '''

    original = board.copy()
    make_move(board, cmd)
    if board != original and len(board) != 16:
        newLoc = (random.randint(0, 3), random.randint(0, 3))
        while(newLoc in board):
            newLoc = (random.randint(0, 3), random.randint(0, 3))
        decision = random.random()
        if decision > 0.9:
            board[newLoc] = 4
        else:
            board[newLoc] = 2

### Supplied to students:

def display(board):
    '''
    Display the board on the terminal in a human-readable form.

    Arguments:
      board  -- the game board

    Return value: none
    '''

    s1 = '+------+------+------+------+'
    s2 = '| {:^4s} | {:^4s} | {:^4s} | {:^4s} |'

    print(s1)
    for row in range(4):
        c0 = str(board.get((row, 0), ''))
        c1 = str(board.get((row, 1), ''))
        c2 = str(board.get((row, 2), ''))
        c3 = str(board.get((row, 3), ''))
        print(s2.format(c0, c1, c2, c3))
        print(s1)

def play_game():
    '''
    Play a game interactively.  Stop when the board is completely full
    and no moves can be made.

    Arguments: none
    Return value: none
    '''

    b = make_board()
    display(b)
    while True:
        move = input('Enter move: ')
        if move not in ['w', 'a', 's', 'd', 'q']:
            print("Invalid move!  Only 'w', 'a', 's', 'd' or 'q' allowed.")
            print('Try again.')
            continue
        if move == 'q':  # quit
            return
        update(b, move)
        if not b:
            print('Game over!')
            break
        display(b)

