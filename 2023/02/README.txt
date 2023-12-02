
part 1:

using flag $f for deciding if a line is skipped or counted:

perl -lne 'BEGIN{%s=("red",12,"green",13,"blue",14)} $f=1; while(/(\d+) (\w+)/g) { $f=0 if $1>$s{$2}; } if($f) {print; /^\w+ (\d+)/; $s+=$1 ;}  }{ print $s' input.txt

without -n and explicit while(<>) using a label to break out of inner while-loop when skipping a line:

perl -le '%s=("red",12,"green",13,"blue",14); O: while(<>) { while(/(\d+) (\w+)/g) { next O if $1>$s{$2}; } /^\w+ (\d+)/; $s+=$1; } print $s' input.txt

-----------------------------------------------------------------------------------------------

part 2:

perl -lne '$s{$_}=0 for qw/red green blue/; while(/(\d+) (\w+)/g) { $s{$2}=$1 if $1>$s{$2} } $s=1; $s*=$_ for values %s; $S+=$s }{ print $S' input.txt

