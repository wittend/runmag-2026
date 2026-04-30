#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cmdmgr.h"

char version[] = RUNMAG_VERSION;
char outFilePath[MAXPATHBUFLEN] = "./logs/";
char workFilePath[MAXPATHBUFLEN] = "";
char rollOverTime[UTCBUFLEN] = "00:00";
char sitePrefixString[SITEPREFIXLEN] = "SITEPREFIX";

static void assert_true(const char *name, int condition)
{
    if(!condition)
    {
        fprintf(stderr, "FAIL: %s\n", name);
        exit(1);
    }
}

int main(int argc_unused, char **argv_unused)
{
    (void)argc_unused;
    (void)argv_unused;
    pList p;
    char site[] = "station42";
    char *argv[] = { "test_cmdmgr", "-b", "3", "-j", "-S", site, "-k", "-s", NULL };
    int argc = 8;

    optind = 1;
    assert_true("getCommandLine returns 0", getCommandLine(argc, argv, &p) == 0);
    assert_true("default bus overridden", p.i2cBusNumber == 3);
    assert_true("json flag set", p.jsonFlag == TRUE);
    assert_true("single read set", p.singleRead == TRUE);
    assert_true("log output set", p.logOutput == TRUE);
    assert_true("sitePrefix assigned", p.sitePrefix != NULL);
    assert_true("sitePrefix value", strcmp(p.sitePrefix, "station42") == 0);

    fprintf(stdout, "PASS: test_cmdmgr\n");
    return 0;
}