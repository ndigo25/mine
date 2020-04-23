import sys
import os

def main():
        color = str(input('Choose your color: '))
        if(color == 'red'):
            print('You chose red!')
        elif(color == 'black'):
            print('You chose black!')
        else:
            print('You need to choose red or black')
main()

def number():
        number = str(input('Choose your number: '))
        print('You chose ' + number +'!')
number()

from random import *
numbers = ['1','2','3','4','5','6','7','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39']
x = sample(numbers, 1)
print(x)

from random import *
colors = ['red', 'black']
y = sample(colors, 1)
print(y)

def restart_program():
    python = sys.executable
    os.execl(python, python, * sys.argv)
if __name__ == '__main__':
    restart = str(input('Do you want to restart the game?: '))
    if restart.lower().strip() in 'y yes'.split():
        restart_program()
