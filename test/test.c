#include <stdio.h>

int run_all_tests(void);

int main(void) {
    printf("Running tests...\n");
    int result = run_all_tests();
    if (result) {
        printf("All tests passed\n");
        return 0;
    } else {
        printf("Some tests FAILED\n");
        return 1;
    }
}
