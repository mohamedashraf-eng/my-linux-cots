# Define variables
CXX := g++
CXXFLAGS := -Wall -g -O0 -Wpedantic -std=c++20
TARGET := main
SRCS := main.cpp

# Additional flags and libraries
LDFLAGS :=
LIBS :=

# Define object files
OBJS := $(SRCS:.cpp=.o)

# Default target
all: $(TARGET)

# Rule for linking the target
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

# Rule for compiling source files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean rule
.PHONY: clean
clean:
	rm -f $(TARGET) $(OBJS)

# Run the program
.PHONY: run
run: $(TARGET)
	./$(TARGET)
