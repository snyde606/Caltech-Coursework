#
# CS 1 Final exam, 2017
#

'''
This module has functions and classes that augment the base FreeCell
object to produce a more full-featured FreeCell game.
'''

import random
from Card import *
from FreeCell import *

# Supplied to students:
def max_cards_to_move(nc, nf):
    '''
    Return the maximum number of cards that can be moved as a single sequence
    if the game has 'nc' empty cascades and 'nf' empty freecells.
    If the target cascade is empty then subtract 1 from 'nc'.

    Arguments:
      nc -- number of empty non-target cascades
      nf -- number of empty freecells

    Return value:
      the maximum number of cards that can be moved to the target
    '''

    assert type(nc) is int
    assert 0 <= nc <= 8
    assert type(nf) is int
    assert 0 <= nf <= 4

    return 1 + nf + sum(range(1, nc + 1))

def longest_movable_sequence(cards):
    '''
    Compute the length of the longest sequence of cards at the end of a 
    list of cards that can be moved in a single move.  Cards in the sequence 
    must be in strict descending order and alternate colors.

    Arguments:
      cards -- a list of cards

    Return value:
      the number of cards at the end of the list forming the longest
      sequence
    '''

    assert type(cards) is list
    for c in cards:
        assert isinstance(c, Card)

    if cards == []:
        return 0

    count = 1
    while count < len(cards) and cards[-count].goes_below(cards[-count - 1]):
        count += 1
    return count

def ok_to_automove(card, foundation):
    '''
    Return True if a card can be automoved to a foundation.

    Arguments:
      card       -- a Card object
      foundation -- a foundation dictionary (mapping suits to ranks)

    Return value:
      True if the card can be automoved, else False
    '''

    assert isinstance(card, Card)
    assert type(foundation) is dict
    
    if card.rank == 'A':
        return True
    
    if card.suit not in foundation or \
       not card.goes_above(Card(foundation[card.suit], card.suit)):
        return False
        
    if card.rank == 2:
        return True
    
    if card.suit == 'S' or card.suit == 'C':
        if 'D' in foundation and 'H' in foundation and \
           all_ranks.index(foundation['D']) >= \
           all_ranks.index(card.rank) - 1 and \
           all_ranks.index(foundation['H']) >= \
           all_ranks.index(card.rank) - 1:
            return True
        else:
            return False
    else:
        if 'S' in foundation and 'C' in foundation and \
           all_ranks.index(foundation['S']) >= \
           all_ranks.index(card.rank) - 1 and \
           all_ranks.index(foundation['C']) >= \
           all_ranks.index(card.rank) - 1:
            return True
        else:
            return False        


class FreeCellFull(FreeCell):
    '''
    FreeCellFull is an enhanced version of FreeCell with extra useful
    features.
    '''

    def multi_move_cascade_to_cascade(self, m, n, p):
        '''
        Move a sequence of 'p' cards from cascade 'm' to cascade 'n'.
        Cascade 'm' must have at least 'p' cards.  The last 'p'
        cards of cascade 'm' must be in descending rank order and
        alternating colors.

        If the move can't be made, raise an IllegalMove exception.

        Arguments:
          m, n -- cascade indices (integers between 0 and 7)
          p    -- an integer >= 0

        Return value: none
        '''
        
        if m < 0 or m > 7 or n < 0 or n > 7:
            raise IllegalMove('bad inputs')
        
        if p == 0:
            return        

        if len(self.cascade[m]) < p:
            raise IllegalMove('this cascade doesnt have enough cards in it')
        
        if p > longest_movable_sequence(self.cascade[m]):
            raise IllegalMove('thats not a valid sequence of cards')
        
        if self.cascade[n] != [] and \
           not self.cascade[m][-p].goes_below(self.cascade[n][-1]):
            raise IllegalMove('cant be moved there')
        
        emptyCasks = 0
        emptyCells = 0
        for cask in self.cascade:
            if cask == []:
                emptyCasks += 1
        for cell in self.freecell:
            if cell == None:
                emptyCells += 1
                
        if self.cascade[n] == []:
            emptyCasks -= 1
            
        if p > max_cards_to_move(emptyCasks, emptyCells):
            raise IllegalMove('there arent enough free spaces')
        
        self.cascade[n] += self.cascade[m][-p:]
        self.cascade[m] = self.cascade[m][:-p]
        

    def automove_to_foundation(self, verbose=True):
        '''
        Make as many moves as possible from the cascades/freecells to the
        foundations.

        Argument:
          verbose -- if True, print a message when each card is automoved

        Return value: none
        '''

        searching = True
        while searching:
            searching = False
            for index in range(8):
                if self.cascade[index] != [] and \
                   ok_to_automove(self.cascade[index][-1], self.foundation):
                    searching = True
                    if verbose:
                        print('Moving ' + str(self.cascade[index][-1].rank) + \
                              str(self.cascade[index][-1].suit) + \
                              ' to foundation')
                    self.foundation[self.cascade[index][-1].suit] = \
                        self.cascade[index][-1].rank
                    del self.cascade[index][-1]
            for index in range(4):
                if self.freecell[index] != None and \
                   ok_to_automove(self.freecell[index], self.foundation):
                    searching = True
                    if verbose:
                        print('Moving ' + str(self.freecell[index].rank) + \
                              str(self.freecell[index].suit) + ' to foundation')
                    self.foundation[self.freecell[index].suit] = \
                        self.freecell[index].rank
                    self.freecell[index] = None
                    

