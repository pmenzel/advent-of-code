#!/usr/bin/env perl
#
use List::Util qw/min max/;

%h=();

sub blocked {
 	return defined($h{$_[0] . "," . $_[1]})
}

sub free {
 	return !defined($h{$_[0] . "," . $_[1]})
}

while(<>) {
	$prevX = undef;
	$prevY = undef;
	while(m/(\d+),(\d+)/g) {
		if(!$prevX) { $prevX=$1; $prevY=$2; next;}
		$X=$1;
		$Y=$2;

		if($prevX == $X) {
			for($y = min($prevY,$Y); $y <= max($prevY,$Y); $y++) {
				$h{$X . "," . $y} = "R";
			}
		}
		else {
			for($x = min($prevX,$X); $x <= max($prevX,$X); $x++) {
				$h{$x . "," . $Y} = "R";
			}
		}
		$prevX=$X;
		$prevY=$Y;

	}
}

$c = 0;

while(++$c) {

	$X = 500;
	$Y = 0;

	while($Y < 1000) {
		print "$c falling from  $X,$Y: ";
		if(free($X, $Y +1)) {
			print "down\n";
			$Y++;
			next;
		} elsif(free($X-1, $Y+1)) {
			print "left down\n";
			$Y++;
			$X--;
		} elsif(free($X+1, $Y+1)) {
			print "left right\n";
			$Y++;
			$X++
		}
		else { #rest
			print "rest\n";
			$h{$X . "," . $Y} = "S";
			last;
		}
	}
	if($Y>=1000) { last; }

}
$s=0;
map { print "$_ = $h{$_}\n"; $s++ if $h{$_} eq "S"; }  sort keys %h;
print "sum=$s";
