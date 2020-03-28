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

# C++17 is used. We requires fold expressions at least.
set_target_properties(ftxui-starter PROPERTIES CXX_STANDARD 17)

# Set agressive warning options:
if (MSVC)
  target_compile_options(ftxui-starter PRIVATE "/W4")
  target_compile_options(ftxui-starter PRIVATE "/WX")
else()
  target_compile_options(ftxui-starter PRIVATE "-Wall")
  target_compile_options(ftxui-starter PRIVATE "-Wextra")
  target_compile_options(ftxui-starter PRIVATE "-pedantic")
  target_compile_options(ftxui-starter PRIVATE "-Werror")
  target_compile_options(ftxui-starter PRIVATE "-Wno-sign-compare")
endif()

install(TARGETS ftxui-starter RUNTIME DESTINATION "bin")
