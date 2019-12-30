cmake_minimum_required (VERSION 3.11)

add_subdirectory(third_party)

project(ftxui-starter
  LANGUAGES CXX
  VERSION 1.0.0
)

add_executable(ftxui-starter src/main.cpp)
target_include_directories(ftxui-starter PRIVATE src)

target_link_libraries(ftxui-starter
  PRIVATE ftxui::screen
  PRIVATE ftxui::dom
  PRIVATE ftxui::component # Not needed for this example.
)

set_target_properties(ftxui-starter PROPERTIES CXX_STANDARD 11)
target_compile_options(ftxui-starter PRIVATE -Wall -Wextra -pedantic -Werror -W)

install(TARGETS ftxui-starter RUNTIME DESTINATION "bin")
