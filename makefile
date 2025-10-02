CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2 -Iinclude

SRC = src/permutation.c
OBJ = $(SRC:.c=.o)
LIBDIR = lib
LIBNAME = libpermutation.a
TESTDIR = test
TEST_SRC = $(TESTDIR)/perm_tests.c
TEST_RUN = $(TESTDIR)/run

.PHONY: all clean test

ifeq ($(OS),Windows_NT)
    RM = powershell -Command "Remove-Item -Recurse -Force"
    EXE_EXT = .exe
else
    RM = rm -rf
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
	$(RM) src\permutation.o
	$(RM) lib\*
	$(RM) test\run.exe
else
	$(RM) src/permutation.o lib test/run
endif
