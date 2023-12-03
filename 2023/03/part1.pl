#!/bin/env perl

my @F =<>;
for(@F) {
	$l++;
	while(/([=#\-*\$\/%\+@&])/g) {
		$h{"$l $-[1]"} = 1;
		print "$l $-[1] = $1,";
	};
	print "\n";
}

$l = 0;
for(@F) {
	$l++;
	print $F[$l-2];
	print $F[$l-1];
	print $F[$l];
	while(/(\d+)/g) {
		#print "$-[1] $+[1] = $1, ";
		for($i=$-[1]-1; $i<= $+[1]; $i++) {
			if(defined $h{($l)." ".$i} || defined $h{($l-1)." ".$i} || defined $h{($l+1)." ".$i}) {
				print "counting $1\n";
				$S+=$1
			}
		}
	}
	print "\n";
}

print "SUM = $S\n"
