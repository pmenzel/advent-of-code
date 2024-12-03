Part 1:

perl -ne 'while(/mul\((\d+),(\d+)\)/g) { $s+=$1*$2;} }{ print $s'


