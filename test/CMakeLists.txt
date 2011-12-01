cmake_minimum_required(VERSION 2.6)
PROJECT(XMAKE_TEST)

set(CMAKE_MODULE_PATH "${XMAKE_TEST_SOURCE_DIR}/..")
include(XMake)

message(STATUS "XMAKE_VERSION: ${XMAKE_VERSION}")


###############################################

xmake_init_static(PROJECT1)

xmake_add_include_paths(PROJECT1 "project1/include")
xmake_add_include_paths(PROJECT1 "project1/include/win32" "project1/include/posix")

xmake_add_link_paths(PROJECT1 "project1/lib")
xmake_add_link_paths(PROJECT1 "project1/lib/win32" "project1/lib/posix")

xmake_display(PROJECT1)


###############################################

xmake_init_dynamic(PROJECT2)

xmake_add_include_paths(PROJECT2 "project2/include")
xmake_add_link_paths(PROJECT2 "project2/lib")
xmake_add_link_targets(PROJECT2 Project2 Project1)

xmake_add_compile_definitions(PROJECT2 "-DDOUBLE_PRECISION=1" "-DTHREADING=0")

xmake_display(PROJECT2)


###############################################

xmake_init_framework(PROJECT3)

xmake_add_include_paths(PROJECT3 "project3/include")
xmake_add_link_paths(PROJECT3 "project3/lib")
xmake_add_link_flags(PROJECT3 "-Fproject3/bin" "-framework Project3")

xmake_display(PROJECT3)


###############################################

xmake_add_subdirectory("${XMAKE_TEST_SOURCE_DIR}/subdirectory")
