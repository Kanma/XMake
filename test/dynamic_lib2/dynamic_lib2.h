#ifndef _DYNAMIC_LIB2_
#define _DYNAMIC_LIB2_

#if !defined(DYNAMIC_LIB2_IMPORT) && !defined(DYNAMIC_LIB2_INTERNAL)
#error See compile declarations -- !defined(DYNAMIC_LIB2_IMPORT) && !defined(DYNAMIC_LIB2_INTERNAL)
#endif

#if defined(DYNAMIC_LIB2_IMPORT) && defined(DYNAMIC_LIB2_INTERNAL)
#error See compile declarations -- defined(DYNAMIC_LIB2_IMPORT) && defined(DYNAMIC_LIB2_INTERNAL)
#endif


namespace dynamic_lib2
{
    void test();
}

#endif
