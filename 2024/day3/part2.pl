#!/usr/bin/env perl

$sum = 0;

sub x {
	my $i = $_[0];
	while($i =~ m/mul\((\d+),(\d+)\)/g) {
		$sum += $1 * $2;
	}
}

@lines = <STDIN>;
chomp(@lines);
$in = join("", @lines);

# ^ ... don't()
if($in =~ m/^.*?don't\(\)/) {
	#print "START $&\n\n";
	x($&);
}

# all do() ... don't() blocks
while($in =~ m/do\(\).*?don't\(\)/g)  {
	#print "$&\n\n";
	x($&);
}

# do() ... $

# this non-greedy match until $ does not work!
# if($in =~ m/do\(\).*?$/) {
#	  print "END: ". $& . "\n\n";
# }

# it's easiest to reverse the whole input:
$r = reverse($in);
if($r =~ m/^.*?\)\(od/) {
	$r2 = reverse($&);
	#print "END: $r2\n\n";
	x($r2);
}

print $sum;

