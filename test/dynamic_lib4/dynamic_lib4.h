#ifndef _DYNAMIC_LIB4_
#define _DYNAMIC_LIB4_

#include <dynamic_lib2.h>
#include <dynamic_lib1.h>

#if !defined(DYNAMIC_LIB4_IMPORT) && !defined(DYNAMIC_LIB4_INTERNAL)
#error See compile declarations -- !defined(DYNAMIC_LIB4_IMPORT) && !defined(DYNAMIC_LIB4_INTERNAL)
#endif

#if defined(DYNAMIC_LIB4_IMPORT) && defined(DYNAMIC_LIB4_INTERNAL)
#error See compile declarations -- defined(DYNAMIC_LIB4_IMPORT) && defined(DYNAMIC_LIB4_INTERNAL)
#endif


namespace dynamic_lib4
{
    void test();
}

#endif
