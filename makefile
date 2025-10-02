CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2 -Iinclude

SRC = src/permutation.c
OBJ = $(SRC:.c=.o)
LIBDIR = lib
LIBNAME = libpermutation.a
TESTDIR = test
TEST_SRC = $(TESTDIR)/permutation_tests.c
TEST_RUN = $(TESTDIR)/run

.PHONY: all clean test

ifeq ($(OS),Windows_NT)
    RM_WIN = powershell -Command "if (Test-Path '$1') { Remove-Item -Recurse -Force $1 }"
    EXE_EXT = .exe
else
    RM_WIN =
    EXE_EXT =
endif

all: $(LIBDIR)/$(LIBNAME) $(TEST_RUN)

$(LIBDIR)/$(LIBNAME): $(OBJ) | $(LIBDIR)
	ar rcs $@ $^

$(LIBDIR):
	mkdir -p $(LIBDIR)

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(TEST_RUN): $(TEST_SRC) test/test.c $(LIBDIR)/$(LIBNAME)
	$(CC) $(CFLAGS) $(TEST_SRC) test/test.c -L$(LIBDIR) -lpermutation -o $@$(EXE_EXT)

test: all
ifeq ($(OS),Windows_NT)
	.\$(TEST_RUN)$(EXE_EXT)
else
	./$(TEST_RUN)
endif

clean:
ifeq ($(OS),Windows_NT)
	$(RM_WIN) src/permutation.o
	$(RM_WIN) lib
	$(RM_WIN) test/run$(EXE_EXT)
else
	rm -rf src/permutation.o lib test/run
endif
