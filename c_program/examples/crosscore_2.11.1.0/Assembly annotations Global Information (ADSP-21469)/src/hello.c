/* Copyright (c) 2011-2012 Analog Devices, Inc. All Rights Reserved.
**
** An example of the global information produced by the compiler
** within the generated assembly file.
**
** As with all other files, when this file is compiled, the compiler
** will produce information in the assembly file to indicate:
** - The compilation time
** - the compiler options
** - The architecture of the target processor.
** - The silicon revision of the target processor.
** - Information about silicon anomaly workarounds:
**   - which are never enabled
**   - which were disabled
**   - which were enabled
**   - which are always enabled
**
** Debug Configuration: Debug/src/hello.s contains the annotations.
** Release Configuration: Release/src/hello.s contains the annotations.
**
** For more information, refer to "Assembly Optimizer Annotations,"
** "Global Information", in Chapter 2 of the C/C++ Compiler Manual.
*/

#include <stdio.h>

int main(void) {
  printf("Hello world\n");
  return 0;
}

