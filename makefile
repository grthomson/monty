# Make file for the game

CC=gcc
obj=main.o game.o

# If you run make game, this checks that the files in obj exist, if they do not,, it compiles the source code. It then links the files using my chosen C compiler.
game: $(obj)
	$(CC) -o $@ $^
	echo "Compiled and linked"

%.o: %.c
	echo "Compiling source code"
	gcc -c -o $@ $<
	echo "Source code compiled"

# This cleans away everything that is not needed. This was written by Gareth, not me
clean:
	rm *.o game
