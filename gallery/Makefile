CC ?= gcc
CFLAGS ?= -Wall -Wextra -O2
BIN_DIR = bin
SRC = $(wildcard src/*.c)
OBJ = $(SRC:src/%.c=$(BIN_DIR)/%.o)
TARGET = $(BIN_DIR)/app

.PHONY: all clean run test

all: $(TARGET)

$(TARGET): $(OBJ)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $^

$(BIN_DIR)/%.o: src/%.c
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

test: $(TARGET)
	@echo "Running test suite..."
	./$(TARGET) --test

clean:
	rm -rf $(BIN_DIR)
