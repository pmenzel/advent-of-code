
Part 2:

perl -ne 'BEGIN{$h{$_}=++$i for qw/one two three four five six seven eight nine/; $h{$_}=++$j for 1..9; $r="(".join("|",keys %h)."|\\d)"; } if(/$r.*$r/){$s += $h{$1}.$h{$2}} elsif(/$r/){$s+=$h{$1}.$h{$1}} }{ print $s' input.txt
