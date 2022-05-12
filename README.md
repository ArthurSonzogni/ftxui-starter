ftxui-starter
-------------

[![Snap Status](https://build.snapcraft.io/badge/ArthurSonzogni/ftxui-starter.svg)](https://build.snapcraft.io/user/ArthurSonzogni/ftxui-starter)

[![Build Status](https://travis-ci.com/ArthurSonzogni/ftxui-starter.svg?branch=master)](https://travis-ci.com/ArthurSonzogni/ftxui-starter)

Minimal starter project using the [FTXUI library](https://github.com/ArthurSonzogni/ftxui)


# Build instructions:
~~~bash
mkdir build
cd build
cmake ..
make -j
cd ../target
./ftxui-starter
~~~

## Webassembly build:
~~~bash
mkdir build_emscripten && cd build_emscripten
emcmake cmake ..
make -j
./run_webassembly.py
(visit localhost:8000)
~~~

## Linux snap build:
Upload your game to github and visit https://snapcraft.io/build.
