CXX := g++
# Added -pthread to support thread_pool.cpp compilation and linking
CXXFLAGS := -Wall -Wextra -g -O2 -pthread

# Executables
TARGET_SERVER := server
TARGET_CLIENT := client

# Object files required for each target
# Added heap.o and thread_pool.o for the server
SERVER_OBJS := server.o hashtable.o zset.o avl.o heap.o thread_pool.o
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
server.o: common.h hashtable.h zset.h heap.h thread_pool.h
zset.o: zset.h avl.h hashtable.h
avl.o: avl.h
hashtable.o: hashtable.h
heap.o: heap.h
thread_pool.o: thread_pool.h
client.o: common.h 

# Clean up executables AND object files
clean:
	rm -f $(TARGET_SERVER) $(TARGET_CLIENT) *.o

.PHONY: all clean
