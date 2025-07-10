from tkinter import *
import random

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
    '''Returns a random radius between 5 and 25.'''
    return random.randint(5, 25)

def draw_circle(canvas, color, center, radius):
    '''Creates a square in the input canvas, returning the 
    handle of the square. The square is centered at a pos, 
    which is a tuple representing (x, y) center. It has 
    side length of side, color color, and is drawn on the 
    canvas can.'''
    return canvas.create_oval(center[0] - radius, \
                                center[1] + radius, \
                                center[0] + radius, \
                                center[1] - radius, \
                                fill = color, \
                                outline = color)

# Event handlers.

def key_handler(event):
    '''Handle key presses.'''
    global color
    global circles
    if event.keysym == 'q':
        quit()
    elif event.keysym == 'c':
        color = random_color()
    elif event.keysym == 'x':
        for cirkill in circles:
            canvas.delete(cirkill)
        circles = []

def button_handler(event):
    '''Handle left mouse button click events.'''
    circles.append(draw_circle(canvas, color, (event.x, event.y),\
                               random_radius()))

if __name__ == '__main__':
    root = Tk()
    root.geometry('800x800')
    canvas = Canvas(root, width=800, height=800)
    canvas.pack()
    color = random_color()
    circles = []

    # Bind events to handlers.
    root.bind('<Key>', key_handler)
    canvas.bind('<Button-1>', button_handler)

    # Start it up.
    root.mainloop()

