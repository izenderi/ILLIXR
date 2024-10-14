#!/bin/bash

# run with sudo 

cd build
cmake --build . -j$(nproc)
cmake --install .
