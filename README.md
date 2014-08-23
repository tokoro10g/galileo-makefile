# galileo-makefile

A simple Makefile template to cross-compile C programs for Intel Galileo.  
(Sorry, for Linux only, for now.)

## Before You Begin

1. First, you have to download Galileo Arduino IDE from Intel website.  
  Drivers | Intel Communities  
  https://communities.intel.com/docs/DOC-22226

2. Extract archive.

3. Open console, then type:
```
$ cd /where/you/extracted/the/archive/arduino-1.5.3
$ cd hardware/tools/sysroots
$ sudo mkdir -p /opt/clanton-tiny/1.4.2/sysroots
$ sudo cp -R i586-poky-linux-uclibc /opt/clanton-tiny/1.4.2/sysroots/
$ sudo cp -R x86_64-pokysdk-linux /opt/clanton-tiny/1.4.2/sysroots/
```
It copies cross devtools from Arduino IDE.

## Compile Your C Programs

```
$ git clone https://github.com/tokoro10g/galileo-makefile.git
$ cp galileo-makefile/Makefile /path/to/your/project
$ cd /path/to/your/project
($ vim Makefile) // to modify
$ make
```

### Upload Executables to Your Galileo

You can use SSH(SCP) to transfer your files.  
For further information for connecting Galileo via SSH, refer to:  
https://communities.intel.com/thread/45332

### Example (Making "Hello, World")

```c
#include <stdio.h>
int main(int argc, char const* argv[])
{
	printf("Hello, World!\n");
	return 0;
}
```

```
$ make
/opt/clanton-tiny/1.4.2/sysroots/x86_64-pokysdk-linux//usr/bin/i586-poky-linux-uclibc/i586-poky-linux-uclibc-g++ -O2 -pipe -g -feliminate-unused-debug-types -fpermissive -Wall -I /opt/clanton-tiny/1.4.2/sysroots/i586-poky-linux-uclibc//usr/include -I /opt/clanton-tiny/1.4.2/sysroots/i586-poky-linux-uclibc//usr/include/c++ -I /opt/clanton-tiny/1.4.2/sysroots/x86_64-pokysdk-linux//usr/lib/i586-poky-linux-uclibc/gcc/i586-poky-linux-uclibc/4.7.2/include   -m32 -march=i586 --sysroot=/opt/clanton-tiny/1.4.2/sysroots/i586-poky-linux-uclibc/ -c -o helloworld.o helloworld.c
/opt/clanton-tiny/1.4.2/sysroots/x86_64-pokysdk-linux//usr/bin/i586-poky-linux-uclibc/i586-poky-linux-uclibc-g++ -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -L /opt/clanton-tiny/1.4.2/sysroots/i586-poky-linux-uclibc//lib -L /opt/clanton-tiny/1.4.2/sysroots/i586-poky-linux-uclibc//usr/lib -L /opt/clanton-tiny/1.4.2/sysroots/i586-poky-linux-uclibc//usr/lib/i586-poky-linux-uclibc/4.7.2 -lstdc++ -m32 -march=i586 --sysroot=/opt/clanton-tiny/1.4.2/sysroots/i586-poky-linux-uclibc/ helloworld.o -o helloworld

$ file helloworld
helloworld: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), BuildID[sha1]=bf9bf056d126d4c6b3c5f5565d2b398136d2afc3, not stripped
```

Copy the binary to your Galileo, then

```
root@clanton:~# chmod +x helloworld
root@clanton:~# ./helloworld 
Hello, World!
root@clanton:~#
```

## Link

Originally taken from here (my website in Japanese)  
http://wiki.tokor.org/index.php?Intel%A4%CEGalileo%A4%CEArduinoIDE%C9%D5%C2%B0%A4%CE%A5%AF%A5%ED%A5%B9%A5%B3%A5%F3%A5%D1%A5%A4%A5%E9%A4%F2%C8%B4%A4%AD%BD%D0%A4%B7%A4%C6%BB%C8%A4%A6%A1%A1-%A1%A1Galileo

## MIT Open Source License

Copyright 2014 Tokoro

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
