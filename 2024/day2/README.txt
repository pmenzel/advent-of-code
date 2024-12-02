Part 1:

perl -lsane '@F = reverse(@F) if $F[$#F] < $F[0]; for($i=0;$i<$#F;$i++) { last if($F[$i+1] <= $F[$i] || $F[$i+1] - $F[$i] > 3) }  $s++ if $i==$#F; }{ print $s' input.txt


