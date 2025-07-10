import math

# Ex C.1
def update(rules, lstr):
    '''Updates the input string based on the set of rules provided and returns 
    the result.'''
    total = ''
    for c in lstr:
        if c in rules:
            total += rules[c]
        else:
            total += c
    return total

# Ex C.2
def iterate(rules, n):
    '''Updates the starting string in the input dictionary n times and returns
     the result.'''
    target = rules['start']
    for a in range(n):
        target = update(rules, target)
    return target

# Ex C.3
def lsystemToDrawingCommands(drawRules, lstr):
    '''Returns a list of drawing commands generated based on the input string 
    and input rules.'''
    total = []
    for c in lstr:
        if c in drawRules:
            total.append(drawRules[c])
    return total

# Ex C.4
def nextLocation(x, y, dire, command):
    '''Returns the next position and facing based on current position and 
    facing and input command.'''
    instr = command.split()
    if instr[0] == 'R':
        dire -= float(instr[1])
        dire %= 360
    elif instr[0] == 'L':
        dire += float(instr[1])
        dire %= 360
    else:
        rads = dire * math.pi / 180
        x += math.cos(rads) * float(instr[1])
        y += math.sin(rads) * float(instr[1])
    return (x, y, dire)
    
# Ex C.5
def bounds(commands):
    '''Returns the maximum bounds reached by the list of commands.'''
    xmin = 0
    xmax = 0
    ymin = 0
    ymax = 0
    x = 0
    y = 0
    face = 0
    for c in commands:
        tup = nextLocation(x, y, face, c)
        x = tup[0]
        y = tup[1]
        face = tup[2]
        if x < xmin:
            xmin = x
        elif x > xmax:
            xmax = x
        if y < ymin:
            ymin = y
        elif y > ymax:
            ymax = y
    return (xmin, xmax, ymin, ymax)

# Ex C.6
def saveDrawing(fname, bounds, commands):
    '''Saves a text file containing the turtle graphics instructions for 
    drawing the shape required, along with the bounds.'''
    file = open(fname, 'w')
    file.write('{0} {1} {2} {3}'.format(bounds[0], bounds[1], bounds[2], \
                                          bounds[3]))
    for a in commands:
        file.write('\n{}'.format(a))
    file.close()