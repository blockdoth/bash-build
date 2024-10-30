rm ./build/main.c

cat "#define COMPILING" >> ./build/includes.c
find . -type f -path "./server/*.h" -print0 | awk '!seen[$0]++' | xargs -0 cat | grep -h '^#include'  | cpp -P - 2>/dev/null | cat >> ./build/includes.c

cat ./build/includes.c >> ./build/main.c
rm ./build/includes.c

find . -type f -path "./server/*.h" | xargs cat | grep -v '^#include' >> ./build/main.c
find . -type f -path "./server/*.c" | xargs cat | grep -v '^#include' >> ./build/main.c
cc -std=c2x -Wall -Wextra -Wno-error -O2 ./build/main.c -o ./build/main
./build/main