SHELL = /bin/sh
DISTRO = clanton-tiny
TARGET_NAME = i586-poky-linux-uclibc
NATIVE_NAME = x86_64-pokysdk-linux
GCC_VERSION = 4.7.2

TARGET_BIN    = helloworld
TARGET_ARCH   = -m32 -march=i586 --sysroot=$(SYSROOT_TARGET)
INCLUDE_DIRS  = -I $(SYSROOT_TARGET)/usr/include \
				-I $(SYSROOT_TARGET)/usr/include/c++ \
				-I $(SYSROOT_NATIVE)/usr/lib/$(TARGET_NAME)/gcc/$(TARGET_NAME)/$(GCC_VERSION)/include
LIBRARY_DIRS  = -L $(SYSROOT_TARGET)/lib \
				-L $(SYSROOT_TARGET)/usr/lib \
				-L $(SYSROOT_TARGET)/usr/lib/$(TARGET_NAME)/$(GCC_VERSION)
COMPILE_OPTS  = -O2 -pipe -g -feliminate-unused-debug-types -fpermissive -Wall $(INCLUDE_DIRS) 

SYSROOT_TARGET = /opt/$(DISTRO)/1.4.2/sysroots/$(TARGET_NAME)/
SYSROOT_NATIVE = /opt/$(DISTRO)/1.4.2/sysroots/$(NATIVE_NAME)/

TOOLDIR = $(SYSROOT_NATIVE)/usr/bin/$(TARGET_NAME)

CC      = $(TOOLDIR)/i586-poky-linux-uclibc-g++
CXX     = $(CC)
AS      = $(CC)
LD      = $(CC)
AR      = $(TOOLDIR)/i586-poky-linux-uclibc-ar
CFLAGS  = $(COMPILE_OPTS)
CXXFLAGS= $(COMPILE_OPTS)
LDFLAGS = -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed $(LIBRARY_DIRS) -lstdc++

all: target

target: $(patsubst %.c,%.o,$(wildcard *.c)) $(patsubst %.cpp,%.o,$(wildcard *.cpp)) 
	$(LD) $(LDFLAGS) $(TARGET_ARCH) $^ -o $(TARGET_BIN)

clean:
	rm -f $(TARGET_BIN) *.o
