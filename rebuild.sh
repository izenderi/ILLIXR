# put in ILLIXR/build 
# run with sudo 

cmake --build . --target clean
cmake --build . -j4
cmake --build . -t docs 
cmake --install .