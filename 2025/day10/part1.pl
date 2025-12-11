#!/usr/bin/env perl -w
use strict;
use warnings;

while (<>) {
  next unless length;
  chomp;
	my @lights;

	# [.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
	m/\[(.*)\] (.*) \{/;
	@lights = map { $_ eq '.' ? 0 : 1  }  split '', $1;
	print STDERR scalar @lights;
	print pack("l", scalar(@lights));
	my $lights_num = oct("0b" . join('',@lights));
	print STDERR"lights=@lights = $lights_num\n";
	print pack("l", $lights_num);
	my $list = $2;
	my @buttons = split ' ', $list;
	print pack("l", scalar @buttons);
	for my $b (@buttons) {
		my @a = split '', "0" x ($#lights+1);
		while($b =~ /(\d+)/g) { $a[$1] = "1"; }
		my $a_num = oct("0b" . join('',@a));
		print STDERR "  @a = $a_num\n";
		print pack("l", $a_num);
	}
	print pack("l",0);
}

