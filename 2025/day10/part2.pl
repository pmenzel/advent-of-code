#!/usr/bin/env perl -w
use strict;
use warnings;

while (<>) {
  next unless length;
  chomp;
	my @joltages;

	# [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
	m/\[(.*)\] (.*) \{(.*)\}/;
	@joltages = split ',', $3;
	print STDERR "length joltages = ", scalar @joltages, "\n";
	print pack("l", scalar(@joltages));
	for my $j (@joltages) {
		print pack("l", $j);
	}
	my $list = $2;
	my @buttons = split ' ', $list;
	print pack("l", scalar @buttons);
	# sort buttons by their number of affected joltages, to find better solution earlier
	for my $b (sort { length($b) <=> length($a) } @buttons) {
		my @a = split '', "0" x scalar(@joltages);
		while($b =~ /(\d+)/g) { $a[$1] = "1"; }
		my $a_num = oct("0b" . join('',@a));
		print STDERR "  @a = $a_num\n";
		print pack("l", $a_num);
	}
	print pack("l",0);
}

