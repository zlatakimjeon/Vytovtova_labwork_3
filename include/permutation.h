#ifndef PERMUTATION_H
#define PERMUTATION_H

typedef struct Permutation {
	unsigned n;
	unsigned *data;
} permutation_t;

typedef struct PermutationIterator {
	permutation_t value;
	int finished;
} iterator_t;

void iterator_init(iterator_t *i, unsigned n);
const permutation_t *iterator_value(const iterator_t *i);
int iterator_has_next(const iterator_t *i);
void iterator_next(iterator_t *i);
void iterator_destroy(iterator_t *i);

#endif