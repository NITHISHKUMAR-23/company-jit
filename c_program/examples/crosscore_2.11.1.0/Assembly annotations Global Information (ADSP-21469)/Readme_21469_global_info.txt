            CrossCore(R) Embedded Studio for Analog Devices Processors Compiler Example

Project Name: global_info

Description: Shows the global information produced by the compiler within the
             assembly file.

    
Processor:
=============
    ADSP-21469


Tested with:
====================
    ADSP-21469 Simulator
    CrossCore Embedded Studio for Analog Devices Processors Rev 1.0.1


Overview:
=========
    An example of the global information produced by the compiler
    within the generated assembly file.
   
    As with all other files, when file hello.c is compiled, the compiler
    will produce information in the assembly file to indicate:
    - The compilation time
    - the compiler options
    - The architecture of the target processor.
    - The silicon revision of the target processor.
    - Information about silicon anomaly workarounds:
      - which are never enabled
      - which were disabled
      - which were enabled
      - which are always enabled
   
    Debug Configuration: Debug/src/hello.s contains the annotations.
    Release Configuration: Release/src/hello.s contains the annotations.

    For more information, refer to "Assembly Optimizer Annotations,"
    "Global Information", in Chapter 2 of the C/C++ Compiler Manual.



User Configuration Macros:
==========================
    None.


Hardware Setup:
===============
    Use default software switch settings.

External connections:
=====================
    None

            
References:
===========
    C/C++ Compiler Manual for SHARC Processors.
