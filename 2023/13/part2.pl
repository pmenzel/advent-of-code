#!/bin/env perl
use strict;

my @A;
my $S;

# there is either a horizontal or vertical split
# also the smudge muste be used, otherwise one would count also old splits without smudge

while(<>) {

	chomp;
	if(length) {
		push(@A, $_);
	}
	else {
		print join("\n",@A),"\n";
		my $nV;
		my $nH;
		# process current pattern by rows
		for(my $i=1; $i <= $#A; $i++) {
			my $same = 1;
			my $offset = 0;
			my $usedSmudge = 0;
			while(1) {
				#print "position = $i, offset=$offset\n";
				#print $A[$i - ($offset+1)],"\n";
				#print $A[$i + $offset],"\n";
				if($i - ($offset+1) < 0 or $i + $offset > $#A) {
					#print "reached end\n";
					last;
				}
				else {
					if($A[$i - ($offset+1)] ne $A[$i + $offset]) {
						if($usedSmudge) {
							$same = 0;
							last;
						}
						else {
							my $diffCount = () = ( $A[$i - ($offset+1)] ^ $A[$i + $offset] ) =~ /[^\x00]/g;
							#print "diffs = $diffCount\n";
							if($diffCount == 1) {
								$usedSmudge = 1;
							}
							else {
								$same = 0;
								last;
							}
						}
					}
				}
				$offset++;
			}
			if($same and $usedSmudge) {
				print "found vertical split at $i\n";
				$nV = $i;
				last;
			}
		}

		# process current pattern by cols
		# make cols to rows first
		my @B =();
		for(my $j=0;$j < length($A[0]); $j++) {
			my $s = "";
			for(my $i=0; $i <= $#A; $i++) {
				$s .= substr($A[$i], $j, 1);
			}
			push(@B, $s);
		}
		#print "doing horizontal\n";
		#print join("\n",@B),"\n";
		for(my $i = 1; $i <= $#B; $i++) {
			my $same = 1;
			my $offset = 0;
			my $usedSmudge = 0;
			while(1) {
				#print "position = $i, offset=$offset\n";
				#print $B[$i - ($offset+1)],"\n";
				#print $B[$i + $offset],"\n";
				if($i - ($offset+1) < 0 or $i + $offset > $#B) {
					#print "reached end\n";
					last;
				}
				else {
					if($B[$i - ($offset+1)] ne $B[$i + $offset]) {
						if($usedSmudge) {
							$same = 0;
							last;
						}
						else {
							my $diffCount = () = ( $B[$i - ($offset+1)] ^ $B[$i + $offset] ) =~ /[^\x00]/g;
							if($diffCount == 1) {
								$usedSmudge = 1;
							}
							else {
								$same = 0;
								last;
							}
						}
					}
				}
				$offset++;
			}
			if($same and $usedSmudge) {
				print "found horizontal split at $i\n";
				$nH = $i;
				last;
			}
		}

		$S += $nH + 100 * $nV ;
		$nV = 0;
		$nH = 0;
		#reset pattern
		@A = ();
		@B = ();
		print "-------------------------------------\n";;

	}
}
print "SUM=$S\n";

