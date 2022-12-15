
As I am too stupid to think of a good solution for part 2,
I just iterate through all points and check if they are covered by an beacon.

This is done in part2.pl.

However, this Perl script could only check ~0.05 rows per second, so I rewrote it in C.
part2_make_struct.pl parses the input and generates the array structs holding the beacon information that is than used in the C program.

gcc -Wall -Wconversion -O2 -g -ansi -pedantic -std=gnu99 -march=native part2.c -o part2

This program can do ~ 40 rows per second, which is around 800x speedup over the Perl script.

multitheaded version in part2_threaded.c
gcc -Wall -Wconversion -O2 -g -ansi -pedantic -std=gnu99 -march=native part2_threaded.c -o part2_threaded -lpthread

Using 8 threads, it took around 3h16min!
Output:
x=3340224 y=3249595
