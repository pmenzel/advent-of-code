#!/usr/bin/env perl

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

for($x = 1; $x <= 4000000; $x++) {
	#print "Checking row $x\n";
	for($y = 1; $y <= 4000000; $y++) {
		$found = 0;
		for $k (@sorted_sensor_list) {
			$k =~ /(\d+),(\d+)/;
			$sx = $1;
			$sy = $2;
			#dist to sensor
			$dd = abs($sx - $x) + abs($sy - $y);
			#print "Checking $x,$y with distance $dd\n";
			if($dd <= $sensor_dist{$k}) {
				#print "Point $x,$y is covered by sensor $k\n";
				$found = 1;
				last;
			}
			else {
				#print "Point $x,$y is not covered by sensor $k\n";
			}
		}
		if($found == 0) { print "$x $y\n"; ;}
	}
}

