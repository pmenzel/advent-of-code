
part1.pl converts the target lights and buttons to integers and prints them as input for part1.c


gcc -Wall -Wconversion -O2 -g -ansi -pedantic -std=gnu99 part1.c -o part1

cat input.txt| perl part1.pl 2>/dev/null | ./part1


