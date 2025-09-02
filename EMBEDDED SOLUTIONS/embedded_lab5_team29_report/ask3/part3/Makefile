CC = gcc
CFLAGS = -Wall -g
SOURCES = string_manipulation.c
ASS = strlen.o strcmp.o strcat.o strcpy.o
OBJ = string_manipulation.o strlen.o strcmp.o strcat.o strcpy.o

all: string_manipulation.out

string_manipulation.o: string_manipulation.c
	$(CC) -c -o $@ $^ $(CFLAGS)

%.o: $(ASS).s
	$(CC) -c -o $@ $< $(CFLAGS)	

string_manipulation.out: $(OBJ)
	$(CC) -o $@ $^

clean:
	rm -f *.o *.out *_out
