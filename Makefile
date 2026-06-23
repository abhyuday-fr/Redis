CXX := g++
CXXFLAGS := -Wall -Wextra -g

TARGET1 := server
TARGET2 := client
SRC1 := server.cpp
SRC2 := client.cpp

all: $(TARGET1) $(TARGET2)

$(TARGET1) : $(SRC1)
	$(CXX) $(CXXFLAGS) -o $@ $<

$(TARGET2) : $(SRC2)
	$(CXX) $(CXXFLAGS) -o $@ $<

clean:
	rm -rf $(TARGET1) $(TARGET2)

.PHONY: all clean
