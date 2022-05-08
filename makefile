NULL =
TAB  = $(NULL)	$(NULL)

# aliased options
all: build
o: options
d: debug
b: build
c: compiler
r: run
cl: clean
cf: cleanf

# options for make
options:
	$(info USAGE:)
	$(info $(TAB)make  o | options)
	$(info $(TAB)make  d | debug)
	$(info $(TAB)make  b | build)
	$(info $(TAB)make  c | compiler)
	$(info $(TAB)make  r | run exp="[expression]")
	$(info $(TAB)make cl | clean)
	$(info $(TAB)make cf | cleanf)
	@exit

# required stuff
CC		= gcc
DBG	   = gdb
DBG_FLAGS = -Wall -D DEBUG="(1)" -g3 -ggdb
REL_FLAGS = -Wall -Ofast
BFC_FLAGS = -Wall -Ofast -D COMPILE="(1)"

SRC_DIR   = ./src
BIN_DIR   = ./bin

SRC_PATH  = $(SRC_DIR)/lib/*.c $(SRC_DIR)/*.c
DBG_PATH  = $(BIN_DIR)/dbg-binary
REL_PATH  = $(BIN_DIR)/binary
BFC_PATH  = $(BIN_DIR)/bfc

GOTO_HELL = 2> /dev/null

# clear screen
clscr:
	clear

# creates debug build and launches in gdb
debug: clscr
	mkdir -p $(BIN_DIR)
	$(CC) $(DBG_FLAGS) $(SRC_PATH) -o $(DBG_PATH)
	$(DBG) $(DBG_PATH)

# compile source to bin path
build:
	mkdir -p $(BIN_DIR)
	$(CC) $(REL_FLAGS) $(SRC_PATH) -o $(REL_PATH)

expression_provided:
ifndef exp
	$(info run expression exp= not provided)
	$(error failed)
endif

compiler:
	mkdir -p $(BIN_DIR)
	$(CC) $(BFC_FLAGS) $(SRC_PATH) -o $(BFC_PATH)

# run source
run: expression_provided
	@$(REL_PATH) $(exp)

# clear binaries
clean:
	mkdir -p $(BIN_DIR)
	rm -r $(BIN_DIR)

# force clear binaries
cleanf:
	rm -rf $(BIN_DIR)
