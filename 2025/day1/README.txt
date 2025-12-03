part 1:

cat input.txt| perl -ne 'BEGIN{$c=50}; if(/L(\d+)/) { $x = $1 % 100; $c-=$x; $c = 100 + $c if $c < 0; print "$c\n"; } elsif(/R(\d+)/) { $x = $1 % 100; $c+=$x; $c = $c - 100 if $c > 99; print "$c\n"; } $cnt0++ if $c == 0; }{ print "count = $cnt0";'

