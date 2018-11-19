# additional target to perform clang-format run, requires clang-format

# get all project files
file (GLOB_RECURSE SOURCE_FILES "src/*.cpp" "include/*.hpp")

add_custom_target(
  clangformat
  COMMAND clang-format
  -style=file
  -i
  ${SOURCE_FILES}
  )
