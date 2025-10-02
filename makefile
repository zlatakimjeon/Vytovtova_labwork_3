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

all: $(LIBDIR)/$(LIBNAME) $(TEST_RUN)

$(LIBDIR)/$(LIBNAME): $(OBJ) | $(LIBDIR)
	ar rcs $@ $^

$(LIBDIR):
	mkdir -p $(LIBDIR)

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(TEST_RUN): $(TEST_SRC) test/test.c $(LIBDIR)/$(LIBNAME)
	$(CC) $(CFLAGS) $(TEST_SRC) test/test.c -L$(LIBDIR) -lpermutation -o $@

test: all
	./$(TEST_RUN)

clean:
	rm -rf src/*.o $(LIBDIR) $(TEST_RUN)
