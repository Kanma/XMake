#ifndef _DYNAMIC_LIB1_
#define _DYNAMIC_LIB1_

#include <static_lib1.h>

#if !defined(DYNAMIC_LIB1_IMPORT) && !defined(DYNAMIC_LIB1_INTERNAL)
#error See compile declarations -- !defined(DYNAMIC_LIB1_IMPORT) && !defined(DYNAMIC_LIB1_INTERNAL)
#endif

#if defined(DYNAMIC_LIB1_IMPORT) && defined(DYNAMIC_LIB1_INTERNAL)
#error See compile declarations -- defined(DYNAMIC_LIB1_IMPORT) && defined(DYNAMIC_LIB1_INTERNAL)
#endif


namespace dynamic_lib1
{
    void test();
}

#endif
