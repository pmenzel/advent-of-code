Part 1:

perl -ne 'if(/(\d).*(\d)/){$s += $1.$2} elsif(/(\d)/){$s+=$1.$1} }{ print $s' input.txt

Part 2:

perl -ne 'BEGIN{$h{$_}=++$i for qw/one two three four five six seven eight nine/; $h{$_}=++$j for 1..9; $r="(".join("|",keys %h)."|\\d)"; } if(/$r.*$r/){$s += $h{$1}.$h{$2}} elsif(/$r/){$s+=$h{$1}.$h{$1}} }{ print $s' input.txt

above line does not consider overlapping words like oneight
small mod to also match these:

perl -ne 'BEGIN{$h{$_}=++$i for qw/one two three four five six seven eight nine/; $h{$_}=++$j for 1..9; $r="(".join("|",keys %h)."|\\d)"; } $c=0; if(/$r.*/) { $c.=$h{$1}}; if(/.*$r/) { $c.=$h{$1} } $s+=$c }{ print $s' input.txt

