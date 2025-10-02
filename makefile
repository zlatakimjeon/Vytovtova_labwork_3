CC = gcc
CFLAGS = -std=c11 -Wall -Wextra -O2 -Iinclude

SRC = src/permutation.c
OBJ = $(SRC:.c=.o)
LIBDIR = lib
LIBNAME = libpermutation.a
TESTDIR = test
TEST_SRC = $(TESTDIR)/perm_tests.c
TEST_RUN = $(TESTDIR)/run

ifeq ($(OS),Windows_NT)
    RM = del /Q /S
    MKDIR = if not exist $(1) mkdir $(1)
else
    RM = rm -rf
    MKDIR = mkdir -p $(1)
endif

.PHONY: all clean test

all: $(LIBDIR)/$(LIBNAME) $(TEST_RUN)

$(LIBDIR)/$(LIBNAME): $(OBJ) | $(LIBDIR)
	ar rcs $@ $^

$(LIBDIR):
	$(call MKDIR,$@)

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(TEST_RUN): $(TEST_SRC) test/test.c $(LIBDIR)/$(LIBNAME)
	$(CC) $(CFLAGS) $(TEST_SRC) test/test.c -L$(LIBDIR) -lpermutation -o $@

test: all
	./$(TEST_RUN)

clean:
ifeq ($(OS),Windows_NT)
	$(RM) $(OBJ) $(LIBDIR)\* $(TEST_RUN)
else
	$(RM) $(OBJ) $(LIBDIR) $(TEST_RUN)
endif
