#!/usr/bin/env perl
#
use List::Util qw/min max/;


sub blocked {
 	return defined($h{$_[0] . "," . $_[1]})
}

sub free {
 	return !defined($h{$_[0] . "," . $_[1]})
}

while(<>) {
	m/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/;
	#print"$1 $2, $3 $4\n";
	$sensor_pos{$1.",".$2} = $3.",".$4;
	$beacon_pos{$3.",".$4} = $1.",".$2;
}

for $k (keys %sensor_pos) {

	print "---------------\n";
	$k =~ /(\d+),(\d+)/;
	$sx = $1;
	$sy = $2;

	$sensor_pos{$k} =~ /(\d+),(\d+)/;
	$bx = $1;
	$by = $2;

	$d = abs($sx - $bx) + abs($sy - $by);
	print "$k -> $sensor_pos{$k} = $d\n";

	for($x = $sx - $d; $x <= $sx + $d; $x++) {
		$y = 2000000;
		#for($y = $sy - $d; $y <= $sy + $d; $y++) {
			$dd = abs($sx - $x) + abs($sy - $y);
			#print "Checking $x,$y with distance $dd\n";
			if($dd <= $d) {
				#	print "Point $x,$y is detected\n";
				$area{$x.",".$y} = 1;
			}
			#}
	}
}

$s = 0;
for $k (keys %area) {
	#$area{$k} =~ /(\d+),(\d+)/;
	$s++ unless defined $beacon_pos{$k};
}
print "sum=$s\n";


