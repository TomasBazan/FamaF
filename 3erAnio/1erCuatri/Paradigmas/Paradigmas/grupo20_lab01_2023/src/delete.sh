#!/usr/bin/bash

echo "Deleting the .o and .hi files"

rm -r *.o *.hi
rm -r Dibujos/*.o Dibujos/*.hi
rm -r Tests/*.o Tests/*.hi
rm Main
rm test
rm Test

echo "All files deleted... watch:"

ls
ls Dibujos/
echo "you'r welcome"
git status
