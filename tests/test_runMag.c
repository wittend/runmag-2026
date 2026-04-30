#include <stdio.h>
#include <stdlib.h>
#include "runMag.h"

static void assert_equal_ushort(const char *name, unsigned short actual, unsigned short expected)
{
    if(actual != expected)
    {
        fprintf(stderr, "FAIL: %s (expected %u, got %u)\n", name, expected, actual);
        exit(1);
    }
}

int main(int argc, char **argv)
{
    (void)argc;
    (void)argv;
    assert_equal_ushort("getCCGainEquiv(50)", getCCGainEquiv(50), 19);
    assert_equal_ushort("getCCGainEquiv(100)", getCCGainEquiv(100), 38);
    assert_equal_ushort("getCCGainEquiv(200)", getCCGainEquiv(200), 74);
    assert_equal_ushort("getCCGainEquiv(400)", getCCGainEquiv(400), 148);

    fprintf(stdout, "PASS: test_runMag\n");
    return 0;
}