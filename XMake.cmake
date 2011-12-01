################################################################################
#
# XMake script
#
# See http://www.idiap.ch/~pabbet/articles/combining-git-submodules-and-cmake-for-library-development/
# for details
#
################################################################################


# Set the value of a variable
function(xmake_set VARIABLE VALUE)
    set(${VARIABLE} ${VALUE} CACHE INTERNAL "" FORCE)
endfunction()


# Initialise a new static library
function(xmake_init_static PROJECT)
    xmake_set(XMAKE_${PROJECT}_INCLUDE_PATHS "")
    xmake_set(XMAKE_${PROJECT}_LINK_PATHS "")
    xmake_set(XMAKE_${PROJECT}_COMPILE_DEFINITIONS "")
    xmake_set(XMAKE_${PROJECT}_LINK_FLAGS "")
    xmake_set(XMAKE_${PROJECT}_LINK_TARGETS "")
    xmake_set(XMAKE_${PROJECT}_STATIC_LIBRARY YES)
    xmake_set(XMAKE_${PROJECT}_DYNAMIC_LIBRARY NO)
    xmake_set(XMAKE_${PROJECT}_FRAMEWORK NO)
endfunction()


# Initialise a new dynamic library
function(xmake_init_dynamic PROJECT)
    xmake_set(XMAKE_${PROJECT}_INCLUDE_PATHS "")
    xmake_set(XMAKE_${PROJECT}_LINK_PATHS "")
    xmake_set(XMAKE_${PROJECT}_COMPILE_DEFINITIONS "")
    xmake_set(XMAKE_${PROJECT}_LINK_FLAGS "")
    xmake_set(XMAKE_${PROJECT}_LINK_TARGETS "")
    xmake_set(XMAKE_${PROJECT}_STATIC_LIBRARY NO)
    xmake_set(XMAKE_${PROJECT}_DYNAMIC_LIBRARY YES)
    xmake_set(XMAKE_${PROJECT}_FRAMEWORK NO)
endfunction()


# Initialise a new framework
function(xmake_init_framework PROJECT)
    xmake_set(XMAKE_${PROJECT}_INCLUDE_PATHS "")
    xmake_set(XMAKE_${PROJECT}_LINK_PATHS "")
    xmake_set(XMAKE_${PROJECT}_COMPILE_DEFINITIONS "")
    xmake_set(XMAKE_${PROJECT}_LINK_FLAGS "")
    xmake_set(XMAKE_${PROJECT}_LINK_TARGETS "")
    xmake_set(XMAKE_${PROJECT}_STATIC_LIBRARY NO)
    xmake_set(XMAKE_${PROJECT}_DYNAMIC_LIBRARY NO)
    xmake_set(XMAKE_${PROJECT}_FRAMEWORK YES)
endfunction()


# Add some include paths to a XMake project
function(xmake_add_include_paths PROJECT PATH1)

    set(PATHS ${XMAKE_${PROJECT}_INCLUDE_PATHS})
    list(APPEND PATHS ${PATH1})

    foreach(CURRENT_PATH ${ARGN})
        list(APPEND PATHS ${CURRENT_PATH})
    endforeach()

    xmake_set(XMAKE_${PROJECT}_INCLUDE_PATHS "${PATHS}")
endfunction()


# Add the include paths of a XMake project to the scope
function(xmake_include_directories PROJECT)
    foreach (CURRENT_PATH ${XMAKE_${PROJECT}_INCLUDE_PATHS})
        include_directories("${CURRENT_PATH}")
    endforeach()
endfunction()


# Add some libraries paths to a XMake project
function(xmake_add_link_paths PROJECT PATH1)

    set(PATHS ${XMAKE_${PROJECT}_LINK_PATHS})
    list(APPEND PATHS ${PATH1})

    foreach(CURRENT_PATH ${ARGN})
        list(APPEND PATHS ${CURRENT_PATH})
    endforeach()

    xmake_set(XMAKE_${PROJECT}_LINK_PATHS "${PATHS}")
endfunction()


# Add the libraries paths of a XMake project to the scope
function(xmake_link_directories PROJECT)
    foreach (CURRENT_PATH ${XMAKE_${PROJECT}_LINK_PATHS})
        link_directories("${CURRENT_PATH}")
    endforeach()
endfunction()


# Add some compile definitions to a XMake project
function(xmake_add_compile_definitions PROJECT DEFINITION1)

    set(DEFINITIONS ${XMAKE_${PROJECT}_COMPILE_DEFINITIONS})

    if (DEFINITIONS)
        set(DEFINITIONS "${DEFINITIONS} ${DEFINITION1}")
    else()
        set(DEFINITIONS "${DEFINITION1}")
    endif()

    foreach(CURRENT_DEFINITION ${ARGN})
        set(DEFINITIONS "${DEFINITIONS} ${CURRENT_DEFINITION}")
    endforeach()

    xmake_set(XMAKE_${PROJECT}_COMPILE_DEFINITIONS "${DEFINITIONS}")
endfunction()


# Add some link flags to a XMake project
function(xmake_add_link_flags PROJECT FLAGS1)

    set(FLAGS ${XMAKE_${PROJECT}_LINK_FLAGS})

    if (FLAGS)
        set(FLAGS "${FLAGS} ${FLAGS1}")
    else()
        set(FLAGS "${FLAGS1}")
    endif()

    foreach(CURRENT_FLAGS ${ARGN})
        set(FLAGS "${FLAGS} ${CURRENT_FLAGS}")
    endforeach()

    xmake_set(XMAKE_${PROJECT}_LINK_FLAGS "${FLAGS}")
endfunction()


# Add some link targets to a XMake project
function(xmake_add_link_targets PROJECT TARGET1)

    set(TARGETS ${XMAKE_${PROJECT}_LINK_TARGETS})
    list(APPEND TARGETS ${TARGET1})

    foreach(CURRENT_TARGET ${ARGN})
        list(APPEND TARGETS ${CURRENT_TARGET})
    endforeach()

    xmake_set(XMAKE_${PROJECT}_LINK_TARGETS "${TARGETS}")
endfunction()


# Link the 'link targets' of a XMake project to a target
function(xmake_target_link_libraries TARGET PROJECT)
    foreach (CURRENT_LIBRARY ${XMAKE_${PROJECT}_LINK_TARGETS})
        target_link_libraries(${TARGET} "${CURRENT_LIBRARY}")
        add_dependencies(${TARGET} "${CURRENT_LIBRARY}")
    endforeach()
endfunction()


# Add a subdirectory to the build, but not if there is no CMakeLists.txt file
# in it (which might happen when using several cascaded submodules with XMake)
function(xmake_add_subdirectory ABSOLUTE_SOURCE_DIR)
    if (EXISTS "${ABSOLUTE_SOURCE_DIR}/CMakeLists.txt")
        add_subdirectory("${ABSOLUTE_SOURCE_DIR}")
    endif()
endfunction()


# Display all the XMake settings of a project
function(xmake_display PROJECT)
    
    set(TEXT "\n--------------------------------------------------------------------------------\n")
    set(TEXT "${TEXT}XMake settings for '${PROJECT}':\n")

    if (XMAKE_${PROJECT}_INCLUDE_PATHS)
        set(TEXT "${TEXT}  Include paths:       ${XMAKE_${PROJECT}_INCLUDE_PATHS}\n")
    endif()

    if (XMAKE_${PROJECT}_LINK_PATHS)
        set(TEXT "${TEXT}  Linking paths:       ${XMAKE_${PROJECT}_LINK_PATHS}\n")
    endif()

    if (XMAKE_${PROJECT}_COMPILE_DEFINITIONS)
        set(TEXT "${TEXT}  Compile definitions: ${XMAKE_${PROJECT}_COMPILE_DEFINITIONS}\n")
    endif()
    
    if (XMAKE_${PROJECT}_LINK_FLAGS)
        set(TEXT "${TEXT}  Linking flags:       ${XMAKE_${PROJECT}_LINK_FLAGS}\n")
    endif()

    if (XMAKE_${PROJECT}_LINK_TARGETS)
        set(TEXT "${TEXT}  Link targets:        ${XMAKE_${PROJECT}_LINK_TARGETS}\n")
    endif()

    if (XMAKE_${PROJECT}_STATIC_LIBRARY)
        set(TEXT "${TEXT}  Library:             STATIC\n")
    endif()

    if (XMAKE_${PROJECT}_DYNAMIC_LIBRARY)
        set(TEXT "${TEXT}  Library:             DYNAMIC\n")
    endif()

    if (XMAKE_${PROJECT}_FRAMEWORK)
        set(TEXT "${TEXT}  Library:             FRAMEWORK\n")
    endif()

    set(TEXT "${TEXT}--------------------------------------------------------------------------------\n")

    message(STATUS "${TEXT}")

endfunction()


xmake_set(XMAKE_VERSION "1.1")
