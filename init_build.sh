#!/bin/bash

rm -rf build/ && mkdir build && cd build

# when you obtained the data.zip file, you copy it to repo root and use below:
# rm -rf build/ && mkdir build && cp data.zip ./build && cd build

cmake .. -DCMAKE_BUILD_TYPE=Debug -DYAML_FILE=profiles/native_gl.yaml
cmake --build . -j$(nproc)
cmake --build . -t docs
cmake --install .
