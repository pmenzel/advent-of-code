#!/usr/bin/env perl

while(<>) {
	chomp;
	next unless length;
	if(/\d+\|\d+/) {
		push(@orderings, $_);
	}
	else {
		my $correct = 1;
		foreach $k (@orderings) {
			$k =~ /(\d+)\|(\d+)/;
			$first = $1;
			$second = $2;
			if($_ =~ /\b$first\b/ && $_ =~ /\b$second\b/) {
				if($_ =~ /\b$first\b.*\b$second\b/) {
					@F = split(/,/, $_);
				}
				else {
					$correct = 0;
				}
			}
		}
		if($correct) {
			print "middle = $F[$#F/2]\n";
			$sum += $F[$#F/2];
		}
	}
}
print $sum;

