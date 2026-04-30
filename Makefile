#=========================================================================
# Simple Makefile for runmag-26
#
# Author:      David Witten, KD0EAG
# Date:        April 21, 2020
# License:     GPL 3.0
#=========================================================================
CC = gcc
LD = gcc
GPERF = gperf
CXX = g++
SRC_DIR = src
TEST_DIR = tests
INC_DIR = include
#DEPS = main.h MCP9808.h device_defs.h i2c.h runMag.h cmdmgr.h config.gperf cfghash.c  
DEPS = $(INC_DIR)/main.h $(INC_DIR)/MCP9808.h $(INC_DIR)/device_defs.h $(INC_DIR)/i2c.h $(INC_DIR)/runMag.h $(INC_DIR)/cmdmgr.h
#SRCS = main.c runMag.c i2c.c cmdmgr.c cfghash.c
SRCS = $(SRC_DIR)/main.c $(SRC_DIR)/runMag.c $(SRC_DIR)/i2c.c $(SRC_DIR)/cmdmgr.c
OBJS = $(subst $(SRC_DIR)/,,$(subst .c,.o,$(SRCS)))
#DOBJS = main.o runMag.o i2c.o cmdmgr.o cfghash.o 
DOBJS = $(OBJS)
TEST_SRCS = $(TEST_DIR)/test_runMag.c $(TEST_DIR)/test_cmdmgr.c
TEST_BINS = $(TEST_DIR)/test_runMag $(TEST_DIR)/test_cmdmgr
LIBS = -lm
DEBUG = -g -Wall
CFLAGS = -I$(INC_DIR)
DBGFLAGS = $(DEBUG) -I$(INC_DIR)
LDFLAGS =
TARGET_ARCH =
LOADLIBES =
LDLIBS =
GPERFFLAGS = --language=ANSI-C 

TARGET = runmag-26

RM = rm -f

all: release

#cfghash.c: config.gperf
#	$(GPERF) $(GPERFFLAGS) config.gperf > cfghash.c

debug: $(SRCS) $(DEPS)
	$(CC) $(DBGFLAGS) -c $(SRC_DIR)/runMag.c -o runMag.o
	$(CC) $(DBGFLAGS) -c $(SRC_DIR)/cmdmgr.c -o cmdmgr.o
	$(CC) $(DBGFLAGS) -c $(SRC_DIR)/i2c.c -o i2c.o
	$(CC) $(DBGFLAGS) -o $(TARGET) $(SRC_DIR)/main.c runMag.o i2c.o cmdmgr.o $(LIBS)

#release: runMag.c cfghash.c $(DEPS)
release: $(SRCS) $(DEPS)
	$(CC) $(CFLAGS) -c $(SRC_DIR)/runMag.c -o runMag.o
	$(CC) $(CFLAGS) -c $(SRC_DIR)/cmdmgr.c -o cmdmgr.o
	$(CC) $(CFLAGS) -c $(SRC_DIR)/i2c.c -o i2c.o
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC_DIR)/main.c runMag.o i2c.o cmdmgr.o $(LIBS)

tests: $(TEST_BINS)
	@for t in $(TEST_BINS); do ./$$t; done

$(TEST_DIR)/test_runMag: $(TEST_DIR)/test_runMag.c $(SRC_DIR)/runMag.c $(SRC_DIR)/i2c.c $(DEPS)
	$(CC) $(DBGFLAGS) -o $@ $(TEST_DIR)/test_runMag.c $(SRC_DIR)/runMag.c $(SRC_DIR)/i2c.c $(LIBS)

$(TEST_DIR)/test_cmdmgr: $(TEST_DIR)/test_cmdmgr.c $(SRC_DIR)/cmdmgr.c $(SRC_DIR)/runMag.c $(SRC_DIR)/i2c.c $(DEPS)
	$(CC) $(DBGFLAGS) -o $@ $(TEST_DIR)/test_cmdmgr.c $(SRC_DIR)/cmdmgr.c $(SRC_DIR)/runMag.c $(SRC_DIR)/i2c.c $(LIBS)

clean:
	$(RM) $(OBJS) $(TARGET) config.json $(TEST_BINS)

distclean: clean
	
.PHONY: clean distclean all debug release tests