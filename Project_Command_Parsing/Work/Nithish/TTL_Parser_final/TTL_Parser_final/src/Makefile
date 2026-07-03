# Define the compiler and flags
CC = gcc
CFLAGS = -IC:\Users\JIIN18710724\AppData\Local\Programs\Python\Python313\include
LDFLAGS = -LC:\Users\JIIN18710724\AppData\Local\Programs\Python\Python313\libs
LIBS = C:\Users\JIIN18710724\AppData\Local\Programs\Python\Python313\libs\python313.lib

# Define the target and source files
TARGET = TTL_Parser.exe
SRC = TTL_Parser.c

# Default target
all: $(TARGET)

# Rule to build the target
$(TARGET): $(SRC)
	$(CC) $(SRC) -o $(TARGET) $(CFLAGS) $(LDFLAGS) $(LIBS)

# Clean rule to remove the compiled files
clean:
	rm -f $(TARGET)
