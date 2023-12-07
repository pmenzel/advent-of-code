
sub get_type {
  $s = shift;
  if($s =~ /(\w)\1{4}/) {
  	return  "five of a kind";
  }
  elsif($s =~ /(\w).*\1.*\1.*\1/) {
  	return "four of a kind";
  }
  elsif($s=~ /(\w).*\1.*\1/) {
		if($s =~ /([^$1]).*\1/) {
			return "full house";
		}
		else {
			return "three of a kind";
		}
  }
  elsif($s=~ /(\w).*\1/) {
		if($s =~ /([^$1]).*\1/) {
			return "two pairs";
		}
		else {
			return "one pair";
		}
  }
	else {
		return "high card";
	}
}

sub get_type_rank {
	$t = shift;
	if($t eq "five of a kind") { return 7; }
	if($t eq "four of a kind") { return 6; }
	if($t eq "full house") { return 5; }
	if($t eq "three of a kind") { return 4; }
	if($t eq "two pairs") { return 3; }
	if($t eq "one pair") { return 2; }
	if($t eq "high card") { return 1; }
}

sub compare_hands {
	#determine type of hand for $a and $b
	$type_rank_a = get_type_rank(get_type($a));
	$type_rank_b = get_type_rank(get_type($b));
	#print "comparing $a $b:";
	if($type_rank_a == $type_rank_b) {
		#print " same rank\n";
		# replace  A, K, Q, J, T by ascii chars for easier sorting the string
		# need to make new variables as the original strings in @A would be changed
		# when modifying $a and $b directly!
		$a2 = $a;
		$b2 = $b;
		$a2 =~ y/AKQJT/edcba/;
		$b2 =~ y/AKQJT/edcba/;
		return $a2 cmp $b2;
	}
	else {
		#print " not same rank\n";
		return $type_rank_a <=> $type_rank_b;
	}
}

# ------------- main ------------------------------------------------------------------

# read input lines and add each hand to an array @A, which is to be sorted later,
# and a hash %h that maps hands to their bid value
while(<>) {
  chomp;
  @F = split;
  $s = $F[0];
  $h{$s} = $F[1];
  $A[$.-1] = $s;
	#$t = get_type($s);
	#$r = get_type_rank($t);
	#print "$s = $t which has rank $r\n";
}

my @Asort = sort compare_hands @A;

foreach(@Asort) { $i++; print "$_ has rank $i with bid $h{$_}\n"; $S += $i * $h{$_} }

print "final sum = $S\n";


