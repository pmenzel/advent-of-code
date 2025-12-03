Part 1:

perl -lne '$max=0; chomp; @F=split(//,$_); for($i=0;$i<$#F;$i++) { for($j=$i+1;$j<=$#F;$j++) { $t = $F[$i].$F[$j]; if($t > $max) { $max = $t; }}} print "line max = $max"; $s+=$max; }{ print $s' input.txt
