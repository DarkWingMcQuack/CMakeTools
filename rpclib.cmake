include(ExternalProject)

set(CMAKE_ARGS
  -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
  -DCMAKE_BUILD_TYPE=Release
  -DBUILD_STATIC_LIBS=ON
  -DBUILD_SHARED_LIBS=OFF
  -DRPCLIB_GENERATE_COMPDB=OFF
  -DRPCLIB_BUILD_EXAMPLES=OFF
  -DRPCLIB_ENABLE_LOGGING=OFF
  -DRPCLIB_ENABLE_COVERAGE=OFF
  -DRPCLIB_MSVC_STATIC_RUNTIME=OFF
  -DRPCLIB_BUILD_TESTS=OFF)

ExternalProject_Add(rpclib-project
  PREFIX deps/rpclib
  DOWNLOAD_NAME rpclib-2.2.1.tar.gz
  DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/downloads
  URL https://github.com/rpclib/rpclib/archive/v2.2.1.tar.gz
  CMAKE_ARGS ${CMAKE_ARGS}
  # Overwtire build and install commands to force Release build on MSVC.
  BUILD_COMMAND cmake --build <BINARY_DIR> --config Release
  INSTALL_COMMAND cmake --build <BINARY_DIR> --config Release --target install
  )

ExternalProject_Get_Property(rpclib-project INSTALL_DIR)
add_library(rpclib STATIC IMPORTED)
set(RPCLIB_LIBRARY ${INSTALL_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}rpc${CMAKE_STATIC_LIBRARY_SUFFIX})
set(RPCLIB_INCLUDE_DIR ${INSTALL_DIR}/include)
file(MAKE_DIRECTORY ${RPCLIB_INCLUDE_DIR})  # Must exist.
set_property(TARGET rpclib PROPERTY IMPORTED_LOCATION ${RPCLIB_LIBRARY})
set_property(TARGET rpclib PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${RPCLIB_INCLUDE_DIR})

unset(INSTALL_DIR)
unset(CMAKE_ARGS)
