#!/usr/bin/perl
use strict;

# run with: perl part1.pl input.txt

my $jet_pattern;

while(<>) {
	chomp;
	$jet_pattern = $_;
}
my $jet_pattern_length = length($jet_pattern);
my $jet_pattern_index = 0;

my %a = ();
my $highest_rock = 0;

sub print_stack {
	for(my $h = $highest_rock; $h >= 1; $h--) {
		for(my $x = 1; $x <= 7; $x++) {
			print defined $a{$x . " " . $h} ? "#" : ".";
		}
		print "\n";
	}
}


for(my $rock_nr = 0; $rock_nr <= 2021; $rock_nr++) {

	my $rock_type = $rock_nr % 5;
	my $rock_left = 3;
	my $rock_bottom = $highest_rock + 4;

	print "Rock nr $rock_nr of type $rock_type appeared at $rock_bottom\n";
	my $rock_right;
	my $rock_top;
	if($rock_type == 0) { $rock_right = 6; $rock_top = $rock_bottom; }
	elsif($rock_type == 1) { $rock_right = 5; $rock_top = $rock_bottom + 2; }
	elsif($rock_type == 2) { $rock_right = 5; $rock_top = $rock_bottom + 2; }
	elsif($rock_type == 3) { $rock_right = 3; $rock_top = $rock_bottom + 3; }
	elsif($rock_type == 4) { $rock_right = 4; $rock_top = $rock_bottom + 1; }

	while(1) {

		my $curr_jet = substr($jet_pattern,$jet_pattern_index,1);
		$jet_pattern_index++;
		if($jet_pattern_index == $jet_pattern_length) {
			$jet_pattern_index = 0;
		}

		if($curr_jet eq "<") {

			if($rock_type == 0) {
				if(!($rock_left == 1 or
						defined $a{($rock_left - 1) . " " . $rock_bottom}
					)) {
					$rock_left--;
					$rock_right--;
				}
			}
			elsif($rock_type == 1) {
				if(!($rock_left == 1 or
						defined $a{($rock_left) . " " . $rock_bottom} or
						defined $a{($rock_left - 1) . " " . ($rock_bottom + 1)} or
						defined $a{($rock_left) . " " . ($rock_bottom + 2)}
					)) {
					$rock_left--;
					$rock_right--;
				}
			}
			elsif($rock_type == 2) {
				if(!($rock_left == 1 or
						defined $a{($rock_left - 1) . " " . $rock_bottom} or
						defined $a{($rock_left + 1) . " " . ($rock_bottom + 1)} or
						defined $a{($rock_left + 1) . " " . ($rock_bottom + 2)}
					)) {
					$rock_left--;
					$rock_right--;
				}
			}
			elsif($rock_type == 3) {
				if(!($rock_left == 1 or
						defined $a{($rock_left - 1) . " " . $rock_bottom} or
						defined $a{($rock_left - 1) . " " . ($rock_bottom + 1)} or
						defined $a{($rock_left - 1) . " " . ($rock_bottom + 2)} or
						defined $a{($rock_left - 1) . " " . ($rock_bottom + 3)}
					)) {
					$rock_left--;
					$rock_right--;
				}
			}
			elsif($rock_type == 4) {
				if(!($rock_left == 1 or
						defined $a{($rock_left - 1) . " " . $rock_bottom} or
						defined $a{($rock_left - 1) . " " . ($rock_bottom + 1)}
					)) {
					$rock_left--;
					$rock_right--;
				}
			}

		}
		else { # move right

			if($rock_type == 0) {
				if(!($rock_right == 7 or
						defined $a{($rock_right + 1) . " " .$rock_bottom}
					)) {
					$rock_left++;
					$rock_right++;
				}
			}
			elsif($rock_type == 1) {
				if(!($rock_right == 7 or
						defined $a{($rock_right) . " " . $rock_bottom} or
						defined $a{($rock_right + 1) . " " . ($rock_bottom + 1)} or
						defined $a{($rock_right) . " " . ($rock_bottom + 2)}
					)) {
					$rock_left++;
					$rock_right++;
				}
			}
			elsif($rock_type == 2) {
				if(!($rock_right == 7 or
						defined $a{($rock_right + 1) . " " .$rock_bottom} or
						defined $a{($rock_right + 1) . " " . ($rock_bottom + 1)} or
						defined $a{($rock_right + 1) . " " . ($rock_bottom + 2)}
					)) {
					$rock_left++;
					$rock_right++;
				}
			}
			elsif($rock_type == 3) {
				if(!($rock_right == 7 or
						defined $a{($rock_right + 1) . " " . $rock_bottom} or
						defined $a{($rock_right + 1) . " " . ($rock_bottom + 1)} or
						defined $a{($rock_right + 1) . " " . ($rock_bottom + 2)} or
						defined $a{($rock_right + 1) . " " . ($rock_bottom + 3)}
					)) {
					$rock_left++;
					$rock_right++;
				}
			}
			elsif($rock_type == 4) {
				if(!($rock_right == 7 or
						defined $a{($rock_right + 1) . " " . ($rock_bottom)} or
						defined $a{($rock_right + 1) . " " . ($rock_bottom + 1)}
					)) {
					$rock_left++;
					$rock_right++;
				}
			}

		}

		# move down
		my $moved_down = 0;
		if($rock_type == 0) {
			if(!($rock_bottom == 1 or
					defined $a{($rock_left) . " " . ($rock_bottom - 1)} or
					defined $a{($rock_left + 1) . " " . ($rock_bottom - 1)} or
					defined $a{($rock_left + 2) . " " . ($rock_bottom - 1)} or
					defined $a{($rock_left + 3) . " " . ($rock_bottom - 1)}
				)) {
				$rock_bottom--;
				$rock_top--;
				$moved_down = 1;
			}
		}
		elsif($rock_type == 1) {
			if(!($rock_bottom == 1 or
					defined $a{($rock_left) . " " . $rock_bottom } or
					defined $a{($rock_left + 1) . " " . ($rock_bottom - 1)} or
					defined $a{($rock_left + 2) . " " . $rock_bottom }
				)) {
				$rock_bottom--;
				$rock_top--;
				$moved_down = 1;
			}
		}
		elsif($rock_type == 2) {
			if(!($rock_bottom == 1 or
					defined $a{($rock_left) . " " . ($rock_bottom - 1)} or
					defined $a{($rock_left + 1) . " " . ($rock_bottom - 1)} or
					defined $a{($rock_left + 2) . " " . ($rock_bottom - 1)}
				)) {
				$rock_bottom--;
				$rock_top--;
				$moved_down = 1;
			}
		}
		elsif($rock_type == 3) {
			if(!($rock_bottom == 1 or
					defined $a{($rock_left) . " " . ($rock_bottom - 1)}
				)) {
				$rock_bottom--;
				$rock_top--;
				$moved_down = 1;
			}
		}
		elsif($rock_type == 4) {
			if(!($rock_bottom == 1 or
					defined $a{($rock_left) . " " . ($rock_bottom - 1)} or
					defined $a{($rock_left + 1) . " " . ($rock_bottom - 1)}
				)) {
				$rock_bottom--;
				$rock_top--;
				$moved_down = 1;
			}
		}

		if($moved_down == 0) {
			if($rock_type == 0) {
				$a{$rock_left . " " . $rock_bottom} = 1;
				$a{($rock_left + 1) . " " . $rock_bottom} = 1;
				$a{($rock_left + 2) . " " . $rock_bottom} = 1;
				$a{($rock_left + 3) . " " . $rock_bottom} = 1;
			}
			elsif($rock_type == 1) {
				$a{($rock_left + 1) . " " . ($rock_bottom + 2)} = 1;
				$a{($rock_left) . " " . ($rock_bottom + 1)} = 1;
				$a{($rock_left + 1) . " " . ($rock_bottom + 1)} = 1;
				$a{($rock_left + 2) . " " . ($rock_bottom + 1)} = 1;
				$a{($rock_left + 1) . " " . ($rock_bottom)} = 1;
			}
			elsif($rock_type == 2) {
				$a{($rock_left + 2) . " " . ($rock_bottom + 2)} = 1;
				$a{($rock_left + 2) . " " . ($rock_bottom + 1)} = 1;
				$a{($rock_left) . " " . ($rock_bottom)} = 1;
				$a{($rock_left + 1) . " " . ($rock_bottom)} = 1;
				$a{($rock_left + 2) . " " . ($rock_bottom)} = 1;
			}
			elsif($rock_type == 3) {
				$a{($rock_left) . " " . ($rock_bottom)} = 1;
				$a{($rock_left) . " " . ($rock_bottom + 1)} = 1;
				$a{($rock_left) . " " . ($rock_bottom + 2)} = 1;
				$a{($rock_left) . " " . ($rock_bottom + 3)} = 1;
			}
			elsif($rock_type == 4) {
				$a{($rock_left) . " " . ($rock_bottom)} = 1;
				$a{($rock_left) . " " . ($rock_bottom + 1)} = 1;
				$a{($rock_left + 1) . " " . ($rock_bottom)} = 1;
				$a{($rock_left + 1) . " " . ($rock_bottom + 1)} = 1;
			}

			last;
		} # end not moved down

	} # end while falling
	if($rock_top > $highest_rock) { $highest_rock = $rock_top; }
	#print_stack();
	#print "highest = $highest_rock\n";

}
#print_stack();

print "highest rock = $highest_rock\n";


