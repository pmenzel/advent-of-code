#!/usr/bin/env perl
#

while(<>) {
	m/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/;
	#print"$1 $2, $3 $4\n";
	$sensor_pos{$1.",".$2} = $3.",".$4;
	$d = abs($1 - $3) + abs($2 - $4);
	$sensor_dist{$1.",".$2} = $d;
	$beacon_pos{$3.",".$4} = $1.",".$2;
	#	print "$1 $2 dist $d\n";
	$n_sensors++;
}

@sorted_sensor_list = sort {$sensor_dist{$b} <=> $sensor_dist{$a}} keys %sensor_dist;
for $k (@sorted_sensor_list) {
	$k =~ /(\d+),(\d+)/;
	$x = $1;
	$y = $2;
	print "{$x,$y,$sensor_dist{$k}},\n";
}

