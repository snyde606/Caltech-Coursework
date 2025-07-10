from tkinter import *
import random
import math

# Graphics commands.

def random_color():
    '''Returns a random hexidecimal color.'''
    output = '#'
    options = ['0','1','2','3','4','5','6','7','8','9','a',\
               'b','c','d','e','f']
    for i in range(6):
        output += random.choice(options)
    return output

def random_radius():
    '''Returns a random radius between 50 and 100.'''
    return random.randint(50, 100)

def draw_line(canvas, color, start, end):
    '''Creates a square in the input canvas, returning the 
    handle of the square. The square is centered at a pos, 
    which is a tuple representing (x, y) center. It has 
    side length of side, color color, and is drawn on the 
    canvas can.'''
    return canvas.create_line(start[0], start[1], end[0], end[1], \
                                fill = color)

def draw_star(canvas, color, center, n):
    '''Draws an n sided star at the location of the cursor and returns a 
    list of the line handles.'''
    listOfLines = []
    radius = random_radius()
    points = []
    points.append((center[0], center[1] - radius))
    currentAngle = math.pi / 2
    for a in range(n):
        currentAngle += ((n - 1) / 2) * (2 * math.pi) / n
        offsets = (radius * math.cos(currentAngle), \
                   radius * math.sin(currentAngle))
        points.append((center[0] + offsets[0], center[1] - offsets[1]))
    for point in range(len(points) - 1):
        listOfLines.append(draw_line(canvas, color, points[point], \
                                     points[point + 1]))
    listOfLines.append(draw_line(canvas, color, points[-1], points[0]))
    return listOfLines
        

# Event handlers.

def key_handler(event):
    '''Handle key presses.'''
    global color
    global lines
    global n
    if event.keysym == 'q':
        quit()
    elif event.keysym == 'c':
        color = random_color()
    elif event.keysym == 'x':
        for line in lines:
            canvas.delete(line)
        lines = []
    elif event.keysym == 'plus':
        n += 2
    elif event.keysym == 'minus':
        n -= 2
        if n < 5:
            n = 5

def button_handler(event):
    '''Handle left mouse button click events.'''
    global lines
    lines += draw_star(canvas, color, (event.x, event.y), n)

if __name__ == '__main__':
    root = Tk()
    root.geometry('800x800')
    canvas = Canvas(root, width=800, height=800)
    canvas.pack()
    color = random_color()
    lines = []
    n = 5

    # Bind events to handlers.
    root.bind('<Key>', key_handler)
    canvas.bind('<Button-1>', button_handler)

    # Start it up.
    root.mainloop()

