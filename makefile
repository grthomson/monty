# Makefile — Monty Hall (small C project best practice)

# ---- Config ---------------------------------------------------------------
CC      ?= gcc
STD       = -std=c11
WARN      = -Wall -Wextra -Wpedantic
INC       = -Iinclude
REL_OPTS  = -O3
DBG_OPTS  = -O0 -g3 -fsanitize=address,undefined -fno-omit-frame-pointer
DEPFLAGS  = -MMD -MP

SRC      := src/main.c src/monty_logic.c
OBJ      := $(patsubst src/%.c,build/%.o,$(SRC))
DEP      := $(OBJ:.o=.d)
BIN      := monty

.DEFAULT_GOAL := release

# ---- Build modes ----------------------------------------------------------
release: CFLAGS := $(STD) $(WARN) $(REL_OPTS) $(INC) $(DEPFLAGS)
release: $(BIN)

debug:   CFLAGS := $(STD) $(WARN) $(DBG_OPTS) $(INC) $(DEPFLAGS)
debug:   $(BIN)

# ---- Link -----------------------------------------------------------------
$(BIN): $(OBJ)
	@echo "Linking $@"
	$(CC) $(CFLAGS) $^ -o $@

# ---- Compile (out-of-source to build/) ------------------------------------
build/%.o: src/%.c | build
	@echo "Compiling $<"
	$(CC) $(CFLAGS) -c $< -o $@

build:
	@mkdir -p build

# ---- Utilities ------------------------------------------------------------
.PHONY: clean clobber run test format

run: release
	./$(BIN)

test: release
	@scripts/simulate.sh -n 10000

clean:
	@echo "Cleaning objects"
	@rm -f $(OBJ) $(DEP)

clobber: clean
	@echo "Removing binary"
	@rm -f $(BIN)

# ---- Auto-deps ------------------------------------------------------------
-include $(DEP)
