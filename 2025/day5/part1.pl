#!/usr/bin/env perl

my @intervals;

while(<>) {
	next unless length;
	@F = split(/-/, $_);
	if($#F) {
		push @intervals, [@F];
	}
	else {
		for $i (0..$#intervals) {
			if($_ >= $intervals[$i][0] && $_ <= $intervals[$i][1]) {
				$count++;
				last;
			}
		}
	}
}
print "$count\n"
