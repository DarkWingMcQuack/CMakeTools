if(GENERATE_COMPDB)
  set(CMAKE_EXPORT_COMPILE_COMMANDS "ON")
  add_custom_command(PROJECT_NAME ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E
    copy ${CMAKE_BINARY_DIR}/compile_commands.json ${CMAKE_BINARY_DIR}/../compile_commands.json)
endif()
