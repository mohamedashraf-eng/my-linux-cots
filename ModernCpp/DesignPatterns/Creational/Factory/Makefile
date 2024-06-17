# Define variables
CXX := g++
CXXFLAGS := -Wall -g -O0 -Wpedantic -std=c++20
TARGET := main
SRCS := main.cpp Led.cpp factory.cpp Buzzer.cpp 
INCLUDES := ./
OBJDIR := obj

# Additional flags and libraries
LDFLAGS :=
LIBS :=

# Define object files
OBJS := $(addprefix $(OBJDIR)/, $(notdir $(SRCS:.cpp=.o)))

# Default target
all: $(TARGET)

# Rule for linking the target
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

# Rule for compiling source files
$(OBJDIR)/%.o: %.cpp | $(OBJDIR)
	$(CXX) $(CXXFLAGS) -I$(INCLUDES) -c $< -o $@

# Ensure the obj directory exists
$(OBJDIR):
	mkdir -p $(OBJDIR)

# Clean rule
.PHONY: clean
clean:
	rm -f $(TARGET) $(OBJS)
	rm -rf $(OBJDIR)

# Run the program
.PHONY: run
run: $(TARGET)
	./$(TARGET)
