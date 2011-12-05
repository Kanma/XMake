#ifndef _DYNAMIC_LIB3_
#define _DYNAMIC_LIB3_

#include <dynamic_lib2.h>

#if !defined(DYNAMIC_LIB3_IMPORT) && !defined(DYNAMIC_LIB3_INTERNAL)
#error See compile declarations -- !defined(DYNAMIC_LIB3_IMPORT) && !defined(DYNAMIC_LIB3_INTERNAL)
#endif

#if defined(DYNAMIC_LIB3_IMPORT) && defined(DYNAMIC_LIB3_INTERNAL)
#error See compile declarations -- defined(DYNAMIC_LIB3_IMPORT) && defined(DYNAMIC_LIB3_INTERNAL)
#endif


namespace dynamic_lib3
{
    void test();
}

#endif
