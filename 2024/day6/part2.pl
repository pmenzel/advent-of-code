#!/usr/bin/perl -w

use strict;
my $obstacles_in = "";

my $guard_in_x;
my $guard_in_y;
my $max_x;
my %visited;

while(<>) {
	chomp;
	$max_x = length($_) - 1;
  while(/#/g) {
  	$obstacles_in .= "," . $-[0] . " " . ($.-1) . ",";
  }
  if(/\^/) {
		$guard_in_x = $-[0];
		$guard_in_y = $. - 1;
  }
}
#print $obstacles,"\n";;
#print $.,"\n";;
my $sum = 0;


for(my $i_x = 0; $i_x <= $max_x; $i_x++) {
	for(my $i_y = 0; $i_y < $.; $i_y++) {
		next if $i_x == $guard_in_x && $i_y == $guard_in_y;
		print "Testing $i_x $i_y\n";
		my $obstacles = $obstacles_in . "," . $i_x . " " . $i_y . ",";
		my $guard_x = $guard_in_x;
		my $guard_y = $guard_in_y;

		my $dir = 1;
		my $c = 0;
		while($c <= 10000) {
			$c++;
			if($guard_y < 0 || $guard_y > $. - 1 || $guard_x < 0 || $guard_x  > $max_x) { last; }

			if($dir == 1) {  # ^
				my $field_above_y = $guard_y - 1;
				if($obstacles =~ /,$guard_x $field_above_y,/) { $dir = 2; }
				else { $guard_y--; };
			}
			elsif($dir == 2) { # >
				my $field_right_x = $guard_x + 1;
				if($obstacles =~ /,$field_right_x $guard_y,/) { $dir = 3; }
				else { $guard_x++; };
			}
			elsif($dir == 3) { # v
				my $field_below_y = $guard_y + 1;
				if($obstacles =~ /,$guard_x $field_below_y,/) { $dir = 4; }
				else { $guard_y++; };
			}
			elsif($dir == 4) { # <
				my $field_left_x = $guard_x - 1;
				if($obstacles =~ /,$field_left_x $guard_y,/) { $dir = 1; }
				else { $guard_x--; };
			}
		}
		if($c >= 10000) { $sum++; print "loop found\n"; }
	}
}
print $sum,"\n";
