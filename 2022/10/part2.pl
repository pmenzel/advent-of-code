#!/usr/bin/env perl

@stack = ();

while(<>) {
	chomp;
	unshift(@stack,$_)
}

$X=1;
$add=0;
$A=0;
$c=0;
$pos = 0;
$line = " " x 40;

while(++$c){
	#print STDERR "cycle $c, X=$X, add = $add, pos=$pos\n";
	if($add == 0) {
		$X += $A;
		$e = pop(@stack);
		if($e eq "noop") {
			$add = 0;
			$A = 0;
		}
		else { # $e == addx
			$add = 1;
			$e =~ /addx (.+)/;
			$A = int($1);
		}
	}
	else {
		$add--;
	}
	if($X-1 == $pos or $X == $pos or $X+1 == $pos) { substr($line, $pos, 1) = "#"; }
	$pos++;
	if($pos % 40 == 0) {
		print "$line\n";
		$line = " " x 40;
		$pos = 0;
	}
	last if(@stack==0 and $add==0);
}


