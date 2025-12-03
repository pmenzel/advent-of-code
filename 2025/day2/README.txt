Part 1:

cat input.txt | sed 's/,/\n/g' | perl -F"-" -lane 'for($i = $F[0]; $i<=$F[1]; $i++) { $sum+=$i  if $i =~ /^(.+)\1$/ }; }{ print $sum;'

Part2:

cat input.txt | sed 's/,/\n/g' | perl -F"-" -lane 'for($i = $F[0]; $i<=$F[1]; $i++) { $sum+=$i  if $i =~ /^(.+)\1+$/ }; }{ print $sum;'
