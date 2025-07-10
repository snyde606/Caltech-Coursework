#
# CS 1 Final exam, 2017
#

'''
This module has classes that implement a FreeCell game.
'''

import random
from Card import *

class IllegalMove(Exception):
    '''
    Exception class representing illegal moves in a FreeCell game.
    '''
    pass

class FreeCell:
    '''
    A FreeCell game is represented by the following data structures:
      -- the foundation: a dictionary mapping suits to ranks
         e.g. { 'S' : 'A', 'D': 2 }  # other two suits (H, C) empty
      -- the freecells: a list four cards (or None if no card)
      -- the "cascades": a list of eight lists of cards
    '''

    def __init__(self):
        self.foundation = {}   # suit -> number map 
        self.freecell   = [None] * 4
        self.cascade    = [None] * 8

        # Deal cards from a full deck to the cascades.
        i = 0   # current cascade #
        for card in Deck():
            if self.cascade[i] == None:
                self.cascade[i] = []
            self.cascade[i].append(card)
            i = (i + 1) % 8

    def game_is_won(self):
        '''
        Return True if the game is won.
        '''

        for suit in ['S', 'H', 'C', 'D']:
            if suit not in self.foundation or self.foundation['S'] != 'K':
                return False
        
        for fcell in self.freecell:
            if fcell != None:
                return False
            
        for cask in self.cascade:
            if cask != []:
                return False
        
        return True

    #
    # Movement-related functions.
    #

    def move_cascade_to_freecell(self, n):
        '''
        Move the bottom card of cascade 'n' to the freecells.
        Raise an IllegalMove exception if the move can't be made.
        '''
        
        if type(n) != int:
            raise IllegalMove('must be an int in the arguments')

        if n > 7 or n < 0:
            raise IllegalMove('illegal cascade number')
        
        if self.cascade[n] == []:
            raise IllegalMove('cascade is empty')
        
        for index in range(len(self.freecell)):
            if self.freecell[index] == None:
                self.freecell[index] = self.cascade[n].pop()
                return
        
        raise IllegalMove('no empty freecells')

    def move_freecell_to_cascade(self, m, n):
        '''
        Move freecell card 'm' to cascade 'n'.
        Raise an IllegalMove exception if the move can't be made.
        '''

        if not isinstance(m, int) or not isinstance(n, int) or m < 0 \
           or m > 3 or n < 0 or n > 7:
            raise IllegalMove('invalid arguments')
        
        if self.freecell[m] == None:
            raise IllegalMove('freecell is empty')
        
        if self.cascade[n] == [] or \
           self.freecell[m].goes_below(self.cascade[n][-1]):
            self.cascade[n].append(self.freecell[m])
            self.freecell[m] = None
        else:
            raise IllegalMove('invalid move; this card cant go here')

    def move_cascade_to_cascade(self, m, n):
        '''
        Move a single card from one cascade to another.
        Raise an IllegalMove exception if the move can't be made.
        '''

        if not isinstance(m, int) or not isinstance(n, int) or m < 0 \
           or m > 7 or n < 0 or n > 7:
            raise IllegalMove('invalid arguments')
        
        if self.cascade[m] == []:
            raise IllegalMove('cascade is empty')
        
        if self.cascade[n] == [] or \
           self.cascade[m][-1].goes_below(self.cascade[n][-1]):
            self.cascade[n].append(self.cascade[m].pop())
        else:
            raise IllegalMove('invalid move; this card cant go here')

    def move_cascade_to_foundation(self, n):
        '''
        Move the bottom card of cascade 'n' to the foundation.
        If there is no card, or if the bottom card can't go to the foundation,
        raise an IllegalMove exception.
        '''

        if not isinstance(n, int) or n < 0 or n > 7:
            raise IllegalMove('invalid argument')        
        
        if self.cascade[n] == []:
            raise IllegalMove('cascade is empty')
        
        if self.cascade[n][-1].rank == 'A':
            self.foundation[self.cascade[n].pop().suit] = 'A'
            return
        
        if self.cascade[n][-1].suit in self.foundation and \
           self.cascade[n][-1].goes_above(\
            Card(self.foundation[self.cascade[n][-1].suit], \
                 self.cascade[n][-1].suit)):
            self.foundation[self.cascade[n][-1].suit] = \
                self.cascade[n].pop().rank
        else:
            raise IllegalMove('invalid card move; that card cant go there')

    def move_freecell_to_foundation(self, n):
        '''
        Move the card at index 'n' of the freecells to the foundation.
        If there is no card there, or if the card can't go to the foundation,
        raise an IllegalMove exception.
        '''

        if not isinstance(n, int) or n < 0 or n > 3:
            raise IllegalMove('invalid argument')        
        
        if self.freecell[n] == None:
            raise IllegalMove('freecell is empty')
        
        if self.freecell[n].rank == 'A':
            self.foundation[self.freecell[n].suit] = 'A'
            self.freecell[n] = None
            return
        
        if self.freecell[n].suit in self.foundation and \
           self.freecell[n].goes_above(\
            Card(self.foundation[self.freecell[n].suit], \
                 self.freecell[n].suit)):
            self.foundation[self.freecell[n].suit] = \
                self.freecell[n].rank
            self.freecell[n] = None
        else:
            raise IllegalMove('invalid card move; that card cant go there')

