'''
This program allows the user to interactively play the game of Sudoku.
'''

import sys

class SudokuError(Exception):
    pass

class SudokuMoveError(SudokuError):
    pass

class SudokuCommandError(SudokuError):
    pass

class Sudoku:
    '''Interactively play the game of Sudoku.'''

    def __init__(self):
        self.board = [[],[],[],[],[],[],[],[],[]]
        for a in range(9):
            for b in range(9):
                self.board[a].append(0)
        self.moveList = []

    def load(self, filename):
        acceptable = ['0','1','2','3','4','5','6','7','8','9']
        f = open(filename, 'r')
        for a in range(9):
            lin = f.readline()
            if len(lin) == 0:
                raise IOError('incorrect number of lines')
            elif len(lin) != 10:
                raise IOError('incorrect line length')
            for b in range(9):
                if lin[b] not in acceptable:
                    raise IOError('invalid character')
                self.board[a][b] = int(lin[b])
        f.close()

    def save(self, filename):
        f = open(filename, 'w')
        for a in range(9):
            for b in range(9):
                f.write(str(self.board[a][b]))
            f.write('\n')
        f.close()

    def show(self):
        '''Pretty-print the current board representation.'''
        print()
        print('   1 2 3 4 5 6 7 8 9 ')
        for i in range(9):
            if i % 3 == 0:
                print('  +-----+-----+-----+')
            print(f'{i + 1} |', end='')
            for j in range(9):
                if self.board[i][j] == 0:
                    print(end=' ')
                else:
                    print(f'{self.board[i][j]}', end='')
                if j % 3 != 2 :
                    print(end=' ')
                else:
                    print('|', end='')
            print() 
        print('  +-----+-----+-----+')
        print()

    def isValidBox(self, row, col, val):
        r = 0
        c = 0
        if row - 1 > 5:
            r = 6
        elif row - 1 > 2:
            r = 3
        if col - 1 > 5:
            c = 6
        elif col - 1 > 2:
            c = 3
        for a in range(r, r + 3):
            for b in range(c, c + 3):
                if self.board[r][c] == val:
                    return False
        return True
    
    def move(self, row, col, val):
        if row < 1 or row > 9 or col < 1 or col > 9:
            raise SudokuMoveError('invalid coordinates')
        if not self.isValidBox(row, col, val):
            raise SudokuMoveError('box conflict')
        for a in range(9):
            if self.board[a][col - 1] == val:
                raise SudokuMoveError('column conflict')
            if self.board[row - 1][a] == val:
                raise SudokuMoveError('row conflict')
        if self.board[row - 1][col - 1] != 0:
            raise SudokuMoveError('occupied space')
        self.board[row - 1][col - 1] = val
        self.moveList.append((row - 1, col - 1, val))
            
    def undo(self):
        if len(self.moveList) == 0:
            return
        move = self.moveList.pop()
        self.board[move[0]][move[1]] = 0

    def solve(self):
        while(True):
            try:
                command = input('Enter a command: ')
                if command == 'q':
                    return
                elif command == 'u':
                    self.undo()
                    self.show()
                elif command[0] == 's':
                    self.save(command.split()[1])
                else:
                    acceptable = ['0','1','2','3','4','5','6','7','8','9']
                    if len(command) != 3:
                        raise SudokuCommandError('invalid command')
                    for a in command:
                        if a not in acceptable:
                            raise SudokuCommandError('invalid command')
                    self.move(int(command[0]), int(command[1]), \
                              int(command[2]))
                    self.show()
            except SudokuCommandError as e:
                print(e)
                print('try again dude sorry thats not a valid command')
            except SudokuMoveError as e:
                print(e)
                print('try again dude sorry thats not a valid move')
                    

if __name__ == '__main__':
    s = Sudoku()

    while True:
        filename = input('Enter the sudoku filename: ')
        try:
            s.load(filename)
            break
        except IOError as e:
            print(e)

    s.show()
    s.solve()