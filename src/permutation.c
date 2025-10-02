#include "../include/permutation.h"
#include <stdio.h>
#include <stdlib.h>

void iterator_init(iterator_t *i, unsigned n) {
    i->value.n = n;
    if (n == 0) {
        i->value.data = NULL;
        i->finished = 1;
    }
    i->value.data = malloc(n * sizeof(unsigned));
    if (!i->value.data) {
        i->value.n = 0;
        i->finished = 1;
        return;
    }
    for (unsigned k = 0; k < n; k++) i->value.data[k] = k;
    i->finished = (n == 0);
}

const permutation_t *iterator_value(const iterator_t *i) {
    if (!i) return NULL;
    return &i->value;
}

int iterator_has_next(const iterator_t *i) {
    if (!i) return 0;
    return !i->finished;
}

void iterator_next(iterator_t *i) {
    if (!i) return;
    if (i->finished) return;

    unsigned *a = i->value.data;
    unsigned n = i->value.n;

    if (n <= 1) {
        i->finished = 1;
        return;
    }

    int k = (int)n - 2;
    while (k >= 0 && a[k] > a[k + 1]) k--;
    if (k < 0) {
        i->finished = 1;
        return;
    }
    int j = n - 1;
    while (a[j] < a[k]) j--;
    unsigned tmp = a[k];
    a[k] = a[j];
    a[j] = tmp;

    int l = k + 1, r = n - 1;
    while (l < r) {
        tmp = a[l];
        a[l] = a[r];
        a[r] = tmp;
        l++;
        r--;
    }
}

void iterator_destroy(iterator_t *i) {
    if (!i) return;
    free(i->value.data);
    i->value.data = NULL;
    i->value.n = 0;
    i->finished = 1;
}
