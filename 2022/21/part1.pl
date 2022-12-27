#!/usr/bin/env/perl

use strict;
use warnings;

my %h =();

while(<>) {
	chomp;
	/(\w+): (.*)/;
	$h{$1} = $2;
}


sub r {
	my ($a) = @_;
	#print "running r for ",$a,"\n";
	if($a =~ /^(\w+)$/) {
		if(defined $h{$a}) {
			if($h{$a} =~ /^\d+$/) {
				#print "Returning ",$h{$a},"\n";
				return $h{$a};
			}
			else {
				return r($h{$a});
			}
		}
		else {
			die "Error: not in hash:", $a,"\n";
		}
	}
	elsif($a =~ m,(\w+) ([+*-/]) (\w+), ) {
		my $first = $1;
		my $op = $2;
		my $second = $3;
		my $rfirst = r($first);
		my $rsecond = r($second);
		my $x;
		my $s = '$x = ' . $rfirst . $op . $rsecond;
		#print "Evaluating: $s\n";
		eval($s);
		#print "Returning eval result: $x\n";
		return $x;
	}
	else {
		die "Error in matching: ",$a,"\n";
	}
}

print r("root");

