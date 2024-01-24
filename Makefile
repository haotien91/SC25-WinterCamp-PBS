# Makefile for mpi-monte-carlo.c

# Compiler
CC=mpicc

# Compiler flags
CFLAGS=-Wall

# Target executable name
TARGET=mpi-monte-carlo.run

all: $(TARGET)

$(TARGET): mpi-monte-carlo.c
	$(CC) $(CFLAGS) -o $(TARGET) mpi-monte-carlo.c

clean:
	rm -f $(TARGET)
