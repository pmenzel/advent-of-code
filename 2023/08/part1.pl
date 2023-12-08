#!/bin/env perl


while(<>) {
	next unless length;
	chomp;
	#read instructions
	if(/^[LR]{3}/) {
		$l=$_;
		next;
	}
	#read map int hash
	@F = split(/\W+/,$_);
	$m{$F[0]."L"} = $F[1];
	$m{$F[0]."R"} = $F[2];
}

$s="AAA";
$i=0;

while(1) {
	$n = substr($l,$i,1);
	$s2 = $m{$s.$n};
	$C++;
	print "$C $i $n $s $s2\n";
	last if $s2 eq "ZZZ";
	$s = $s2;
	$i++;
	if($i == length($l)) {
		$i = 0;
	}
}

print "steps=$C\n";


