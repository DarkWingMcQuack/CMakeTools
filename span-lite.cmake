include(ExternalProject)

set(CMAKE_ARGS
  -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
  -DCMAKE_BUILD_TYPE=Release
  -DSPAN_LITE_OPT_BUILD_TESTS=OFF
  -DSPAN_LITE_OPT_BUILD_EXAMPLES=OFF
  -DRING_SPAN_LITE_COLOURISE_TEST=OFF)

ExternalProject_Add(span-lite-project
  PREFIX deps/span-lite
  DOWNLOAD_NAME span-lite-0.3.0.tar.gz
  DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/downloads
  URL https://github.com/martinmoene/span-lite/archive/v0.3.0.tar.gz
  PATCH_COMMAND cmake -E make_directory <SOURCE_DIR>/win32-deps/include
  CMAKE_ARGS ${CMAKE_ARGS}
  # Overwtire build and install commands to force Release build on MSVC.
  BUILD_COMMAND ""
  INSTALL_COMMAND cmake -E copy_directory <SOURCE_DIR>/include/ <INSTALL_DIR>/include
  )


ExternalProject_Get_Property(span-lite-project INSTALL_DIR)
add_library(span-lite INTERFACE IMPORTED)
set(SPAN-LITE_INCLUDE_DIR ${INSTALL_DIR}/include)
file(MAKE_DIRECTORY ${SPAN-LITE_INCLUDE_DIR})  # Must exist.
set_property(TARGET span-lite PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${SPAN-LITE_INCLUDE_DIR})

unset(INSTALL_DIR)
unset(CMAKE_ARGS)
