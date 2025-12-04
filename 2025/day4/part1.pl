#!/usr/bin/env perl

use strict;

my @m = map { chomp; [ split // ] } <STDIN>;
my $total = 0;
for my $r (0..$#m) {
	for my $c (0..$#{$m[$r]}) {
		if($m[$r][$c] ne '@') { print "."; next;}
		my $s = 0;
		if($r > 0) {
			$s++ if $c > 0 && $m[$r-1][$c-1] eq '@';
			$s++ if $m[$r-1][$c] eq '@';
			$s++ if $c < $#{$m[$r]} && $m[$r-1][$c+1] eq '@';
		}
		$s++ if $c > 0 && $m[$r][$c-1] eq '@';
		$s++ if $c < $#{$m[$r]} && $m[$r][$c+1] eq '@';
		if($r < $#m) {
			$s++ if $c > 0 and $m[$r+1][$c-1] eq '@';
			$s++ if $m[$r+1][$c] eq '@';
			$s++ if $c < $#{$m[$r]} and $m[$r+1][$c+1] eq '@';
		}
		if($s < 4) { print "x"; $total++;}
		else { print "@";}
	}
	print "\n";
}
print "total=$total\n";

