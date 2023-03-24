cmake_minimum_required (VERSION 3.11)

project(ftxui-starter
  LANGUAGES CXX
  VERSION 1.0.0
)

set(tool_dest "bin")

# --- Fetch FTXUI --------------------------------------------------------------
# Fetch only if not already populated
if (NOT ftxui_POPULATED)
    include(FetchContent)

    FetchContent_Declare(ftxui
            GIT_REPOSITORY https://github.com/ArthurSonzogni/ftxui
            GIT_TAG v4.0.0
            )

    FetchContent_GetProperties(ftxui)

    FetchContent_Populate(ftxui)
    add_subdirectory(${ftxui_SOURCE_DIR} ${ftxui_BINARY_DIR} EXCLUDE_FROM_ALL)
else ()
    # require ftxui package if already populated
    find_package(ftxui REQUIRED)
endif ()
# ------------------------------------------------------------------------------

add_executable(ftxui-starter src/main.cpp)
target_include_directories(ftxui-starter PRIVATE src)

target_link_libraries(ftxui-starter
  PRIVATE ftxui::screen
  PRIVATE ftxui::dom
  PRIVATE ftxui::component # Not needed for this example.
)

if (EMSCRIPTEN) 
  string(APPEND CMAKE_CXX_FLAGS " -s USE_PTHREADS") 
  string(APPEND CMAKE_EXE_LINKER_FLAGS " -s ASYNCIFY") 
  string(APPEND CMAKE_EXE_LINKER_FLAGS " -s PROXY_TO_PTHREAD") 

  foreach(file "index.html" "run_webassembly.py")
    configure_file("src/${file}" ${file})
  endforeach(file)
endif() 

install(TARGETS ftxui-starter DESTINATION "${tool_dest}")

