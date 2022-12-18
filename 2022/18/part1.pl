#!/usr/bin/env perl
#

%h = ();

while(<>) {
	chomp;
	@F = split(/,/,$_);
	$h{"@F"} = 1;
}

$c = 0;
for $k (keys %h) {
	($x,$y,$z) = split(/ /,$k);
	print "Checking $x $y $z\n";
	$c++ unless defined $h{($x + 1) . " " . $y . " " .$z};
	$c++ unless defined $h{($x - 1) . " " . $y . " " .$z};
	$c++ unless defined $h{$x . " " . ($y + 1) . " " .$z};
	$c++ unless defined $h{$x . " " . ($y - 1) . " " .$z};
	$c++ unless defined $h{$x . " " . $y . " " .($z + 1)};
	$c++ unless defined $h{$x . " " . $y . " " .($z - 1)};

}
print "sum=$c\n";
