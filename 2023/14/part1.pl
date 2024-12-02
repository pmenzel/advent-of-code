#!/bin/env perl
use strict;

my @A;

while(<>) {
	chomp;
	if(length) {
		push(@A, $_);
	}
}
#print join("\n",@A),"\n";
#print "---------------------\n";

# make cols to rows first
my @B;
for(my $j=0; $j <= length($A[0]); $j++) {
	my $s = "";
	for(my $i=0; $i <= $#A; $i++) {
		$s = substr($A[$i], $j, 1) . $s;
	}
	push(@B, $s);
}
#print join("\n",@B),"\n";

my $S;
foreach my $l (@B) {
	while($l =~ /([\.O]+)/g) {
		my $s = 0;
		my $p = $1;
		# count Os
		my $nO = $p =~ y/O//;
		# sum weights of Os in this section
		map {$s += $_ } ($+[1] - $nO + 1) .. $+[1];
		#print "$1 from $-[1] to ", $+[1]," with $nO Os load sum = $s, ";
		$S += $s;
	}
	#print "\n";
}

print "SUM = $S\n";

