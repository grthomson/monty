# ---- Config
CC      = gcc
STD     = -std=c11
WARN    = -Wall -Wextra -Wpedantic
INC     = -Iinclude
REL_OPTS= -O3
DEPFLAGS= -MMD -MP

SRC     := src/main.c src/monty_logic.c
OBJ     := $(patsubst src/%.c,build/%.o,$(SRC))
DEP     := $(OBJ:.o=.d)
BIN     := monty

# Writable temp the tools will use (avoid C:\WINDOWS)
TMPDIR  := $(abspath build/tmp)
export TMPDIR
export TMP   := $(TMPDIR)
export TEMP  := $(TMPDIR)

.DEFAULT_GOAL := release

# ---- Targets
release: CFLAGS := $(STD) $(WARN) $(REL_OPTS) $(INC) $(DEPFLAGS)
release: $(BIN)

$(BIN): $(OBJ) | build tmpdir
	@echo "Linking $@"
	$(CC) $(CFLAGS) $^ -o $@

build/%.o: src/%.c | build tmpdir
	@echo "Compiling $<"
	$(CC) $(CFLAGS) -c $< -o $@

build:
	@mkdir -p build

tmpdir:
	@mkdir -p "$(TMPDIR)"

clean:
	@echo "Cleaning objects"
	@rm -f $(OBJ) $(DEP)

clobber: clean
	@echo "Removing binary"
	@rm -f $(BIN)

-include $(DEP)
