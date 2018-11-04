
############################
###tinyxml2
############################
include(GNUInstallDirs)
include(ExternalProject)

set(CMAKE_ARGS
  -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
  -DCMAKE_BUILD_TYPE=Release
  -DBUILD_STATIC_LIBS=ON
  -DBUILD_SHARED_LIBS=OFF)

ExternalProject_Add(tinyxml2-project
  PREFIX deps/tinyxml2
  DOWNLOAD_NAME tinyxml2-6.2.0.tar.gz
  DOWNLOAD_DIR ${CMAKE_BINARY_DIR}/downloads
  URL https://github.com/leethomason/tinyxml2/archive/6.2.0.tar.gz
  PATCH_COMMAND cmake -E make_directory <SOURCE_DIR>/win32-deps/include
  CMAKE_ARGS ${CMAKE_ARGS}
  # Overwtire build and install commands to force Release build on MSVC.
  BUILD_COMMAND cmake --build <BINARY_DIR> --config Release
  INSTALL_COMMAND cmake --build <BINARY_DIR> --config Release --target install
  )


ExternalProject_Get_Property(tinyxml2-project INSTALL_DIR)
add_library(tinyxml2 STATIC IMPORTED)
set(TINYXML2_LIBRARY ${INSTALL_DIR}/${CMAKE_INSTALL_LIBDIR}/${CMAKE_STATIC_LIBRARY_PREFIX}tinyxml2${CMAKE_STATIC_LIBRARY_SUFFIX})
set(TINYXML2_INCLUDE_DIR ${INSTALL_DIR}/include)
file(MAKE_DIRECTORY ${TINYXML2_INCLUDE_DIR})  # Must exist.
set_property(TARGET tinyxml2 PROPERTY IMPORTED_LOCATION ${TINYXML2_LIBRARY})
set_property(TARGET tinyxml2 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${TINYXML2_INCLUDE_DIR})

unset(INSTALL_DIR)
unset(CMAKE_ARGS)
