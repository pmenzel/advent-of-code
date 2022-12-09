Part 1:

No one-liner this time.
Was trying to exhaustively write down all positions of H and T where T needs to be updated in a lot of if-statements.
Run with:

perl part1.pl input.txt


It could also be simpler: just check if H is no longer adjacent to T, and then move T to the previous positon of H
not my idea though, but from: https://www.reddit.com/r/adventofcode/comments/zgwhh1/2022_day_9_part_2_cant_believe_i_didnt_see_that/izj9ade/

perl -lne 'BEGIN{@H=(0,0);@T=(0,0)} /(\w) (\d+)/; for $i (1..$2) { @pH = @H; if($1 eq "R") {$H[1]++}; if($1 eq "L") {$H[1]--}; if($1 eq "U") {$H[0]++}; if($1 eq "D") {$H[0]--}; if(abs($H[0]-$T[0])>1 or abs($H[1]-$T[1])>1){ @T=@pH } $h{"@T"}=1 } }{ print scalar keys %h;' input.txt


Part 1:

Turns out that my solutions for part 1 are not expandable for part 2 -,-
