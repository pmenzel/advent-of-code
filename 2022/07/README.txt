Part 1:

# use a stack to keep track of current folder
# store the full path for each folder in a hash (folder names are not unique)

cat input.txt | perl -lne 'BEGIN{$/="\$"} if(/cd (.*)/) { if($1 eq "..") { pop(@names) } else { push(@names,$1)}} else { while(/(\d+)/sg){ map {@x=@names[0..$_]; $s{"@x"}+=$1} 0..$#names;}} }{ for $k (keys %s) {print "$k=$s{$k}"; $sum += $s{$k} if ($s{$k} <= 1e5)}; print "sum=$sum"'

# shorter

cat input.txt | perl -lne 'BEGIN{$/="\$"} if(/cd (.*)/) { if($1 eq "..") { pop(@n) } else { push(@n,$1)}} else { while(/(\d+)/sg){ map {$s{"@n[0..$_]"}+=$1} 0..$#n;}} }{ for $k (keys %s) {$sum += $s{$k} if ($s{$k} <= 1e5)}; print "sum=$sum"'
cat input.txt | perl -0044 -lne 'if(/cd (.*)/) { if($1 eq "..") { pop(@n) } else { push(@n,$1)}} else { while(/(\d+)/sg){ map {$s{"@n[0..$_]"}+=$1} 0..$#n;}} }{ for $k (keys %s) {$sum += $s{$k} if ($s{$k} <= 1e5)}; print "sum=$sum"'
cat input.txt | perl -0044 -lne 'if(/cd (.*)/) { if($1 eq "..") { pop(@n) } else { push(@n,$1)}} else { while(/(\d+)/sg){ map {$s{"@n[0..$_]"}+=$1} 0..$#n;}} }{ map {$sum += $s{$_} if ($s{$_} <= 1e5)} keys %s; print "sum=$sum"'
perl -0044 -lne 'if(/cd (.*)/) { $1 eq ".." ? pop(@n) : push(@n,$1) } else { while(/(\d+)/sg){ map {$s{"@n[0..$_]"}+=$1} 0..$#n;} } }{ map {$sum += $s{$_} if ($s{$_} <= 1e5)} keys %s; print "sum=$sum"' input.txt
perl -0044 -lne 'if(/cd (.*)/) { $1 eq ".." ? pop(@n) : push(@n,$1) } else { while(/\d+/sg){ map {$s{"@n[0..$_]"}+=$&} 0..$#n;} } }{ map {$sum += $s{$_} if ($s{$_} <= 1e5)} keys %s; print "sum=$sum"' input.txt
perl -lne 'if(/cd (.*)/) { $1 eq ".." ? pop(@n) : push(@n,$1) } else { if(/^\d+/){ map {$s{"@n[0..$_]"}+=$&} 0..$#n;} } }{ map {$sum += $s{$_} if ($s{$_} <= 1e5)} keys %s; print "sum=$sum"' input.txt

# --------------------------------------------------------------------------------------------------------
Part 2:

cat input.txt | perl -lne 'BEGIN{$/="\$"} if(/cd (.*)/) { if($1 eq "..") { pop(@n) } else { push(@n,$1)}} else { while(/(\d+)/sg){ map {@x=@n[0..$_]; $s{"@x"}+=$1} 0..$#n;}} }{ print 7e7 - $s{"/"}; $t=3e7-(7e7-$s{"/"}); print $t; for $k (sort {$s{$a}<=>$s{$b}} keys %s) { print "$k=$s{$k}"; if($s{$k}>=$t) { print $s{$k}; last;}  }'

# shorter:
cat input.txt | perl -lne 'BEGIN{$/="\$"} if(/cd (.*)/) { if($1 eq "..") { pop(@n) } else { push(@n,$1) } } else { while(/(\d+)/sg){ map {$s{"@n[0..$_]"}+=$1} 0..$#n;} } }{ $t=3e7-(7e7-$s{"/"}); for $k (sort {$s{$a}<=>$s{$b}} keys %s) { if($s{$k}>=$t) { print $s{$k}; last;}}'
cat input.txt | perl -0044 -lne 'if(/cd (.*)/) { if($1 eq "..") { pop(@n) } else { push(@n,$1) } } else { while(/(\d+)/sg){ map {$s{"@n[0..$_]"}+=$1} 0..$#n;} } }{ $t=3e7-(7e7-$s{"/"}); for $k (sort {$s{$a}<=>$s{$b}} keys %s) { if($s{$k}>=$t) { print $s{$k}; last;}}'
perl -0044 -lne 'if(/cd (.*)/) { $1 eq ".." ? pop(@n) : push(@n,$1) } else { while(/(\d+)/sg){ map {$s{"@n[0..$_]"}+=$1} 0..$#n;} } }{ $t=3e7-(7e7-$s{"/"}); for $k (sort {$s{$a}<=>$s{$b}} keys %s) { if($s{$k}>=$t) { print $s{$k}; last;}}' input.txt
perl -0044 -lne 'if(/cd (.*)/) { $1 eq ".." ? pop(@n) : push(@n,$1) } else { while(/\d+/sg){ map {$s{"@n[0..$_]"}+=$&} 0..$#n;} } }{ $t=3e7-(7e7-$s{"/"}); for $k (sort {$s{$a}<=>$s{$b}} keys %s) { if($s{$k}>=$t) { print $s{$k}; last;}}' input.txt
perl -lne 'if(/cd (.*)/) { $1 eq ".." ? pop(@n) : push(@n,$1) } else { if(/^\d+/){ map {$s{"@n[0..$_]"}+=$&} 0..$#n;} } }{ $t=3e7-(7e7-$s{"/"}); for $k (sort {$s{$a}<=>$s{$b}} keys %s) { if($s{$k}>=$t) { print $s{$k}; last;}}' input.txt


