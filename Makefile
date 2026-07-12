CXX := g++
CXXFLAGS := -Wall -Wextra -g -O2

# Executables
TARGET_SERVER := server
TARGET_CLIENT := client

# Object files required for each target
SERVER_OBJS := server.o hashtable.o zset.o avl.o
CLIENT_OBJS := client.o

# Default target builds both executables
all: $(TARGET_SERVER) $(TARGET_CLIENT)

# 1. Link the server executable
$(TARGET_SERVER): $(SERVER_OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

# 2. Link the client executable
$(TARGET_CLIENT): $(CLIENT_OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

# 3. Pattern rule to compile any .cpp file into a .o (object) file
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# 4. Header dependencies: Recompile specific objects if their included headers change
server.o: common.h hashtable.h zset.h
zset.o: zset.h avl.h hashtable.h
avl.o: avl.h
hashtable.o: hashtable.h
client.o: common.h # Assuming client might use common.h; remove if not.

# Clean up executables AND object files
clean:
	rm -f $(TARGET_SERVER) $(TARGET_CLIENT) *.o

.PHONY: all clean
