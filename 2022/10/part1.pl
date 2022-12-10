#!/usr/bin/env perl

@stack = ();

while(<>) {
	chomp;
	unshift(@stack,$_)
}

$X=1;
$add=0;
$A=0;
$sum=0;
$c=0;

while(++$c){
	print STDERR "cycle $c, X=$X, add = $add, sum=$sum\n";
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
	$sum += $c * $X if ($c==20 or $c==60 or $c==100 or $c==140 or $c==180 or $c==220);
	last if(@stack==0 and $add==0);
}

print $sum;

