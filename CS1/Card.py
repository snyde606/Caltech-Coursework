#
# CS 1 Final exam, 2017
#

'''
This module has functions and classes representing playing cards 
and decks of cards.
'''

import random

class InvalidRank(Exception):
    pass

class InvalidSuit(Exception):
    pass

all_ranks = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K']
all_suits = ['S', 'H', 'D', 'C']


class Card:
    '''
    Instances of this class represent a single card in a deck of 52.
    '''

    def __init__(self, rank, suit):
        '''
        Create a card given a valid rank and suit.
        
        Arguments:
          rank: the card rank (an integer between 2 and 10, or 'A', 'J', 'Q',
                or 'K')
          suit: either 'S' (spades), 'H' (hearts), 'D' (diamonds), 'C' (clubs)
        '''
        
        if rank not in all_ranks:
            raise InvalidRank('rank argument is invalid')
        if suit not in all_suits:
            raise InvalidSuit('suit argument is invalid')
        
        self.rank = rank
        self.suit = suit
        if suit in ['S', 'C']:
            self.color = 'black'
        else:
            self.color = 'red'


    def __str__(self):
        '''
        Return the string representation of the card.
        '''

        return f'{self.rank}{self.suit.lower()}'

    def goes_above(self, card):
        '''
        Return True if this card can go above 'card' on the foundations.

        Arguments:
          card -- another Card object

        Return value:
          True if this card can go above 'card' on the foundations i.e.
          if it has the same suit as 'card' and is one rank higher,
          otherwise False
        '''

        assert isinstance(card, Card)
        
        if card.rank == 'K':
            return False
        
        if card.suit != self.suit:
            return False
        
        return all_ranks[all_ranks.index(card.rank) + 1] == self.rank

    def goes_below(self, card):
        '''
        Return True if this card can go below 'card' on a cascade.

        Arguments:
          card -- another Card object

        Return value:
          True if this card can go below 'card' on a cascade i.e.
          if it has the opposite color than 'card' and is one rank lower,
          otherwise False
        '''
        
        assert isinstance(card, Card)
        
        if card.rank == 'A':
            return False
        
        if card.color == self.color:
            return False
        
        return all_ranks[all_ranks.index(card.rank) - 1] == self.rank


class Deck:
    '''
    Instances of this class represent a deck of 52 cards, 13 in each
    of four suits (spades (S), hearts (H), diamonds (D), and clubs (C).
    Ranks are 'A', 2 .. 10, 'J', 'Q', 'K'.
    '''
   
    def __init__(self):
        '''
        Initialize the Deck object.
        '''

        self.current = 0
        self.cards = []
        for rank in all_ranks:
            for suit in all_suits:
                self.cards.append(Card(rank, suit))
        random.shuffle(self.cards)

    def __iter__(self):
        return self

    def __next__(self):
        '''
        Return the next card in the Deck, if there is one.
        '''
        if self.current >= len(self.cards):
            raise StopIteration
        card = self.cards[self.current]
        self.current += 1
        return card

