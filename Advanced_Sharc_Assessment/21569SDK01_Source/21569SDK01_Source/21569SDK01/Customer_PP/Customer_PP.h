#include "../src/System/Include/Commn.h"
#include <builtins.h>

section("seg_CustomerPP_dmda")
#ifdef FLOAT
        float CustomerPP_Buffer[NO_OF_SAMPLE_PROCESSING*24];
#else
         int CustomerPP_Buffer[NO_OF_SAMPLE_PROCESSING*24];
#endif

