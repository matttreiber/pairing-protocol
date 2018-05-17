## Author: matt.treiber@artesyn.com
# This will (attempt to) reduce the output, comment / uncomment as needed
SILENCE = @

# Project base directory is the root of the current test/project repo
PROJECT_ROOT_DIR = .

COMPONENT_NAME = comms

# List of directories to search for source files above
SOURCE_PATH = code

INCLUDE_PATH = 

# List of source files to build (in Cpputest files in \tests are built
# automatically)
#SRC_FILES = $(SOURCE_PATH)/comms_layer.c

# Like source files build but build everything found in the directory
SOURCE_DIRS =

# --- TEST_SRC_FILES ---
# TEST_SRC_FILES specifies individual test files to build.  Test
# files are always included in the build and they
# pull in production code from the library
#
# x86 mock core and panic exception are the bare minium files for unit testing
# with the x86 mock platform.
TEST_SRC_FILES =

# --- TEST_SRC_DIRS ---
# Like TEST_SRC_FILES, but biulds everyting in the directory
TEST_SRC_DIRS = tests \

# --- MOCKS_SRC_DIRS ---
# MOCKS_SRC_DIRS specifies a directories where you can put your
# mocks, stubs and fakes.  You can also just put them
# in TEST_SRC_DIRS
MOCKS_SRC_DIRS = \

# This directory will store the intermidate files for the build (possibly
# in sub-directories
OBJ_STORAGE = build-objs

# Define the test harness to use here, options are 'NONE' (or blank),
# 'CPPUTEST' and 'CUTEST'.
UNIT_TEST_HARNESS = CPPUTEST

# Add flags here to pass to CPPUTEST, if you're using that harness ...
# See https://cpputest.github.io/manual.html#command_line for more
# Most useful is '-c' for colours, '-v' for verbose
# -sg <group>/-sn <name> runs just tests in <group> or test <name>
CPPUTEST_EXTRA_FLAGS =

##
## ---------------------------------------- invoke build system ---
##
## Don't change this line ...

SRC_FILES = $(SOURCE_FILES)

# Turn on CppUMock
CPPUTEST_USE_EXTENSIONS = N

# Turn on gcov
CPPUTEST_USE_GCOV = Y

INCLUDE_DIRS +=$(INCLUDE_PATH) \
  .\
  $(CPPUTEST_HOME)/include/ \
  $(CPPUTEST_HOME)/include/Platforms/Gcc/ \
  $(TEST_SRC_DIRS) \
  $(SOURCE_PATH)

# --- CPPUTEST_OBJS_DIR ---
# if you have to use "../" to get to your source path
# the makefile will put the .o and .d files in surprising
# places.
# To make up for each level of "../", add place holder
# sub directories in CPPUTEST_OBJS_DIR
# each "../".  It is kind of a kludge, but it causes the
# .o and .d files to be put under objs.
# e.g. if you have "../../src", set to "test-objs/1/2"
CPPUTEST_OBJS_DIR = $(OBJ_STORAGE)/1/2/3/4/5/6/7/8

CPPUTEST_LIB_DIR = $(OBJ_STORAGE)
CPPUTEST_WARNINGFLAGS += -Wall
CPPUTEST_WARNINGFLAGS += -Werror
CPPUTEST_WARNINGFLAGS += -Wswitch-default
CPPUTEST_WARNINGFLAGS += -Wfatal-errors
CPPUTEST_CXXFLAGS = -std=c++0x
CPPUTEST_CFLAGS = -std=c99
CPPUTEST_CXXFLAGS += $(CPPUTEST_PLATFORM_CXXFLAGS)
CPPUTEST_CFLAGS += -Wno-missing-prototypes
CPPUTEST_CXXFLAGS += -Wno-missing-variable-declarations
CPPUTEST_CXXFLAGS += -Wno-c++14-compat
# --- LD_LIBRARIES -- Additional needed libraries can be added here.
# commented out example specifies math library
#LD_LIBRARIES += -lm

# Place any CppUTest command line options here. -c adds color to the output
# See https://cpputest.github.io/manual.html#command_line for more
ifeq "$(USE_SHELL_COLOR)" "true"
CPPUTEST_EXE_FLAGS += -c
endif
CPPUTEST_EXE_FLAGS += $(CPPUTEST_EXTRA_FLAGS)

# Look at $(CPPUTEST_HOME)/build/MakefileWorker.mk for more controls
include $(CPPUTEST_HOME)/build/MakefileWorker.mk
