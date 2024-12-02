
Part 1:

perl -F, -lsane 'map { $s=0; map { $s+=ord($_); $s*=17; $s%=256; } split(//,$_); $S+=$s; } @F }{ print $S;' input.txt


