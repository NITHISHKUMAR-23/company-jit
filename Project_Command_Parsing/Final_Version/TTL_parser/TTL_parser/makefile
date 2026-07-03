CC = gcc
CFLAGS = -I$(USERPROFILE)/AppData/Local/Programs/Python/Python313/include
LDFLAGS = -L$(USERPROFILE)/AppData/Local/Programs/Python/Python313/libs
LIBS = $(USERPROFILE)/AppData/Local/Programs/Python/Python313/libs/python313.lib
 
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
	del $(TARGET)