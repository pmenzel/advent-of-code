#/!/usr/bin/perl

# enable reading of paragraphs
# see https://perldoc.perl.org/perlvar#$/
local $/ = "";

$n_monkeys = 0;

while(<>) {
	m/  Starting items: (.*)\n  Operation: (.*)\n  Test: divisible by (\d+)\n.*(\d+)\n.*(\d+)/;

	@items = split(/, /, $1);
  $items{$n_monkeys} = [@items];
	$operation{$n_monkeys} = $2;
	$divisible_by{$n_monkeys} = $3;
	$throw_true{$n_monkeys} = $4;
	$throw_false{$n_monkeys} = $5;

	$n_monkeys++;
}

# Product of all monkey's divisors for testing
# this product can be used to reduce the size of all item values across all monkeys
$prod = 1;
map $prod *= $_, values %divisible_by;

$round = 10000;
while($round--) {
	#print "------------------------\n";
	for($m = 0; $m < $n_monkeys; $m++) {
		#for $k (sort keys %items) { print "$k = ". "@{$items{$k}}" . "\n"; }
		#print "monkey $m\n";

		while($i = shift(@{$items{$m}})) {
			#print "item=$i ";
			$i = $i % $prod;
			$inspect_counter{$m}++;
			$op = $operation{$m};
			$op =~ s/old/$i/g;
			$op =~ s/new/\$new/;
			#print "op=$op ";
			eval $op;
			#print "new=$new ";
			if($new % $divisible_by{$m} == 0) {
				#print "true\n";
				push(@{$items{$throw_true{$m}}}, $new);
			}
			else {
				#print "false\n";
				push(@{$items{$throw_false{$m}}}, $new);
			}
		}
		#print "\n";
	}
}

print "------------------------\n";
print "Monkey's inspection counters:\n";
for $k (sort {$a<=>$b} values %inspect_counter) { print "$k\n"; }
print "You need to multiply the two highest numbers now!\n"
