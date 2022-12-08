
to slice from a 2D array:
map $array[$_][4], 2..5
will return an array containing the elements 2 to 5 of column 4 from @array


Part 1:

perl -M'List::Util qw/all/' -F'' -lane 'push(@m,[@F]); }{ for $i (1..$#m-1){ for $j (1..$#m-1){ (all { $_ < $m[$i][$j] } map $m[$i][$_], 0..$j-1 ) ? $h{"$i $j"}=1 : "" }; for $j (1..$#m-1){ (all { $_ < $m[$j][$i] } map $m[$_][$i],0..$j-1) ? $h{"$j $i"}=1 : "" } for($j=$#m-1;$j>0;$j--){ (all { $_ < $m[$i][$j] } map $m[$i][$_], $j+1..$#m ) ? $h{"$i $j"}=1 : "" }; for($j=$#m-1;$j>0;$j--){   (all { $_ < $m[$j][$i] } map $m[$_][$i], $j+1..$#m) ? $h{"$j $i"}=1 : "" }  }  map { if($h{$_}==1) { $count++} } sort keys %h;  print $count + 4*$#m;' input.txt

using the same approach as in part 2:
perl -M'List::MoreUtils qw/none/' -F'' -lane 'push(@m,[@F]); }{ for $i (1..$#m-1){ for $j (1..$#m-1){ $v=$m[$i][$j]; $c++ if none { $_ >= $v } map $m[$i][$_], 0..$j-1 or none { $_ >= $v } map $m[$i][$_], $j+1..$#m or none { $_ >= $v } map $m[$_][$j], 0..$i-1 or none { $_ >= $v } map $m[$_][$j], $i+1..$#m }} print $c+4*$#m' input.txt

#shorter:
perl -M'List::MoreUtils qw/none/' -F'' -lane 'push(@m,[@F]); }{ for $i (0..$#m){ for $j (0..$#m){ $v=$m[$i][$j]; $c++ if none { $_ >= $v } map $m[$i][$_], 0..$j-1 or none { $_ >= $v } map $m[$i][$_], $j+1..$#m or none { $_ >= $v } map $m[$_][$j], 0..$i-1 or none { $_ >= $v } map $m[$_][$j], $i+1..$#m }} print $c' input.txt

# --------------------------------------------------------------------------------------------------------

Part 2:

# iterate through all matrix elements and calculate the first index of equal or higher values in each direction
# the trees at the sides produce 0 as values, so the code would not work if one of them would be the solution
# -> turns out that this is true regardless for trees at the side, from the instructions:
#    "If a tree is right on the edge, at least one of its viewing distances will be zero."

perl -M'List::MoreUtils qw/firstidx/' -F'' -lane 'push(@m,[@F]); }{ for $i (0..$#m){ for $j (0..$#m){print "Testing $i $j=";$c=1; $v=$m[$i][$j]; $x = firstidx {$_>=$v} map $m[$i][$_],reverse 0..$j-1; $c *= ($x==-1)?$j:$x+1;     $x = firstidx {$_>=$v} map $m[$i][$_],$j+1..$#m; $c *= ($x==-1)?$#m-$j:$x+1;     $x = firstidx {$_>=$v} map $m[$_][$j],reverse 0..$i-1; $c *= ($x==-1)?$i:$x+1;         $x = firstidx {$_>=$v} map $m[$_][$j],$i+1..$#m; $c *= ($x==-1)?$#m-$i:$x+1;               print $c;  } } ' input.txt|grep -v Testing | sort -n | tail -n 1

# shorter:
perl -M'List::MoreUtils qw/firstidx/' -F'' -lane 'push(@m,[@F]); }{ for $i (0..$#m){ for $j (0..$#m){$c=1; $v=$m[$i][$j]; $x = firstidx {$_>=$v} map $m[$i][$_],reverse 0..$j-1; $c *= ($x==-1)?$j:$x+1; $x = firstidx {$_>=$v} map $m[$i][$_],$j+1..$#m; $c *= ($x==-1)?$#m-$j:$x+1; $x = firstidx {$_>=$v} map $m[$_][$j],reverse 0..$i-1; $c *= ($x==-1)?$i:$x+1; $x = firstidx {$_>=$v} map $m[$_][$j],$i+1..$#m; $c *= ($x==-1)?$#m-$i:$x+1; print $c; }}' input.txt | sort -n | tail -n1


