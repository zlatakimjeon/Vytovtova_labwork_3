#include "../include/permutation.h"
#include <stdio.h>

static unsigned factorial(unsigned n) { // сколько должно быть перестановок
    unsigned r = 1;
    for (unsigned i = 2; i <= n; ++i) r *= i;
    return r;
}

static int test_count_and_sequence(unsigned n) {
    iterator_t it;
    iterator_init(&it, n);

    unsigned count = 0;
    int success = 1;

    if (n == 0) {
        if (iterator_has_next(&it)) {
            printf("Failed\n");
            success = 0;
        }
    } else {
        while (iterator_has_next(&it)) {
            const permutation_t *p = iterator_value(&it);
            if (!p || p->n != n) {
                printf("Failed\n");
                success = 0;
                break;
            }

            unsigned seen_mask = 0;
            for (unsigned i = 0; i < p->n; ++i) {
                unsigned v = p->data[i];
                if (v >= n) {
                    printf("Failed\n");
                    success = 0;
                }
                seen_mask |= 1u << v;
            }
            if (seen_mask != ((1u << n) - 1)) {
                printf("Failed\n");
                success = 0;
            }

            ++count;
            iterator_next(&it);
        }

        if (count != factorial(n)) {
            printf("Failed\n");
            success = 0;
        }

        iterator_next(&it);
        if (iterator_has_next(&it)) {
            printf("Failed\n");
            success = 0;
        }
    }

    iterator_destroy(&it);
    if (success) {
        printf("All tests passed\n");
    }
    return success;
}

static int test_edge_cases(void) {
    int ok = 1;
    ok &= test_count_and_sequence(0);
    ok &= test_count_and_sequence(1);
    ok &= test_count_and_sequence(2);
    ok &= test_count_and_sequence(3);
    return ok;
}

static int test_larger(unsigned n) {
    iterator_t it;
    iterator_init(&it, n);
    unsigned count = 0;
    while (iterator_has_next(&it)) {
        ++count;
        iterator_next(&it);
    }
    iterator_destroy(&it);

    if (count != factorial(n)) {
        printf("Failed\n");
        return 0;
    }
    printf("All tests passed\n");
    return 1;
}

int run_all_tests(void) {
    int ok = 1;
    ok &= test_edge_cases();
    ok &= test_larger(4);
    ok &= test_larger(5);
    return ok;
}
