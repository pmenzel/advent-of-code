part 1:

cat input.txt | perl -F'\|' -sane '$c=0; while($F[0]=~/(\d+)[^:\d]/g) {$n=$1;if($F[1]=~/\b($n)\b/){ $c++; print "$n=$1 ";}} next unless $c; $s=2**($c-1) ; print "$_ = $s\n"; $S+=$s; }{ print $S'

without debug print()s:

cat input.txt | perl -F'\|' -sane '$c=0; while($F[0]=~/(\d+)[^:\d]/g) {$c++ if($F[1]=~/\b($1)\b/)} next unless $c; $s=2**($c-1); $S+=$s; }{ print $S'

