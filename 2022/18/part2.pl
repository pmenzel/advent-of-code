#!/usr/bin/env perl
#
# for each cube, we check all six adjacent cubes ($xx, $yy, $zz) and if they are empty,
# add them to a stack and continue searching from there.
# If the search does not stop within 5000 visited cubes, we guess that we are outside and not in an air pocket

use strict;
my %h = ();

while(<>) {
	chomp;
	my @F = split(/,/,$_);
	$h{"@F"} = 1;
}

my $c = 0;
for my $k (keys %h) {
	(my $xx, my $yy, my $zz) = split(/ /,$k);
	print "Checking $xx $yy $zz\n";

	if(!defined $h{($xx + 1) . " " . $yy . " " .$zz}) {
		my @path = ();
		my %visited = ();
		push(@path, ($xx + 1) . " " . $yy . " " .$zz);
		while(keys %visited < 5000) {
			(my $x, my $y,my $z) = split(/ /, $path[-1]);
			$visited{$path[-1]} = 1;
			pop(@path);
			#print "Walking through $x,$y,$z\n";
			if(!defined $h{($x + 1) . " " . $y . " " .$z} and !defined $visited{($x + 1) . " " . $y . " " .$z}) {
				push(@path, ($x + 1) . " " . $y . " " .$z);
			}
			if(!defined $h{($x - 1) . " " . $y . " " .$z} and !defined $visited{($x - 1) . " " . $y . " " .$z}) {
				push(@path, ($x - 1) . " " . $y . " " .$z);
			}
			if(!defined $h{$x . " " . ($y + 1) . " " .$z} and !defined $visited{$x . " " . ($y + 1) . " " .$z}) {
				push(@path, $x . " " . ($y + 1) . " " .$z);
			}
			if(!defined $h{$x . " " . ($y - 1) . " " .$z} and !defined $visited{$x . " " . ($y - 1) . " " .$z}) {
				push(@path, $x . " " . ($y - 1) . " " .$z);
			}
			if(!defined $h{$x . " " . $y . " " .($z + 1)} and !defined $visited{$x . " " . $y . " " .($z + 1)}) {
				push(@path, $x . " " . $y . " " .($z + 1));
			}
			if(!defined $h{$x . " " . $y . " " .($z - 1)} and !defined $visited{$x . " " . $y . " " .($z - 1)}) {
				push(@path, $x . " " . $y . " " .($z - 1));
			}
			last unless @path;
		}
		if(keys %visited >= 4999) { $c++; }
		#else { my @k = sort keys %visited; print "Walked through " . @k . " inner cubes: " . join(", ", @k) . "\n"; }
		else { my @k = sort keys %visited; print "Walked through " . @k . " inner cubes.\n"; }
	}
	if(!defined $h{($xx - 1) . " " . $yy . " " .$zz}) {
		my @path = ();
		my %visited = ();
		push(@path, ($xx - 1) . " " . $yy . " " .$zz);
		while(keys %visited < 5000) {
			(my $x, my $y, my $z) = split(/ /, $path[-1]);
			$visited{$path[-1]} = 1;
			pop(@path);
			#print "Walking through $x,$y,$z\n";
			if(!defined $h{($x + 1) . " " . $y . " " .$z} and !defined $visited{($x + 1) . " " . $y . " " .$z}) {
				push(@path, ($x + 1) . " " . $y . " " .$z);
			}
			if(!defined $h{($x - 1) . " " . $y . " " .$z} and !defined $visited{($x - 1) . " " . $y . " " .$z}) {
				push(@path, ($x - 1) . " " . $y . " " .$z);
			}
			if(!defined $h{$x . " " . ($y + 1) . " " .$z} and !defined $visited{$x . " " . ($y + 1) . " " .$z}) {
				push(@path, $x . " " . ($y + 1) . " " .$z);
			}
			if(!defined $h{$x . " " . ($y - 1) . " " .$z} and !defined $visited{$x . " " . ($y - 1) . " " .$z}) {
				push(@path, $x . " " . ($y - 1) . " " .$z);
			}
			if(!defined $h{$x . " " . $y . " " .($z + 1)} and !defined $visited{$x . " " . $y . " " .($z + 1)}) {
				push(@path, $x . " " . $y . " " .($z + 1));
			}
			if(!defined $h{$x . " " . $y . " " .($z - 1)} and !defined $visited{$x . " " . $y . " " .($z - 1)}) {
				push(@path, $x . " " . $y . " " .($z - 1));
			}
			last unless @path;
		}
		if(keys %visited >= 4999) { $c++; }
		else { my @k = sort keys %visited; print "Walked through " . @k . " inner cubes.\n"; }
	}
	if(!defined $h{$xx . " " . ($yy + 1) . " " .$zz}) {
		my @path = ();
		my %visited = ();
		push(@path, $xx . " " . ($yy + 1) . " " .$zz);
		while(keys %visited < 5000) {
			(my $x, my $y, my $z) = split(/ /, $path[-1]);
			$visited{$path[-1]} = 1;
			pop(@path);
			#print "Walking through $x,$y,$z\n";
			if(!defined $h{($x + 1) . " " . $y . " " .$z} and !defined $visited{($x + 1) . " " . $y . " " .$z}) {
				push(@path, ($x + 1) . " " . $y . " " .$z);
			}
			if(!defined $h{($x - 1) . " " . $y . " " .$z} and !defined $visited{($x - 1) . " " . $y . " " .$z}) {
				push(@path, ($x - 1) . " " . $y . " " .$z);
			}
			if(!defined $h{$x . " " . ($y + 1) . " " .$z} and !defined $visited{$x . " " . ($y + 1) . " " .$z}) {
				push(@path, $x . " " . ($y + 1) . " " .$z);
			}
			if(!defined $h{$x . " " . ($y - 1) . " " .$z} and !defined $visited{$x . " " . ($y - 1) . " " .$z}) {
				push(@path, $x . " " . ($y - 1) . " " .$z);
			}
			if(!defined $h{$x . " " . $y . " " .($z + 1)} and !defined $visited{$x . " " . $y . " " .($z + 1)}) {
				push(@path, $x . " " . $y . " " .($z + 1));
			}
			if(!defined $h{$x . " " . $y . " " .($z - 1)} and !defined $visited{$x . " " . $y . " " .($z - 1)}) {
				push(@path, $x . " " . $y . " " .($z - 1));
			}
			last unless @path;
		}
		if(keys %visited >= 4999) { $c++; }
		else { my @k = sort keys %visited; print "Walked through " . @k . " inner cubes.\n"; }
	}
	if(!defined $h{$xx . " " . ($yy - 1) . " " .$zz}) {
		my @path = ();
		my %visited = ();
		push(@path, $xx . " " . ($yy - 1) . " " .$zz);
		while(keys %visited < 5000) {
			(my $x, my $y, my $z) = split(/ /, $path[-1]);
			$visited{$path[-1]} = 1;
			pop(@path);
			#print "Walking through $x,$y,$z\n";
			if(!defined $h{($x + 1) . " " . $y . " " .$z} and !defined $visited{($x + 1) . " " . $y . " " .$z}) {
				push(@path, ($x + 1) . " " . $y . " " .$z);
			}
			if(!defined $h{($x - 1) . " " . $y . " " .$z} and !defined $visited{($x - 1) . " " . $y . " " .$z}) {
				push(@path, ($x - 1) . " " . $y . " " .$z);
			}
			if(!defined $h{$x . " " . ($y + 1) . " " .$z} and !defined $visited{$x . " " . ($y + 1) . " " .$z}) {
				push(@path, $x . " " . ($y + 1) . " " .$z);
			}
			if(!defined $h{$x . " " . ($y - 1) . " " .$z} and !defined $visited{$x . " " . ($y - 1) . " " .$z}) {
				push(@path, $x . " " . ($y - 1) . " " .$z);
			}
			if(!defined $h{$x . " " . $y . " " .($z + 1)} and !defined $visited{$x . " " . $y . " " .($z + 1)}) {
				push(@path, $x . " " . $y . " " .($z + 1));
			}
			if(!defined $h{$x . " " . $y . " " .($z - 1)} and !defined $visited{$x . " " . $y . " " .($z - 1)}) {
				push(@path, $x . " " . $y . " " .($z - 1));
			}
			last unless @path;
		}
		if(keys %visited >= 4999) { $c++; }
		else { my @k = sort keys %visited; print "Walked through " . @k . " inner cubes.\n"; }
	}
	if(!defined $h{$xx . " " . $yy . " " .($zz + 1)}) {
		my @path = ();
		my %visited = ();
		push(@path, $xx . " " . $yy . " " .($zz + 1));
		while(keys %visited < 5000) {
			(my $x, my $y, my $z) = split(/ /, $path[-1]);
			$visited{$path[-1]} = 1;
			pop(@path);
			#print "Walking through $x,$y,$z\n";
			if(!defined $h{($x + 1) . " " . $y . " " .$z} and !defined $visited{($x + 1) . " " . $y . " " .$z}) {
				push(@path, ($x + 1) . " " . $y . " " .$z);
			}
			if(!defined $h{($x - 1) . " " . $y . " " .$z} and !defined $visited{($x - 1) . " " . $y . " " .$z}) {
				push(@path, ($x - 1) . " " . $y . " " .$z);
			}
			if(!defined $h{$x . " " . ($y + 1) . " " .$z} and !defined $visited{$x . " " . ($y + 1) . " " .$z}) {
				push(@path, $x . " " . ($y + 1) . " " .$z);
			}
			if(!defined $h{$x . " " . ($y - 1) . " " .$z} and !defined $visited{$x . " " . ($y - 1) . " " .$z}) {
				push(@path, $x . " " . ($y - 1) . " " .$z);
			}
			if(!defined $h{$x . " " . $y . " " .($z + 1)} and !defined $visited{$x . " " . $y . " " .($z + 1)}) {
				push(@path, $x . " " . $y . " " .($z + 1));
			}
			if(!defined $h{$x . " " . $y . " " .($z - 1)} and !defined $visited{$x . " " . $y . " " .($z - 1)}) {
				push(@path, $x . " " . $y . " " .($z - 1));
			}
			last unless @path;
		}
		if(keys %visited >= 4999) { $c++; }
		else { my @k = sort keys %visited; print "Walked through " . @k . " inner cubes.\n"; }
	}
	if(!defined $h{$xx . " " . $yy . " " .($zz - 1)}) {
		my @path = ();
		my %visited = ();
		push(@path, $xx . " " . $yy . " " .($zz - 1));
		while(keys %visited < 5000) {
			(my $x, my $y, my $z) = split(/ /, $path[-1]);
			$visited{$path[-1]} = 1;
			pop(@path);
			#print "Walking through $x,$y,$z\n";
			if(!defined $h{($x + 1) . " " . $y . " " .$z} and !defined $visited{($x + 1) . " " . $y . " " .$z}) {
				push(@path, ($x + 1) . " " . $y . " " .$z);
			}
			if(!defined $h{($x - 1) . " " . $y . " " .$z} and !defined $visited{($x - 1) . " " . $y . " " .$z}) {
				push(@path, ($x - 1) . " " . $y . " " .$z);
			}
			if(!defined $h{$x . " " . ($y + 1) . " " .$z} and !defined $visited{$x . " " . ($y + 1) . " " .$z}) {
				push(@path, $x . " " . ($y + 1) . " " .$z);
			}
			if(!defined $h{$x . " " . ($y - 1) . " " .$z} and !defined $visited{$x . " " . ($y - 1) . " " .$z}) {
				push(@path, $x . " " . ($y - 1) . " " .$z);
			}
			if(!defined $h{$x . " " . $y . " " .($z + 1)} and !defined $visited{$x . " " . $y . " " .($z + 1)}) {
				push(@path, $x . " " . $y . " " .($z + 1));
			}
			if(!defined $h{$x . " " . $y . " " .($z - 1)} and !defined $visited{$x . " " . $y . " " .($z - 1)}) {
				push(@path, $x . " " . $y . " " .($z - 1));
			}
			last unless @path;
		}
		if(keys %visited >= 4999) { $c++; }
		else { my @k = sort keys %visited; print "Walked through " . @k . " inner cubes.\n"; }
	}

}

print "Sum of surfaces to the outside = $c\n";
