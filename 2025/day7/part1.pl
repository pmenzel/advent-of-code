#!/usr/bin/env perl -w
use strict;
use warnings;

my %h;
my $c;
while (<>) {
  if(/(S)/) {
		$h{ $-[1] } = 1;
		next;
  }
	while(m/(\^)/g) {
		if( $h{ $-[1] } == 1) {
			$h{ $-[1] -1 } = 1;
			$h{ $-[1] } = 0;
			$h{ $-[1] +1 } = 1;
			$c++;
		}
	}
}
print $c;
