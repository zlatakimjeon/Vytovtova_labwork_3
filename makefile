CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2 -Iinclude
AR = ar
ARFLAGS = rcs

SRC = src/permutation.c
OBJ = $(SRC:.c=.o)
LIBDIR = lib
LIBNAME = libpermutation.a
TESTDIR = test
TEST_SRC = $(TESTDIR)/permutation_tests.c
TEST_OBJ = $(TEST_SRC:.c=.o)
TEST_RUN = $(TESTDIR)/run

.PHONY: all clean test

all: $(LIBDIR)/$(LIBNAME) $(TEST_RUN)

$(LIBDIR)/$(LIBNAME): $(OBJ) | $(LIBDIR)
	$(AR) $(ARFLAGS) $@ $^

$(LIBDIR):
	mkdir -p $(LIBDIR)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(TEST_RUN): $(TEST_SRC) test/test.c $(LIBDIR)/$(LIBNAME)
	$(CC) $(CFLAGS) -Iinclude -I. $(TEST_SRC) test/test.c -L$(LIBDIR) -lpermutation -o $@

test: all
	./$(TEST_RUN)

clean:
	rm -f src/*.o test/*.o $(LIBDIR)/$(LIBNAME) $(TEST_RUN)