CXX := g++
CXXFLAGS := -Wall -Wextra -g -O2

# Executables
TARGET_SERVER := server
TARGET_CLIENT := client

# Object files required for each target
SERVER_OBJS := server.o hashtable.o
CLIENT_OBJS := client.o

# Default target builds both executables
all: $(TARGET_SERVER) $(TARGET_CLIENT)

# 1. Link the server executable (uses $^ to include ALL dependencies, i.e., server.o and hashtable.o)
$(TARGET_SERVER): $(SERVER_OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

# 2. Link the client executable
$(TARGET_CLIENT): $(CLIENT_OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

# 3. Pattern rule to compile any .cpp file into a .o (object) file
# -c tells g++ to compile but not link
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# 4. Header dependencies: Recompile these object files if hashtable.h changes
server.o: hashtable.h
hashtable.o: hashtable.h

# Clean up executables AND object files
clean:
	rm -f $(TARGET_SERVER) $(TARGET_CLIENT) *.o

.PHONY: all clean
