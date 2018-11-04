include(ExternalProject)

set(CMAKE_ARGS
  -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
  -DCMAKE_BUILD_TYPE=Release
  -DRANGE_V3_DOCS=OFF
  -DRANGE_V3_TESTS=OFF
  -DRANGE_V3_EXAMPLES=OFF
  -DRANGE_V3_PERF=OFF
  -DRANGE_V3_HEADER_CHECKS=OFF)

ExternalProject_Add(ranges-v3-project
  PREFIX deps/ranges-v3
  DOWNLOAD_NAME ranges-v3-0.4.1.tar.gz
  DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/downloads
  URL https://github.com/ericniebler/range-v3/archive/0.4.0.tar.gz
  PATCH_COMMAND cmake -E make_directory <SOURCE_DIR>/win32-deps/include
  CMAKE_ARGS ${CMAKE_ARGS}
  # Overwtire build and install commands to force Release build on MSVC.
  BUILD_COMMAND cmake --build <BINARY_DIR> --config Release
  INSTALL_COMMAND cmake --build <BINARY_DIR> --config Release --target install
  )


ExternalProject_Get_Property(ranges-v3-project INSTALL_DIR)
add_library(ranges-v3 INTERFACE IMPORTED)
set(RANGES_V3_INCLUDE_DIR ${INSTALL_DIR}/include)
file(MAKE_DIRECTORY ${RANGES_V3_INCLUDE_DIR})  # Must exist.
set_property(TARGET ranges-v3 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${RANGES_V3_INCLUDE_DIR})

unset(INSTALL_DIR)
unset(CMAKE_ARGS)
